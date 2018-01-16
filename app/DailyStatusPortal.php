<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Symfony\Component\DomCrawler\Crawler;

class DailyStatusPortal extends Model
{
    public function getDataInPortal($PortalHtmlParse)
    {
        // получает HTML разметку
        $html = file_get_contents($PortalHtmlParse['link']);
        // создаем новую модель кравлера
        $crawler = new Crawler(null, $PortalHtmlParse['link']);
        // добавляем ссылку в кравлер и получаем весь контент
        $crawler->addHtmlContent($html, 'UTF-8');

        // забираем циклом номера ситов
        $dataPortal['citeName'] = $crawler
            // поиск осуществляем по постаянному кусочку от класса
            ->filterXPath('//div[contains(@class,' . $PortalHtmlParse['citeNameClassParse'] . ')]')
            ->each(function (Crawler $node, $i) {
                return $node->html();
            });

        // забираем циклом значения по клиентам
        $dataPortal['clientsValue'] = $crawler
            ->filterXPath('//div[contains(@class,' . $PortalHtmlParse['clientsValueClassParse'] . ')]')
            ->each(function (Crawler $node, $i) {
                return $node->html();
            });
        /*
        // забираем циклом значения по артикулам
        $dataPortal['articleValue'] = $crawler
            ->filterXPath('//div[contains(@class, "383")]')
            ->each(function (Crawler $node, $i) {
                return $node->html();
            });

        // забираем циклом значения по обороту
        $dataPortal['CaValue'] = $crawler
            ->filterXPath('//div[contains(@class, "403")]')
            ->each(function (Crawler $node, $i) {
                return $node->html();
            });
        */

        // забираем циклом значения по обороту за период
        $dataPortal['CaPeriodValue'] = $crawler
            ->filterXPath('//div[contains(@class,' . $PortalHtmlParse['CaPeriodValueClassParse'] . ')]')
            ->each(function (Crawler $node, $i) {
                return $node->html();
            });

        return $dataPortal;
    }

    public function processingData($dataPortal)
    {
        // массив для всех ситов
        $allCiteArr = [];

        $citeName = $dataPortal['citeName'];
        $clientsValue = $dataPortal['clientsValue'];
        $CaPeriodValue = $dataPortal['CaPeriodValue'];

        /*
         *  Цикл перебирает данные по ситам $citeName, клиентам $clientsValue, артикулам $articleValue, ТО $CaValue и
         *  ТО за период $CaPeriodValue.
         *  И добавляет данные в массив $allCiteArr где ключь это номер сита, занение это данные по нему указанные выше.
         */
        foreach ($citeName as $key => $value1) {

            foreach ($clientsValue as $key2 => $value2) {
                if ($key2 == $key) {
                    $allCiteArr[$value1]['client_value'] = $value2;
                }
            }

//            // поле количество артикулов
//            foreach ($articleValue as $key3 => $value3) {
//                if ($key3 == $key) {
//                    $allCiteClassicArr[$value1]['article_value'] = $value3;
//                }
//            }
//
//            // поле продажи за предыдущий день
//            foreach ($CaValue as $key4 => $value4) {
//                if ($key4 == $key) {
//                    $allCiteClassicArr[$value1]['CA_value'] = $value4;
//                }
//            }

            foreach ($CaPeriodValue as $key5 => $value5) {
                if ($key5 == $key) {
                    $allCiteArr[$value1]['CA_period_value'] = $value5;
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
