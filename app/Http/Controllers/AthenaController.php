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
     * Главная упавляющаая функция
     */
    public function index()
    {
        $Athena = new Athena();

        // получаем сессию и куки из html
        $session = $this->getAuth();
        // формируем ссылки
        $link = $Athena->crateLink($session, null);
        // получаем ссылку на новый тикет и ИД этого тикета
        $arrUrlCreateTiketAndIdTiket = $this->getNewTiketAndId($session, $link);
        // снова формируем ссылки
        $link = $Athena->crateLink($session, $arrUrlCreateTiketAndIdTiket);

        // вставляем данные в верхнюю форму
        $this->headerFormPost($session, $link);
        // обновляем (сохраняем) заголовки верхней формы
        $this->reloadFormGet($session, $link, 'NEWS_QUERY');
        // вставляем данные в тело (нижнюю форму)
        $this->bodyFormPost($session, $link);
        // обновляем(сохраняем) приоритет тикета
        $this->reloadFormGet($session, $link, 'URGENCY_ID');
        // обновляем(сохраняем)
        $this->reloadFormGet($session, $link, 'TITLE_EN');
        // обновляем(сохраняем) топик
        $this->reloadFormGet($session, $link, 'SD_CATALOG_ID');
        // создаём тикет
        $createTiketHtml = $this->createTiket($session, $link);


        // завершаем сессию
        $this->logout($session, $link);
//        dd($reloadForm);
        return $createTiketHtml;
    }

    /*
     * Возвращает параметры для клиента
     */
    public function client()
    {
        $client = new Client([
            'base_uri' => 'https://athena.easyvista.com/',
            'timeout' => 60.0,
        ]);
        return $client;
    }

    /*
     * Авторизация и получение всего HTML
     * Возвращает сессию
     */
    public function getAuth()
    {
        $user = $this->userXruAuthData();
        $Athena = new Athena();
        $client = $this->client();

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


    /*
     * Принемает сессию и ссылки
     * Возвращает ИД нового тикета и сслку на его создание
     */
    public function getNewTiketAndId($session, $link)
    {
        $client = $this->client();

        // получаем уникальный ИД для нового тикета
        $htmlGetIdTiket = $client->request('GET', $link['urlGetIdTiket'], ['cookies' => $session['cookieJar']])->getBody()->getContents();

        // получаем ссылку на новый тикет
        $arrCreateTiket = explode('href="/', $htmlGetIdTiket)[1];
        $urlCreateTiketAndId['urlCreateTiket'] = explode('";', $arrCreateTiket)[0];

        // получаем ИД тикета
        $urlCreateTiketAndId['idTiket'] = explode('&q2_id=', $urlCreateTiketAndId['urlCreateTiket'])[1];

        return $urlCreateTiketAndId;
    }

    /*
     * Принемает сессию и ссылки
     * Возвращает новый тикет
     */
    public function createTiket($session, $link)
    {
        $client = $this->client();

        // получаем html созданного тикета
        $htmlCreateTiket = $client->request('GET', $link['urlCreateTiket'], ['cookies' => $session['cookieJar']])->getBody()->getContents();
//        $htmlCreateTiket = $client->request('GET', $link['urlCreateTiket'], ['cookies' => $session['cookieJar']]);

        return $htmlCreateTiket;
    }


    /*
     *  Заполняем шапку формы отправки тикета
     */
    public function headerFormPost($session, $link)
    {
        $sit_id = '3644';
        $sit = '016 - Auchan Novosibirsk';

        $client = $this->client();
        $headerForm = $client->request('POST', $link['urlFillingTiketForm'], [
                'form_params' => [
                    'PHPSESSID' => $session['PHPSESSID'],
                    'updatedata' => 1,
                    'AM_REQUESTOR.LAST_NAME' => 'FromAthenaInFify', // названию юзера в атене
                    'pk_AM_REQUESTOR.LAST_NAME' => 'SD_REQUEST.REQUESTOR_ID',

                    'AM_RECIPIENT.LAST_NAME' => 'FromAthenaInFify', // названию юзера в атене
                    'pk_AM_RECIPIENT.LAST_NAME' => 'SD_REQUEST.RECIPIENT_ID',

                    'SD_REQUEST_ORIGIN.NAME_EN' => 1,
                    'pk_SD_REQUEST_ORIGIN.NAME_EN' => 'SD_REQUEST.REQUEST_ORIGIN_ID',
                    'type_SD_REQUEST_ORIGIN.NAME_EN' => 'pk',
                    '__GOTO_DLG_AM_LOCATION.LOCATION_EN' => $sit_id,
                    '__WORLD_LINK_AM_LOCATION.LOCATION_EN_COUNTRY' => 'RUS',
                    'AM_LOCATION.LOCATION_EN_hide' => $sit_id,
                    '__POPUP_AM_LOCATION.LOCATION_EN' => $sit_id,
                    'type_SD_REQUEST.PLANNED_CHANGE_DATE_END' => 'datetime',
                    'type_SD_REQUEST.REQUESTED_CHANGE_DATE_END' => 'datetime',
                    'timezone_SD_REQUEST.SUBMIT_DATE_UT' => 'Mjg0MTUy',

                    'SD_IMPACT.IMPACT_EN' => '3 - Low', // из топика
                    'pk_SD_IMPACT.IMPACT_EN' => '',
                    'type_SD_IMPACT.IMPACT_EN' => 'string',

                    'SD_SLA.NAME_EN' => '4 days',
                    'pk_SD_SLA.NAME_EN' => '',

                    'maintable' => 'SD_REQUEST',
                    'AM_LOCATION.LOCATION_EN' => 'RUSSIA/STORE/' . $sit, // сит должен браться из таблицы магазин
                    'pk_AM_LOCATION.LOCATION_EN' => 'SD_REQUEST.LOCATION_ID',
                    'SD_REQUEST.AVAILABLE_FIELD_1' => '(AURA)',
                    'OLD_SD_REQUEST.AVAILABLE_FIELD_1' => '',
                    'pk_SD_REQUEST.AVAILABLE_FIELD_1' => 'SD_REQUEST.AVAILABLE_FIELD_1',
                    'type_SD_REQUEST.AVAILABLE_FIELD_1' => 'string',
                    'SD_REQUEST.AVAILABLE_FIELD_3' => 'AUUUUURAAA',
                    'OLD_SD_REQUEST.AVAILABLE_FIELD_3' => '',
                    'pk_SD_REQUEST.AVAILABLE_FIELD_3' => '',
                    'type_SD_REQUEST.AVAILABLE_FIELD_3' => 'string',

                    'editFormrequired_fields' => 'AM_REQUESTOR.LAST_NAME,AM_RECIPIENT.LAST_NAME,SD_REQUEST_ORIGIN.NAME_EN,AM_LOCATION.LOCATION_EN,SD_REQUEST.AVAILABLE_FIELD_1',
                    'editFormdatetime_fields' => 'SD_REQUEST.REQUESTED_CHANGE_DATE_END,SD_REQUEST.PLANNED_CHANGE_DATE_END'
                ],
                'cookies' => $session['cookieJar'],
            ]
        );

        return $headerForm;
    }

    public function bodyFormPost($session, $link)
    {
        $cim = '2';
        $type = 'Incident';
        $topic['name'] = 'COUNTRY BUSINESS/GIMA';
        $set_topic = '181527';
        $sit_id = '3644';
        $text = 'lordfsghdsghdsfhdgf h dgf hdgf hdfg hgf';
//        dd($link['idTiket']);


        $client = $this->client();
        $client->request('POST', $link['urlFillingTiketForm'], [
                'form_params' => [
                    'PHPSESSID' => $session['PHPSESSID'],
                    'updatedata' => 4,
                    'SD_URGENCY.URGENCY_EN' => $cim, //  cim из aura
                    'pk_SD_URGENCY.URGENCY_EN' => 'SD_REQUEST.URGENCY_ID',
                    'type_SD_URGENCY.URGENCY_EN' => 'pk',
                    'SD_CATALOG.TITLE_EN' => $type . '/PROD/RUSSIA/' . $topic['name'], // тип .'/PROD/RUSSIA/'. название топика (полное соответствие  в aura)
                    'SD_CATALOG.TITLE_EN_hide' => $set_topic,  // поле, отвечающее за каталог
                    'pk_SD_CATALOG.TITLE_EN' => 'SD_REQUEST.SD_CATALOG_ID',
                    'incident_location' => $sit_id,
                    'SD_REQUEST.COMMENT' => $text,
                    'OLD_SD_REQUEST.COMMENT' => '',
                    'type_SD_REQUEST.COMMENT' => 'memo',
                    'SD_REQUEST.DESCRIPTION' => '',
                    'OLD_SD_REQUEST.DESCRIPTION' => '',
                    'type_SD_REQUEST.DESCRIPTION' => 'memo',
                    'maintable' => '',
                    'maintable2' => 'SD_REQUEST',
                    'maintable2_npk' => 1,
                    'maintable2_pk0' => 'REQUEST_ID',
                    'maintable2_pk_value0' => $link['idTiket'],
                    'editForm2required_fields' => 'SD_CATALOG.TITLE_EN,SD_URGENCY.URGENCY_EN',
                ],
                'cookies' => $session['cookieJar'],
            ]
        );
    }

    public function reloadFormGet($session, $link, $text)
    {
        $client = $this->client();
        $client->request('GET', $link['urlReloadForm'] . $text, ['cookies' => $session['cookieJar']]);
    }

    public function logout($session, $link)
    {
        $client = $this->client();
        // завершаем работу
        $client->request('GET', $link['urlLogout'], ['cookies' => $session['cookieJar']]);
    }
}
