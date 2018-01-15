<?php

namespace App;

use App\Http\Controllers\DailyStatusPortalController;
use Illuminate\Database\Eloquent\Model;
use Symfony\Component\DomCrawler\Crawler;

class DailyStatusPortal extends Model
{
    public function getDataInPortal($link, $citeNameClass, $clientsValueClass , $CaPeriodValueClass)
    {
        // получает HTML разметку
        $html = file_get_contents($link);
        // создаем новую модель кравлера
        $crawler = new Crawler(null, $link);
        // добавляем ссылку в кравлер и получаем весь контент
        $crawler->addHtmlContent($html, 'UTF-8');

        // забираем циклом номера ситов
        $dataPortal['citeName'] = $crawler
            // поиск осуществляем по постаянному кусочку от класса
            ->filterXPath("//div[contains(@class, $citeNameClass)]")
            ->each(function (Crawler $node, $i) {
                return $node->html();
            });

        // забираем циклом значения по клиентам
        $dataPortal['clientsValue'] = $crawler
            ->filterXPath("//div[contains(@class, $clientsValueClass)]")
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
            ->filterXPath("//div[contains(@class, $CaPeriodValueClass)]")
            ->each(function (Crawler $node, $i) {
                return $node->html();
            });

        return $dataPortal;
    }

    public function processingData()
    {
        // массив для всех ситов классики
        $allCiteClassicArr = [];
        // массив для всех ситов атака
        $allCiteAtakArr = [];
        // массив для всех ситов где нет данных по классики
        $problemCiteClassicArr = [];
        // массив для всех ситов где нет данных по атак
        $problemCiteAtakArr = [];
        // массив для всех ситов где нет данных но есть данные за период
        $problemOpenCiteClassicArr = [];
        // массив для всех ситов где нет данных но есть данные за период
        $problemOpenCiteAtakArr = [];

        // передаём получитный HTML для обработки данных
        $DailyStatusPortalController = new DailyStatusPortalController();
        $dataPortalClassic = $DailyStatusPortalController->PortalClassicParseHtml();
        $dataPortalAtak = $DailyStatusPortalController->PortalAtakParseHtml();

        $citeNameClassic = $dataPortalClassic['citeName'];
        $clientsValueClassic = $dataPortalClassic['clientsValue'];
        $CaPeriodValueClassic = $dataPortalClassic['CaPeriodValue'];

        $citeNameAtak = $dataPortalAtak['citeName'];
        $clientsValueAtak = $dataPortalAtak['clientsValue'];
        $CaPeriodAtak = $dataPortalAtak['CaPeriodValue'];

        /*
         *  Цикл перебирает данные по ситам $citeNameClassic, клиентам $clientsValueClassic, артикулам $articleValue, ТО $CaValue и
         *  ТО за период $CaPeriodValueClassic.
         *  И добавляет данные в массив $allCiteClassicArr где ключь это номер сита, занение это данные по нему указанные выше.
         */
        foreach ($citeNameClassic as $key => $value1) {

            foreach ($clientsValueClassic as $key2 => $value2) {
                if ($key2 == $key) {
                    $allCiteClassicArr[$value1]['client_value'] = $value2;
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

            foreach ($CaPeriodValueClassic as $key5 => $value5) {
                if ($key5 == $key) {
                    $allCiteClassicArr[$value1]['CA_period_value'] = $value5;
                }
            }
        };


        /*
         *  Цикл перебирает данные по ситам $citeNameClassic, клиентам $clientsValueClassic, артикулам $articleValue, ТО $CaValue и
         *  ТО за период $CaPeriodValueClassic.
         *  И добавляет данные в массив $allCiteClassicArr где ключь это номер сита, занение это данные по нему указанные выше.
         */
        foreach ($citeNameAtak as $key => $value1) {

            foreach ($clientsValueAtak as $key2 => $value2) {
                if ($key2 == $key) {
                    $allCiteAtakArr[$value1]['client_value'] = $value2;
                }
            }

//            // поле количество артикулов
//            foreach ($articleValue2 as $key3 => $value3) {
//                if ($key3 == $key) {
//                    $allCiteAtakArr[$value1]['article_value'] = $value3;
//                }
//            }
//
//            // поле продажи за предыдущий день
//            foreach ($CaValue2 as $key4 => $value4) {
//                if ($key4 == $key) {
//                    $allCiteAtakArr[$value1]['CA_value'] = $value4;
//                }
//            }

            foreach ($CaPeriodAtak as $key5 => $value5) {
                if ($key5 == $key) {
                    $allCiteAtakArr[$value1]['CA_period_value'] = $value5;
                }
            }
        };

        /*
         *  Перебираем $allCiteClassicArr и ищем отсутвующие ТО за период, что бы определить закрыт или нет магазин
         */
        foreach ($allCiteClassicArr as $key => $value) {
            foreach ($value as $key2 => $value2) {
                // условие для закрытых магазов где нет данных
                if ($key2 == 'CA_period_value' && $value2 == '*****') {
                    $problemCiteClassicArr[$key] = 'Close';

                    // условие для открытых магазов где нет данных
                } elseif ($value2 == '*****') {
                    $problemCiteClassicArr[$key] = 'No data';
                }
            }
        }


        /*
         *  Перебираем $allCiteAtakArr и ищем отсутвующие ТО за период, что бы определить закрыт или нет магазин
         */
        foreach ($allCiteAtakArr as $key => $value) {
            foreach ($value as $key2 => $value2) {
                // условие для закрытых магазов где нет данных
                if ($key2 == 'CA_period_value' && $value2 == '*****') {
                    $problemCiteAtakArr[$key] = 'Close';

                    // условие для открытых магазов где нет данных
                } elseif ($value2 == '*****') {
                    $problemCiteAtakArr[$key] = 'No data';
                }
            }
        }

        dump($problemCiteClassicArr);
        dump($problemCiteAtakArr);

        /*
         *  КЛАСИКА Перебираем массив по открытым магазам где нет данных и если они есть выводим их
         */
//        foreach ($problemCiteClassicArr as $key => $value) {
//            // условие для открытых магазов где нет данных
//            if ($value == 'No data') {
//                $problemOpenCiteClassicArr[$key] = $value;
//
//            // если таких нет, все ок!
//            } elseif ($value != 'No data') {
//                $problemOpenCiteClassicArr['Other Site'] = 'Data OK!';
//            }
//        }

        /*
         *  АТАК Перебираем массив по открытым магазам где нет данных и если они есть выводим их
         */
//        foreach ($problemCiteAtakArr as $key => $value) {
//            // условие для открытых магазов где нет данных
//            if ($value == 'No data') {
//                $problemOpenCiteAtakArr[$key] = $value;
//
//            // если таких нет, все ок!
//            } elseif ($value != 'No data') {
//                $problemOpenCiteAtakArr['Other Site'] = 'Data OK!';
//            }
//        }
    }
}
