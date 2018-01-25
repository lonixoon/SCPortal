<?php

namespace App\Http\Controllers;

use GuzzleHttp\Cookie\CookieJar;
use Illuminate\Http\Request;
use Symfony\Component\DomCrawler\Crawler;
use GuzzleHttp\Client;
use App\DailyStatusPortal;


class DailyStatusPortalController extends Controller
{
    private $user = 'XRU9210097';
//    private $user = 'rus9211689';
    private $password = 'Qazxsw123+';
//    private $password = 'Cc123123*';

// без испульзования VueJS
//    public function index()
//    {
//        $allProblemCiteArr['portal'] = $this->controlData();
//        return view('portal.daily-status-portal.daily-status-portal',  $allProblemCiteArr);
//    }
    public function apiClassic()
    {
        $DailyStatusPortal = new DailyStatusPortal();
        // получаеем данные в виде массивов СИТЫ, КЛИНТЫ, ТО ЗА ПЕРИОД
        $classicHtml = $this->PortalClassicParseHtml();
        //  выводим массив где ключ магазин, значение данные по магазину
        $allCiteClassicArr = $DailyStatusPortal->processingData($classicHtml);
        // оставляем только проблемыне и закрытые ситы
        $allProblemCiteArr['classic'] = $DailyStatusPortal->processingProblemData($allCiteClassicArr);

        return collect($allProblemCiteArr);
    }

    public function apiAtak()
    {
        $DailyStatusPortal = new DailyStatusPortal();
        // получаеем данные в виде массивов СИТЫ, КЛИНТЫ, ТО ЗА ПЕРИОД
        $atakHtml = $this->PortalAtakParseHtml();
        //  выводим массив где ключ магазин, значение данные по магазину
        $allCiteAtakArr = $DailyStatusPortal->processingData($atakHtml);
        // оставляем только проблемыне и закрытые ситы
        $allProblemCiteArr['atak'] = $DailyStatusPortal->processingProblemData($allCiteAtakArr);

        return collect($allProblemCiteArr);
    }

    /*
     * Упарвляющая функция
     */
    // без испульзования VueJS
//    public function controlData()
//    {
//        $DailyStatusPortal = new DailyStatusPortal();
//        // получаеем данные в виде массивов СИТЫ, КЛИНТЫ, ТО ЗА ПЕРИОД
//        $classicHtml = $this->PortalClassicParseHtml();
//        $atakHtml = $this->PortalAtakParseHtml();
//
//        //  выводим массив где ключ магазин, значение данные по магазину
//        $allCiteClassicArr = $DailyStatusPortal->processingData($classicHtml);
//        $allCiteAtakArr = $DailyStatusPortal->processingData($atakHtml);
//
//        // оставляем только проблемыне и закрытые ситы
//        $allProblemCiteArr['Classic'] = $DailyStatusPortal->processingProblemData($allCiteClassicArr);
//        $allProblemCiteArr['Atak'] = $DailyStatusPortal->processingProblemData($allCiteAtakArr);
//
//        return $allProblemCiteArr;
//
//        // временная разметка таблицей
////        echo '<div style="display: inline-flex">';
////        foreach ($allProblemCiteArr as $portalName => $portalData) {
////            echo '<div style="margin-right: 40px"><h3>' . $portalName . '</h3><table border="2">';
////            foreach ($portalData as $citeNme => $status) {
////                echo '<tr><td>' . $citeNme . '</td><td>' . $status . '</td></tr>';
////            }
////            echo '</table></div>';
////        }
////        echo '</div>';
//    }


    /*
     *  Получаем значение нужных нам полей из таблицы
     */
    public function PortalClassicParseHtml()
    {
        $PortalClassicHtmlParse = [
            // страница с контентом после авторизации
            'link' => 'http://w7ru09990004/daily-status-portal/portal-classic',
            // классы по которым парсим контент
            'citeNameClassParse' => '371',
            'clientsValueClassParse' => '375',
            'articleValueClassParse' => '383',
            'CaValueClassParse' => '403',
            'CaPeriodValueClassParse' => '415',
        ];
        $DailyStatusPortal = new DailyStatusPortal();
        $dataPortal = $DailyStatusPortal->getDataInPortal($PortalClassicHtmlParse);
        return $dataPortal;
    }


    /*
     *  Получаем значение нужных нам полей из таблицы
     */
    public function PortalAtakParseHtml()
    {
        $PortalAtakHtmlParse = [
            // страница с контентом после авторизации
            'link' => 'http://w7ru09990004/daily-status-portal/portal-atak',
            // классы по которым парсим контент
            'citeNameClassParse' => '336',
            'clientsValueClassParse' => '368',
            'articleValueClassParse' => '376',
            'CaValueClassParse' => '340',
            'CaPeriodValueClassParse' => '352',
        ];
        $DailyStatusPortal = new DailyStatusPortal();
        $dataPortal = $DailyStatusPortal->getDataInPortal($PortalAtakHtmlParse);
        return $dataPortal;
    }


    /*
     * Получаем Portal Classic в виде HTML страницы
     */
    public function getPortalClassicHtml()
    {
        $PortalClassicHtmlGetAuth = [
            // ссылка на базовую страницу
            'link' => 'http://portal.ru.auchan.com/portal/',
            // токены
//            'tokenViewsState' => '/wEPDwUJMzgzMzg4MjUwD2QWAgIDD2QWCmYPDxYCHgRUZXh0BQrQm9C+0LPQuNC9ZGQCAg8PFgIfAAUM0J/QsNGA0L7Qu9GMZGQCBA8PFgIfAAUI0K/Qt9GL0LpkZAIFDxBkZBYBZmQCBg8WAh4FdmFsdWUFCNCS0YXQvtC0ZGQniGTj7tOUIsgb60FVI4XE91+HLQ==',
//            'tokenEvanValidation' => '/wEWCQKAufxaAq+m6rYIAvK94JEPAvn6+RsCyYGW8wICjo+S1wQCgtyHhgwC7c2/agL6r+qNDFf2caYpL6FwNpwNbTiwK+9t04HV',
        ];
        // передаем данные для получения в функция для получения отчёта
        $xml = $this->getAuthAndReport($PortalClassicHtmlGetAuth);
        return $xml;
    }


    /*
     * Получаем Portal АТАК в виде HTML страницы
     */
    public function getPortalAtakHtml()
    {
        $PortalAtakHtmlGetAuth = [
            // ссылка на базовую страницу
            'link' => 'http://146.240.224.178/Portal/',
            // токены
//            'tokenViewsState' => '/wEPDwUKMTg2MTIxMjgxMQ9kFgICAw9kFg5mDw8WAh4EVGV4dAUK0JvQvtCz0LjQvWRkAgIPDxYCHwAFDNCf0LDRgNC+0LvRjGRkAgMPD2QWAh4Kb25rZXlwcmVzcwUmcmV0dXJuIGNvbnRyb2xFbnRlcignYnRuRW50ZXInLCBldmVudClkAgQPDxYCHwAFCNCv0LfRi9C6ZGQCCg8QZBAVBQ7QoNGD0YHRgdC60LjQuQdFbmdsaXNoCUZyYW7Dp2FpcwhSb21hbmlhbhTQo9C60YDQsMOv0L3RgdGM0LrQsBUFBXJ1LVJVBWVuLVVTBWZyLUZSBXJvLVJPBXVrLVVBFCsDBWdnZ2dnFgFmZAILDw8WAh8ABQjQktGF0L7QtGRkAgwPDxYCHwAFKNCd0LXQstC10YDQvdGL0Lkg0LvQvtCz0LjQvS/Qv9Cw0YDQvtC70YxkZBgBBR5fX0NvbnRyb2xzUmVxdWlyZVBvc3RCYWNrS2V5X18WBQUJaW1nUnVzc2lhBQVpbWdVSwUJaW1nRnJhbmNlBQppbWdSb21hbmlhBQppbWdVa3JhaW5lId0ULP2sBh99ZTUPCbLcHHDzsz4=',
//            'tokenEvanValidation' => '/wEWEQKc+Jw0Aq+m6rYIAvK94JEPArjo2tYOAo/JydQDAt6ZlIcMAoSA8r8NAoWB7pcKAvn6+RsCyYGW8wIC5Iz21QgCjo+S1wQC74G+xQICwoHiyggCl7fA+AEC7c2/agL6r+qNDIiMhxLvRMZeiUpVPXlMCzJNNHnK',
        ];
        // передаем данные для получения в функция для получения отчёта
        $xml = $this->getAuthAndReport($PortalAtakHtmlGetAuth);
        return $xml;
    }

    /*
     *  Авторизация и получение всего HTML
     */
    public function getAuthAndReport($PortalHtmlGetAuth)
    {
        $client = new Client([
            // Base URI is used with relative requests
            'base_uri' => $PortalHtmlGetAuth['link'],
            // You can set any number of default request options.
            'timeout' => 60.0,
        ]);
        $cookieJar = new CookieJar();

        $htmlLogin = $client->request('GET', '')->getBody()->getContents();
        $tokenAuth = $this->getToken($htmlLogin);

        $client->request('POST', 'Login.aspx', [
                'form_params' => [
                    '__EVENTTARGET' => '',
                    '__EVENTARGUMENT' => '',
                    '__LASTFOCUS' => '',
//                    '__VIEWSTATE' => $PortalHtmlGetAuth['tokenViewsState'],
//                    '__EVENTVALIDATION' => $PortalHtmlGetAuth['tokenEvanValidation'],
                    '__VIEWSTATE' => $tokenAuth['viewState'],
                    '__EVENTVALIDATION' => $tokenAuth['eventValidation'],
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
                ]
            ]
        );

        $response = $client->get('pg412100.aspx', ['cookies' => $cookieJar]);
        $xml = $response->getBody()->getContents();
        return $xml;
    }

    public function getToken($html)
    {
        $crawler = new Crawler();
        $crawler->addHtmlContent($html, 'UTF-8');
        $token['viewState'] = $crawler->filterXPath('//input[@id="__VIEWSTATE"]')->attr('value');
        $token['eventValidation'] = $crawler->filterXPath('//input[@id="__EVENTVALIDATION"]')->attr('value');
        return $token;
    }
}
