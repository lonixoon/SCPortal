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
        $link = [
            'link' => 'https://athena.easyvista.com/'
        ];

        $html = $this->getAuth($link);
        return $html;
    }

    /*
     * Авторизация и получение всего HTML Портала Админ на нужной стринице
     */
    public function getAuth($link)
    {
        $user = $this->userXruAuthData();

        $Athena = new Athena();

        $client = new Client([
            'base_uri' => $link['link'],
            'timeout' => 60.0,
        ]);
        $cookieJar = new CookieJar();

        $htmlAfterLogin = $client->request('POST', 'index.php', [
                'form_params' => [
                    'url_account' => '50004',
                    'url_login' => $user['login'],
                    'url_password' => $user['password'],
                ],
                'cookies' => $cookieJar,
            ]
        )->getBody()->getContents();

        // получаем сессию и время жизни сессии
        $stringSession = $Athena->getSession($htmlAfterLogin);
        $arraySession = explode('",', $stringSession);
        $session['PHPSESSID'] = explode('"', $arraySession[3])[1];
        $session['internalurltime'] = explode('"', $arraySession[6])[1];
        // создаём ссылку получения уникальной ссылки на новый тикет
        $urlGetIdTiket = 'index.php?PHPSESSID=' . $session['PHPSESSID'] . '&internalurltime=' . $session['internalurltime']
            . '&theme=%7BC9F11D78-448E-4EAC-A766-C904ED98458E%7D&do_quickcall=2&quickcall_id=284152&new_rqst=1';
        // получаем уникальный ИД для нового тикета
        $htmlGetIdTiket = $client->request('GET', $urlGetIdTiket, ['cookies' => $cookieJar])->getBody()->getContents();

        // получаем ссылку на новый тикет
        $arrCreateTiket = explode('href="/', $htmlGetIdTiket)[1];
        $urlCreateTiket = explode('";', $arrCreateTiket)[0];
        $htmlCreateTiket = $client->request('GET', $urlCreateTiket, ['cookies' => $cookieJar])->getBody()->getContents();

        return $htmlCreateTiket;
    }
}
