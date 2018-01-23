<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Symfony\Component\DomCrawler\Crawler;

class DailyStatusAdminPortal extends Model
{
    public function getDataInAdminPortal($html, array $tegParse)
    {
        // создаем новую модель кравлера
        $crawler = new Crawler();
        // добавляем ссылку в кравлер и получаем весь контент
        $crawler->addHtmlContent($html, 'UTF-8');

        // забираем циклом номера ситов
        $dataAdminPortal['showcaseName'] = $crawler
            // поиск осуществляем по постаянному кусочку от класса
            ->filterXPath('//a[contains(@id,"' . $tegParse['showcaseName'] . '")]')
            ->each(function (Crawler $node, $i) {
                return $node->text();
            });

        //забираем циклом значения по клиентам
        $dataAdminPortal['showcaseStatus'] = $crawler
            ->filterXPath('//span[contains(@id,"' . $tegParse['showcaseStatus'] . '")]')
            ->each(function (Crawler $node, $i) {
                return $node->text();
            });
        dd($dataAdminPortal);

        return $dataAdminPortal;
    }

    public function processingData($dataPortal)
    {
        // массив для всех ситов
        $allCiteArr = [];

        $citeName = $dataPortal['showcaseName'];
        $clientsValue = $dataPortal['showcaseStatus'];

        /*
         *  Цикл перебирает данные по ситам $citeName, клиентам $clientsValue, артикулам $articleValue, ТО $CaValue и
         *  ТО за период $CaPeriodValue.
         *  И добавляет данные в массив $allCiteArr где ключь это номер сита, занение это данные по нему указанные выше.
         */
        foreach ($citeName as $key => $value1) {

            foreach ($clientsValue as $key2 => $value2) {
                if ($key2 == $key) {
                    $allCiteArr[$value1] = $value2;
                }
            }
        }

        return $allCiteArr;
    }

    public function processingProblemData($allCiteArr)
    {
        // общий массив для ситов
        $problemCite = [];

        /*
         *  Перебираем $allCiteArr и ищем отсутвующие ТО за период, что бы определить закрыт или нет магазин
         */
        foreach ($allCiteArr as $key => $value) {
            foreach ($value as $key2 => $value2) {
                // условие для закрытых магазов где нет данных
                if ($key2 == 'CA_period_value' && $value2 == '*****') {
                    $problemCite[$key] = 'Close';

                    // условие для открытых магазов где нет данных
                } elseif ($value2 == '*****') {
                    $problemCite[$key] = 'No data';
                }
            }
        }

        // отсортируем масив, что бы No data были сверху Close внизу
        arsort($problemCite);

        return $problemCite;

        /*
         *  Перебираем массив по открытым магазам где нет данных и если они есть выводим их
         */
//        foreach ($problemCiteArr as $key => $value) {
//            // условие для открытых магазов где нет данных
//            if ($value == 'No data') {
//                $problemOpenCiteClassicArr[$key] = $value;
//
//            // если таких нет, все ок!
//            } elseif ($value != 'No data') {
//                $problemOpenCiteClassicArr['Other Site'] = 'Data OK!';
//            }
//        }
    }
}
