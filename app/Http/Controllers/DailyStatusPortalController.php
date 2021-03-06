<?php

namespace App\Http\Controllers;

use App\DailyStatusPortal;
use GuzzleHttp\Cookie\CookieJar;
use Illuminate\Http\Request;
use Symfony\Component\DomCrawler\Crawler;
use GuzzleHttp\Client;
use App\DailyStatusPortalOld;


class DailyStatusPortalController extends Controller
{
    /*
     * Главная упавляющаая функция, возвращает данные Портал в виде массива Магазин => Статус
     */
    public function indexPortalClassic()
    {
        $DailyStatusPortal = new DailyStatusPortal();
        // ссылка на базовую страницу
        $portalClassic = [
            // страница с контентом после авторизации
            'link' => 'http://portal.ru.auchan.com/portal/',
            // классы по которым парсим контент
            'citeNameClassParse' => '371',
            'clientsValueClassParse' => '375',
            'articleValueClassParse' => '383',
            'CaValueClassParse' => '403',
            'CaPeriodValueClassParse' => '415',
        ];
        // передаём ссылку на сайт, получаем html нужной страницы
        $html = $this->getPortalAuth($portalClassic);
        // передаём html, получаем массивы: 1) citeName 2) clientsValue 3) CaPeriodValue
        $dataPortal = $DailyStatusPortal->getDataInPortal($html, $portalClassic);
        // передаём 1) citeName 2) clientsValue 3) CaPeriodValue, получаем массив: Магазин => [Клинеты, ТО за период]
        $allCiteArr = $DailyStatusPortal->processingData($dataPortal);
        // передаём  Магазин => [Клинеты, ТО за период], возвращаем Магазин => Статус
        $allProblemCiteArr['classic'] = $DailyStatusPortal->processingProblemData($allCiteArr);
        // возвращаем Магазин => Статус
        return $allProblemCiteArr;
    }


    /*
     * Главная упавляющаая функция, возвращает данные Портал в виде массива Магазин => Статус
     */
    public function indexPortalAtak()
    {
        $DailyStatusPortal = new DailyStatusPortal();
        // ссылка на базовую страницу
        $portalAtak = [
            // страница с контентом после авторизации
            'link' => 'http://146.240.224.178/Portal/',
            // классы по которым парсим контент
            'citeNameClassParse' => '336',
            'clientsValueClassParse' => '368',
            'articleValueClassParse' => '376',
            'CaValueClassParse' => '340',
            'CaPeriodValueClassParse' => '352',
        ];
        // передаём ссылку на сайт, получаем html нужной страницы
        $html = $this->getPortalAuth($portalAtak);
        // передаём html, получаем массивы: 1) citeName 2) clientsValue 3) CaPeriodValue
        $dataPortal = $DailyStatusPortal->getDataInPortal($html, $portalAtak);
        // передаём 1) citeName 2) clientsValue 3) CaPeriodValue, получаем массив: Магазин => [Клинеты, ТО за период]
        $allCiteArr = $DailyStatusPortal->processingData($dataPortal);
        // передаём  Магазин => [Клинеты, ТО за период], возвращаем Магазин => Статус
        $allProblemCiteArr['atak'] = $DailyStatusPortal->processingProblemData($allCiteArr);
        // возвращаем Магазин => Статус
        return $allProblemCiteArr;
    }


    /*
     * Авторизация и получение всего HTML Портала Админ на нужной стринице
     * Принемает ссылку, возвращает html нужной страницы
     */
    public function getPortalAuth($link)
    {
        // получаем пользователя для доступа
        $user = $this->userAuthData();

        $DailyStatusPortal = new DailyStatusPortal();
        $client = new Client([
            // Base URI is used with relative requests
            'base_uri' => $link['link'],
            // You can set any number of default request options.
            'timeout' => 100.0,
        ]);
        $cookieJar = new CookieJar();

        // получаем html формы для получения токенов
        $htmlLogin = $client->request('GET', '')->getBody()->getContents();
        // получаем токены
        $tokenAuth = $DailyStatusPortal->getToken($htmlLogin);

        // проходим авторизацию
        $client->request('POST', 'Login.aspx', [
                'form_params' => [
                    '__EVENTTARGET' => '',
                    '__EVENTARGUMENT' => '',
                    '__LASTFOCUS' => '',
                    '__VIEWSTATE' => $tokenAuth['viewState'],
                    '__EVENTVALIDATION' => $tokenAuth['eventValidation'],
                    'username' => $user['login'],
                    'password' => $user['password'],
                    'ddlLanguage' => 'ru-RU',
                    'btnLogin' => 'Вход',
                    'btnEnter' => 'Вход',
                    'hidscreenWidth' => '',
                    'hidscreenHeight' => '',
                ],
                'cookies' => $cookieJar,
            ]
        );

        // получаем запрос на данные по продажам
        $html = $client->get('pg412100.aspx', ['cookies' => $cookieJar])->getBody()->getContents();
        // возвращаем html
        return $html;
    }
}
