<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Symfony\Component\DomCrawler\Crawler;

class DailyStatusPortal extends Model
{
    /*
     * в переданном html ищем нужные поля и сохраняем их в массивы
     * получаем html и еги для поиска, возвращаем массивы с данными
     */
    public function getDataInPortal($html, $tegParse)
    {
        // создаем новую модель кравлера
        $crawler = new Crawler();
        // добавляем ссылку в кравлер и получаем весь контент
        $crawler->addHtmlContent($html, 'UTF-8');

        // забираем циклом номера ситов
        $dataPortal['citeName'] = $crawler
            // поиск осуществляем по постаянному кусочку от класса
            ->filterXPath('//div[contains(@class,"' . $tegParse['citeNameClassParse'] . '")]')
            ->each(function (Crawler $node, $i) {
                return $node->text();
            });

        // забираем циклом значения по клиентам
        $dataPortal['clientsValue'] = $crawler
            ->filterXPath('//div[contains(@class,"' . $tegParse['clientsValueClassParse'] . '")]')
            ->each(function (Crawler $node, $i) {
                return $node->text();
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
            ->filterXPath('//div[contains(@class,"' . $tegParse['CaPeriodValueClassParse'] . '")]')
            ->each(function (Crawler $node, $i) {
                return $node->text();
            });

        // возвращаем массивы с данными
        return $dataPortal;
    }


    /*
     *  Передаём массивы с данными, получаем массив: Магазин => [Клинеты, ТО за период]
     */
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
        foreach ($citeName as $indexCite => $cite) {

            foreach ($clientsValue as $indexClient => $client) {
                if ($indexClient == $indexCite) {
                    $allCiteArr[$cite]['client_value'] = $client;
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

            foreach ($CaPeriodValue as $indexCaPeriod => $caPeriod) {
                if ($indexCaPeriod == $indexCite) {
                    $allCiteArr[$cite]['CA_period_value'] = $caPeriod;
                }
            }
        }

        return $allCiteArr;
    }


    /*
     * Принемает массив Магазин => [Клинеты, ТО за период], возвращает массив Магазин => Статус
     */
    public function processingProblemData($allCiteArr)
    {
        // общий массив для ситов
        $problemCite = [];

        // Перебираем $allCiteArr и ищем отсутвующие ТО за период, что бы определить закрыт или нет магазин

        foreach ($allCiteArr as $cite => $value) {
            foreach ($value as $key2 => $value2) {
                // условие для закрытых магазов где нет данных
                if ($key2 == 'CA_period_value' && $value2 == '*****') {
                    $problemCite[$cite] = 'Close';

                    // условие для открытых магазов где нет данных
                } elseif ($value2 == '*****') {
                    $problemCite[$cite] = 'No data';
                }
            }
        }

        // отсортируем масив, что бы No data были сверху Close внизу
        arsort($problemCite);

        return $problemCite;
    }


    /*
     * Получения токена для формы
     * Примает html, взващает массив с двуми токенами
     */
    public function getToken($html)
    {
        $crawler = new Crawler();
        // передаём html в кравлер
        $crawler->addHtmlContent($html, 'UTF-8');
        // получаем первый токен
        $token['viewState'] = $crawler->filterXPath('//input[@id="__VIEWSTATE"]')->attr('value');
        // получаем второй токен
        $token['eventValidation'] = $crawler->filterXPath('//input[@id="__EVENTVALIDATION"]')->attr('value');
        // возващаяем массив с двумя токенами
        return $token;
    }
}
