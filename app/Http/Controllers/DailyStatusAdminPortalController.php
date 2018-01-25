<?php

namespace App\Http\Controllers;

use App\DailyStatusAdminPortal;
use GuzzleHttp\Cookie\CookieJar;
use Illuminate\Http\Request;
use Symfony\Component\DomCrawler\Crawler;
use GuzzleHttp\Client;


class DailyStatusAdminPortalController extends Controller
{
    private $user = 'rus9211689';
    private $password = 'Cc123123*';

    public function getAdminPortalClassicHtml()
    {
        $PortalAtakHtmlGetAuth = [
            // ссылка на базовую страницу
            'link' => 'http://portal.ru.auchan.com/iradmin2/'
        ];

        $tegParse = [
            'showcaseName' => 'Name',
            'showcaseStatus' => '_lblStatus',
        ];

        // передаем данные для получения в функция для получения отчёта
        $xml = $this->getPortalAdminAuth($PortalAtakHtmlGetAuth);
        $parseHtml = new DailyStatusAdminPortal();
        $showcase = $parseHtml->getDataInAdminPortal($xml, $tegParse);
        $result['lists'] = $parseHtml->processingData($showcase);
        return $result;
    }

    public function getAdminPortalAtakHtml()
    {
        $PortalAtakHtmlGetAuth = [
            // ссылка на базовую страницу
            'link' => 'http://146.240.224.178/iradmin2/'
        ];

        $tegParse = [
            'showcaseName' => 'Name',
            'showcaseStatus' => '_lblStatus',
        ];


        // передаем данные для получения в функция для получения отчёта
        $xml = $this->getPortalAdminAuth($PortalAtakHtmlGetAuth);
        $parseHtml = new DailyStatusAdminPortal();
        $showcase = $parseHtml->getDataInAdminPortal($xml, $tegParse);
        $result['lists'] = $parseHtml->processingData($showcase);
        return $result;
    }

    /*
     * Авторизация и получение всего HTML Портала Админ
     */
    public function getPortalAdminAuth($PortalHtmlGetAuth)
    {
        $client = new Client([
            // Base URI is used with relative requests
            'base_uri' => $PortalHtmlGetAuth['link'],
            // You can set any number of default request options.
            'timeout' => 60.0,
        ]);
        $cookieJar = new CookieJar();

        $htmlLogin = $client->request('GET', '')->getBody()->getContents();

        // получаем токены
        $tokenAuth = $this->getToken($htmlLogin);

        $client->request('POST', 'login.aspx', [
                'form_params' => [
                    '__VIEWSTATE' => $tokenAuth['viewState'],
                    '__EVENTVALIDATION' => $tokenAuth['eventValidation'],
                    'username' => $this->user,
                    'password' => $this->password,
                ],
                'cookies' => $cookieJar,
            ]
        );

        $htmlForm = $client->request('GET', 'ADRequest/Requests.aspx', ['cookies' => $cookieJar])
            ->getBody()->getContents();

        // получаем токены
        $tokenForm = $this->getToken($htmlForm);

        // передаем дату в форму
        $date['main'] = date("m.Y");
        $date['today'] = date("d");
        $date['previousDay'] = date("d") - 1;
        // делаем формат ПРИМЕР! '28.03.2018 18:00'
        $previousDay = $date['previousDay'] . '.' . $date['main'] . ' 18:00';
        $today = $date['today'] . '.' . $date['main'] . ' 23:59';


        $response = $client->request('POST', 'ADRequest/Requests.aspx',
            [
                'form_params' => [
                    '__EVENTTARGET' => '',
                    '__EVENTARGUMENT' => '',
                    '__LASTFOCUS' => '',
                    '__VIEWSTATE' => $tokenForm['viewState'],
                    '__EVENTVALIDATION' => $tokenForm['eventValidation'],
                    'ddlTopFilter' => '-',
                    'txtRequestId' => '',
                    'ddlOprType' => '2',
                    'ddlPhase' => '-1',
                    'txtRequestName' => '',
                    'ddlOperationType' => '-1',

                    // статус витрин (1 : Ошибка), (-1 : НЕ ОТПРАВЛЯТЬ!!)
//                    'ddlStatus' => '1',
                    'txtRequestDataSubmitedStart' => $previousDay,
                    'txtRequestDataSubmitedEnd' => $today,
                    'ddlUser' => '-1',
                    'ddlTypes' => 'Любой',
                    'txtDateExecutedStart' => '',
                    'txtDateExecutedEnd' => '',
                    'ddlServers' => '',
                    'txtParamLike' => '',
                    'btnApplyFilter' => 'Выбрать',
                ],
                'cookies' => $cookieJar
            ]
        )->getBody()->getContents();

        return $response;
    }


    // получения токена для отправки формы
    public function getToken($html)
    {
        $crawler = new Crawler();
        $crawler->addHtmlContent($html, 'UTF-8');
        $token['viewState'] = $crawler->filterXPath('//input[@id="__VIEWSTATE"]')->attr('value');
        $token['eventValidation'] = $crawler->filterXPath('//input[@id="__EVENTVALIDATION"]')->attr('value');
        return $token;
    }
}
