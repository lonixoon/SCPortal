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


    /*
     * Главная упавляющаая функция, получает данные Портал Админ Классика в виде массива Витрина => Статус
     */
    public function indexAdminPortalClassic()
    {
        $DailyStatusAdminPortal = new DailyStatusAdminPortal();
        // ссылка на базовую страницу
        $link = [
            'link' => 'http://portal.ru.auchan.com/iradmin2/'
        ];

        // передаём ссылку на сайт, получаем html нужной страницы
        $html = $this->getPortalAdminAuth($link);
        // передаём html, получаем два массива: 1) витрины 2) статусы
        $showcase = $DailyStatusAdminPortal->getDataInAdminPortal($html);
        // передаём 1) витрины 2) статусы, получаем массив: витрина => статус
        $showcaseResult['lists'] = $DailyStatusAdminPortal->processingData($showcase);
        // возвращаем массив: витрина => статус
        return $showcaseResult;
    }


    /*
     * Главная упавляющаая функция, получает данные Портал Админ Атак в виде массива Витрина => Статус
     */
    public function indexAdminPortalAtak()
    {
        $DailyStatusAdminPortal = new DailyStatusAdminPortal();
        // ссылка на базовую страницу
        $link = [
            'link' => 'http://146.240.224.178/iradmin2/'
        ];

        // передаём ссылку на сайт, получаем html нужной страницы
        $html = $this->getPortalAdminAuth($link);
        // передаём html, получаем два массива: 1) витрины 2) статусы
        $showcase = $DailyStatusAdminPortal->getDataInAdminPortal($html);
        // передаём 1) витрины 2) статусы, получаем массив: витрина => статус
        $showcaseResult['lists'] = $DailyStatusAdminPortal->processingData($showcase);
        // возвращаем массив: витрина => статус
        return $showcaseResult;
    }


    /*
     * Авторизация и получение всего HTML Портала Админ на нужной стринице
     */
    public function getPortalAdminAuth($link)
    {
        $DailyStatusAdminPortal = new DailyStatusAdminPortal();
        $client = new Client([
            // Base URI is used with relative requests
            'base_uri' => $link['link'],
            // You can set any number of default request options.
            'timeout' => 60.0,
        ]);
        $cookieJar = new CookieJar();

        // получаем html формы для получения токенов
        $htmlLogin = $client->request('GET', '')->getBody()->getContents();
        // получаем токены
        $tokenAuth = $DailyStatusAdminPortal->getToken($htmlLogin);

        // проходим авторизацию
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

        // получаем html формы для получения токенов
        $htmlForm = $client->request('GET', 'ADRequest/Requests.aspx', ['cookies' => $cookieJar])
            ->getBody()->getContents();
        // получаем токены
        $tokenForm = $DailyStatusAdminPortal->getToken($htmlForm);

        // получаем нужны даты для отправи формы
        $dateForm = $DailyStatusAdminPortal->createDateForForm();

        // отправляем запрос на отчёт по витринам с нужной нам датой
        $htmlShowcaseReport = $client->request('POST', 'ADRequest/Requests.aspx',
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
                    // статус витрин (1 : Только с ошибке), (-1 : НЕ ОТПРАВЛЯТЬ!!)
//                    'ddlStatus' => '1',
                    'txtRequestDataSubmitedStart' => $dateForm['previousDay'],
                    'txtRequestDataSubmitedEnd' => $dateForm['today'],
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

        // возвращаем html сраницы с остчётом по витринам
        return $htmlShowcaseReport;
    }
}
