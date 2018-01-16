<?php

namespace App\Http\Controllers;

use GuzzleHttp\Cookie\CookieJar;
use Illuminate\Http\Request;
use Symfony\Component\DomCrawler\Crawler;
use GuzzleHttp\Client;
use App\DailyStatusPortal;


class DailyStatusPortalControllerCOPY3 extends Controller
{
    public $user = 'rus9211689';
    public $password = 'Cc123123*';

    public function index()
    {
        // получаеем данные в виде массивов СИТЫ, КЛИНТЫ, ТО ЗА ПЕРИОД
        $classic = $this->PortalClassicParseHtml();
        $atak = $this->PortalAtakParseHtml();

        // Обрабатываем массивы и оставляем только проблемыне и закрытые ситы
        $result['Classic'] = $this->processingData($classic);
        $result['Atak'] = $this->processingData($atak);
        dump($result);
    }

    public function PortalClassicParseHtml()
    {
        $PortalClassicHtmlParse = [
            'linkAuth' => 'http://w7ru09990004/daily-status-portal/portal-classic',
            'citeNameClassParse' => '371',
            'clientsValueClassParse' => '375',
//            'articleValueClassParse' => '383',
//            'CaValueClassParse' => '403',
            'CaPeriodValueClassParse' => '415',
        ];
        // ссылка на сайт с пройденой авторизацией
        $link = 'http://w7ru09990004/daily-status-portal/portal-classic';
        // постоянный кусочек css класса поля Ситы
        $citeNameClass = '371';
        // постоянный кусочек css класса поля Клиенты
        $clientsValueClass = '375';
        // постоянный кусочек css класса поля ТО за период
        $CaPeriodValueClass = '415';

//        // постоянный кусочек css класса поля кол-во артикулов
//        $articleValue = '383';
//        // постоянный кусочек css класса поля Товарооборота
//        $CaValue = '403';

        $dataPortal = $this->getDataInPortal($link, $citeNameClass, $clientsValueClass , $CaPeriodValueClass);
        return $dataPortal;
    }

    public function PortalAtakParseHtml()
    {
        $PortalClassicHtmlParse = [
            'linkAuth' => 'http://w7ru09990004/daily-status-portal/portal-atak',
            'citeNameClassParse' => '336',
            'clientsValueClassParse' => '368',
//            'articleValueClassParse' => '376',
//            'CaValueClassParse' => '340',
            'CaPeriodValueClassParse' => '352',
        ];

        $link = 'http://w7ru09990004/daily-status-portal/portal-atak';
        $citeNameClass = '336';
        $clientsValueClass = '368';
        $CaPeriodValueClass = '352';

//        // постоянный кусочек css класса поля кол-во артикулов
//        $articleValue = '376';
//        // постоянный кусочек css класса поля Товарооборота
//        $CaValue = '340';

        $dataPortal = $this->getDataInPortal($link, $citeNameClass, $clientsValueClass , $CaPeriodValueClass);
        return $dataPortal;
    }


    /*
     * Получаем отчёты PortalClassic в виде HTML страницы
     */
    public function getPortalClassicHtml()
    {
        $PortalClassicHtmlGetAuth = [
            'link' => 'http://portal.ru.auchan.com/portal/',
            'viewsState' => '/wEPDwUJMzgzMzg4MjUwD2QWAgIDD2QWCmYPDxYCHgRUZXh0BQrQm9C+0LPQuNC9ZGQCAg8PFgIfAAUM0J/QsNGA0L7Qu9GMZGQCBA8PFgIfAAUI0K/Qt9GL0LpkZAIFDxBkZBYBZmQCBg8WAh4FdmFsdWUFCNCS0YXQvtC0ZGQniGTj7tOUIsgb60FVI4XE91+HLQ==',
            'evanValidation' => '/wEWCQKAufxaAq+m6rYIAvK94JEPAvn6+RsCyYGW8wICjo+S1wQCgtyHhgwC7c2/agL6r+qNDFf2caYpL6FwNpwNbTiwK+9t04HV',
        ];

        // сслыка на приложение
        $link = 'http://portal.ru.auchan.com/portal/';
        // первый токен формы
        $viewsState = '/wEPDwUJMzgzMzg4MjUwD2QWAgIDD2QWCmYPDxYCHgRUZXh0BQrQm9C+0LPQuNC9ZGQCAg8PFgIfAAUM0J/QsNGA0L7Qu9GMZGQCBA8PFgIfAAUI0K/Qt9GL0LpkZAIFDxBkZBYBZmQCBg8WAh4FdmFsdWUFCNCS0YXQvtC0ZGQniGTj7tOUIsgb60FVI4XE91+HLQ==';
        // второй токен формы
        $evanValidation = '/wEWCQKAufxaAq+m6rYIAvK94JEPAvn6+RsCyYGW8wICjo+S1wQCgtyHhgwC7c2/agL6r+qNDFf2caYpL6FwNpwNbTiwK+9t04HV';

        // передаем данные для получения в функция для получения отчёта
        $xml = $this->getAuthAndReport($link, $viewsState, $evanValidation);
        return $xml;
    }


    /*
     * Получаем отчёты Portal АТАК в виде HTML страницы
     */
    public function getPortalAtakHtml()
    {
        $PortalAtakHtmlGetAuth = [
            'link' => 'http://146.240.224.178/Portal/',
            'tokenViewsState' => '/wEPDwUKMTg2MTIxMjgxMQ9kFgICAw9kFg5mDw8WAh4EVGV4dAUK0JvQvtCz0LjQvWRkAgIPDxYCHwAFDNCf0LDRgNC+0LvRjGRkAgMPD2QWAh4Kb25rZXlwcmVzcwUmcmV0dXJuIGNvbnRyb2xFbnRlcignYnRuRW50ZXInLCBldmVudClkAgQPDxYCHwAFCNCv0LfRi9C6ZGQCCg8QZBAVBQ7QoNGD0YHRgdC60LjQuQdFbmdsaXNoCUZyYW7Dp2FpcwhSb21hbmlhbhTQo9C60YDQsMOv0L3RgdGM0LrQsBUFBXJ1LVJVBWVuLVVTBWZyLUZSBXJvLVJPBXVrLVVBFCsDBWdnZ2dnFgFmZAILDw8WAh8ABQjQktGF0L7QtGRkAgwPDxYCHwAFKNCd0LXQstC10YDQvdGL0Lkg0LvQvtCz0LjQvS/Qv9Cw0YDQvtC70YxkZBgBBR5fX0NvbnRyb2xzUmVxdWlyZVBvc3RCYWNrS2V5X18WBQUJaW1nUnVzc2lhBQVpbWdVSwUJaW1nRnJhbmNlBQppbWdSb21hbmlhBQppbWdVa3JhaW5lId0ULP2sBh99ZTUPCbLcHHDzsz4=',
            'tokenEvanValidation' => '/wEWEQKc+Jw0Aq+m6rYIAvK94JEPArjo2tYOAo/JydQDAt6ZlIcMAoSA8r8NAoWB7pcKAvn6+RsCyYGW8wIC5Iz21QgCjo+S1wQC74G+xQICwoHiyggCl7fA+AEC7c2/agL6r+qNDIiMhxLvRMZeiUpVPXlMCzJNNHnK',
        ];
        // сслыка на приложение
        $link = 'http://146.240.224.178/Portal/';
        // первый токен формы
        $viewsState = '/wEPDwUKMTg2MTIxMjgxMQ9kFgICAw9kFg5mDw8WAh4EVGV4dAUK0JvQvtCz0LjQvWRkAgIPDxYCHwAFDNCf0LDRgNC+0LvRjGRkAgMPD2QWAh4Kb25rZXlwcmVzcwUmcmV0dXJuIGNvbnRyb2xFbnRlcignYnRuRW50ZXInLCBldmVudClkAgQPDxYCHwAFCNCv0LfRi9C6ZGQCCg8QZBAVBQ7QoNGD0YHRgdC60LjQuQdFbmdsaXNoCUZyYW7Dp2FpcwhSb21hbmlhbhTQo9C60YDQsMOv0L3RgdGM0LrQsBUFBXJ1LVJVBWVuLVVTBWZyLUZSBXJvLVJPBXVrLVVBFCsDBWdnZ2dnFgFmZAILDw8WAh8ABQjQktGF0L7QtGRkAgwPDxYCHwAFKNCd0LXQstC10YDQvdGL0Lkg0LvQvtCz0LjQvS/Qv9Cw0YDQvtC70YxkZBgBBR5fX0NvbnRyb2xzUmVxdWlyZVBvc3RCYWNrS2V5X18WBQUJaW1nUnVzc2lhBQVpbWdVSwUJaW1nRnJhbmNlBQppbWdSb21hbmlhBQppbWdVa3JhaW5lId0ULP2sBh99ZTUPCbLcHHDzsz4=';
        // второй токен формы
        $evanValidation = '/wEWEQKc+Jw0Aq+m6rYIAvK94JEPArjo2tYOAo/JydQDAt6ZlIcMAoSA8r8NAoWB7pcKAvn6+RsCyYGW8wIC5Iz21QgCjo+S1wQC74G+xQICwoHiyggCl7fA+AEC7c2/agL6r+qNDIiMhxLvRMZeiUpVPXlMCzJNNHnK';

        // передаем данные для получения в функция для получения отчёта
        $xml = $this->getAuthAndReport($link, $viewsState, $evanValidation);
        return $xml;
    }


    /*
     *  Авторизация и получение отчётов в HTML
     */
    public function getAuthAndReport($link, $viewsState, $evanValidation)
    {
        $client = new Client([
            // Base URI is used with relative requests
            'base_uri' => $link,
            // You can set any number of default request options.
            'timeout' => 60.0,
        ]);
        $cookieJar = new CookieJar();

        $client->request('POST', 'Login.aspx', [
                'form_params' => [
                    '__EVENTTARGET' => '',
                    '__EVENTARGUMENT' => '',
                    '__LASTFOCUS' => '',
                    '__VIEWSTATE' => $viewsState,
                    '__EVENTVALIDATION' => $evanValidation,
                    'username' => $this->user,
                    'password' => $this->password,
                    'ddlLanguage' => 'ru-RU',
                    'btnLogin' => 'Вход',
                    'btnEnter' => 'Вход',
                    'hidscreenWidth' => '',
                    'hidscreenHeight' => '',
                ],
                'cookies' => $cookieJar,
                'headers' => [
                    'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36',
                ],
//                'allow_redirects' => true,
            ]
        );


        $response = $client->get('pg412100.aspx', ['cookies' => $cookieJar]);
        $xml = $response->getBody()->getContents();
        return $xml;
    }


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

        public function processingData($dataPortal)
    {
        // массив для всех ситов
        $allCiteArr = [];
        // общий массив для ситов
        $problemCite = [];

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

        /*
         *  Перебираем $allCiteClassicArr и ищем отсутвующие ТО за период, что бы определить закрыт или нет магазин
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
        return $problemCite;

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
    }
}
