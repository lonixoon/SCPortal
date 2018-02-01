<?php

namespace App\Http\Controllers;

use App\Athena;
use GuzzleHttp\Cookie\CookieJar;
use Illuminate\Http\Request;
use Symfony\Component\DomCrawler\Crawler;
use GuzzleHttp\Client;


class AthenaController extends Controller
{
    /*
     * Главная упавляющаая функция, получает данные Портал Админ Классика в виде массива Витрина => Статус
     */
    public function index()
    {
        $Athena = new Athena();

        // получаем сессию и куки
        $session = $this->getAuth();
        // формируем ссылки
        $link = $Athena->crateLink($session);
        // создаём тикет
        $createTiket = $this->createTiket($session, $link);

        return $createTiket;
    }

    /*
     * Авторизация и получение всего HTML Портала Админ на нужной стринице
     */
    public function getAuth()
    {
        $user = $this->userXruAuthData();

        $Athena = new Athena();

        $client = new Client([
            'base_uri' => 'https://athena.easyvista.com/',
            'timeout' => 60.0,
        ]);
        $session['cookieJar'] = new CookieJar();

        $htmlAfterLogin = $client->request('POST', 'index.php', [
                'form_params' => [
                    'url_account' => '50004',
                    'url_login' => $user['login'],
                    'url_password' => $user['password'],
                ],
                'cookies' => $session['cookieJar'],
            ]
        )->getBody()->getContents();

        // парсим ИД сессии и время жизни сессии сразу после входа
        $stringSession = $Athena->getSession($htmlAfterLogin);
        // делаем из html массив
        $arraySession = explode('",', $stringSession);
        // оставляем в массиве только два парамера и записываем их в новый массив
        $session['PHPSESSID'] = explode('"', $arraySession[3])[1];
        $session['internalurltime'] = explode('"', $arraySession[6])[1];

        return $session;
    }

    public function createTiket($session, $link)
    {
        $client = new Client([
            'base_uri' => 'https://athena.easyvista.com/',
            'timeout' => 60.0,
        ]);
        // получаем уникальный ИД для нового тикета
        $htmlGetIdTiket = $client->request('GET', $link['urlGetIdTiket'], ['cookies' => $session['cookieJar']])->getBody()->getContents();

        // получаем ссылку на новый тикет
        $arrCreateTiket = explode('href="/', $htmlGetIdTiket)[1];
        $urlCreateTiket = explode('";', $arrCreateTiket)[0];

        // получаем html созданного тикета
        $htmlCreateTiket = $client->request('GET', $urlCreateTiket, ['cookies' => $session['cookieJar']])->getBody()->getContents();

        // завершаем работу
        $client->request('GET', $link['urlLogout'], ['cookies' => $session['cookieJar']]);

        return $htmlCreateTiket;
    }
}
