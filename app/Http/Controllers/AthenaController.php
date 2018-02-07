<?php

namespace App\Http\Controllers;

use App\Athena;
use GuzzleHttp\Cookie\CookieJar;
use Illuminate\Http\Request;
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
        $urlNewTiketAndId = $this->getLinkNewTiketAndId($session, $link);
        // снова формируем ссылки
        $link = $Athena->crateLink($session, $urlNewTiketAndId);

        // вставляем данные в верхнюю форму
        $this->headerFormPost($session, $link, null);
        // обновляем (сохраняем) заголовки верхней формы
        $this->reloadFormGet($session, $link, 'NEWS_QUERY');

        // вставляем данные в тело (нижнюю форму)
        $this->bodyFormPost($session, $link, null);
        // обновляем(сохраняем) приоритет тикета
        $this->reloadFormGet($session, $link, 'URGENCY_ID');
        // обновляем(сохраняем) топик
        $this->reloadFormGet($session, $link, 'SD_CATALOG_ID');

        // создаём тикет
        $this->createTiket($session, $link);

        // отпарвляем файл
        $this->uploadFileForm($session, $link, null);

        // завершаем сессию
        $this->logout($session, $link);

        return '<h3>Походу прокатило, тикет создан</h3>';


                // обновляем(сохраняем) непонятная обновлялка
//        $this->reloadFormGet($session, $link, 'TITLE_EN');
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
        // выводим логин и пароль из базы
        $user = $this->userXruAuthData();
        // подключаем модель
        $Athena = new Athena();
        // подключаем гузл
        $client = $this->client();
        // подключаем куки
        $session['cookieJar'] = new CookieJar();
        //отправляем форму на авторизацию
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
        // оставляем в массиве только ИД сессия и время жизни и записываем их в новый массив
        $session['PHPSESSID'] = explode('"', $arraySession[3])[1];
        $session['internalurltime'] = explode('"', $arraySession[6])[1];

        return $session;
    }


    /*
     * Принемает сессию и ссылки
     * Возвращает ИД нового тикета и сслку на его создание
     */
    public function getLinkNewTiketAndId($session, $link)
    {
        $client = $this->client();

        // получаем уникальный ИД для нового тикета
        $htmlGetIdTiket = $client->request('GET', $link['urlGetIdTiket'], ['cookies' => $session['cookieJar']])->getBody()->getContents();

        // получаем текст где есть ссылка на новый тикет
        $arrCreateTiket = explode('href="/', $htmlGetIdTiket)[1];

        // получаем ссылку
        $urlNewTiketAndId['urlCreateTiket'] = explode('";', $arrCreateTiket)[0];
        // получаем ИД тикета
        $urlNewTiketAndId['idTiket'] = explode('&q2_id=', $urlNewTiketAndId['urlCreateTiket'])[1];

        return $urlNewTiketAndId;
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

        return $htmlCreateTiket;
    }


    /*
     *  Заполняем шапку формы отправки тикета
     */
    public function headerFormPost($session, $link, $formData)
    {
        $formData['citId'] = '3680';
        $formData['citName'] = '999R - Multiple Sites Russia';

        $client = $this->client();
        // отправляем форму на заполнение верхний части формы тикета
        $headerForm = $client->request('POST', $link['urlFillingTiketForm'], [
                'form_params' => [
                    // параметры
                    'PHPSESSID' => $session['PHPSESSID'],
                    'updatedata' => 1,

                    // таблицы
                    'SD_REQUEST_ORIGIN.NAME_EN' => 1,
                    'pk_SD_REQUEST_ORIGIN.NAME_EN' => 'SD_REQUEST.REQUEST_ORIGIN_ID',
                    'type_SD_REQUEST_ORIGIN.NAME_EN' => 'pk',

                    // локация (место где заявлена проблема)
                    '__GOTO_DLG_AM_LOCATION.LOCATION_EN' => $formData['citId'],
                    'AM_LOCATION.LOCATION_EN_hide' => $formData['citId'],
                    '__POPUP_AM_LOCATION.LOCATION_EN' => $formData['citId'],
                    'maintable' => 'SD_REQUEST',
                    'AM_LOCATION.LOCATION_EN' => 'RUSSIA/STORE/' . $formData['citName'], // сит должен браться из таблицы магазин
                    'pk_AM_LOCATION.LOCATION_EN' => 'SD_REQUEST.LOCATION_ID',

                    // главная тема (Short description)
                    'SD_REQUEST.AVAILABLE_FIELD_1' => '(AURA)',
                    'OLD_SD_REQUEST.AVAILABLE_FIELD_1' => '',
                    'pk_SD_REQUEST.AVAILABLE_FIELD_1' => 'SD_REQUEST.AVAILABLE_FIELD_1',
                    'type_SD_REQUEST.AVAILABLE_FIELD_1' => 'string',

                    // свободный комент (Free comments)
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


    /*
     *  Заполняем тело формы тикета
     */
    public function bodyFormPost($session, $link, $formData)
    {
        $formData['cimPriority'] = '2';
        $formData['typeTiket'] = 'Incident';
        $formData['topicNameiket'] = 'COUNTRY BUSINESS/GIMA/TRANSFERS';
        $formData['topicId'] = '181570';
        $formData['textTiket'] = 'lordfsghdsghdsfhdgf h dgf hdgf hdfg hgf';

        $client = $this->client();
        $client->request('POST', $link['urlFillingTiketForm'], [
                'form_params' => [
                    // параметры
                    'PHPSESSID' => $session['PHPSESSID'],
                    'updatedata' => 4,

                    // приоритет
                    'SD_URGENCY.URGENCY_EN' => $formData['cimPriority'], //  cim из aura
                    'pk_SD_URGENCY.URGENCY_EN' => 'SD_REQUEST.URGENCY_ID',
                    'type_SD_URGENCY.URGENCY_EN' => 'pk',

                    // топик
                    'SD_CATALOG.TITLE_EN' => $formData['typeTiket'] . '/PROD/RUSSIA/' . $formData['topicNameiket'], // тип .'/PROD/RUSSIA/'. название топика (полное соответствие  в aura)
                    'SD_CATALOG.TITLE_EN_hide' => $formData['topicId'],  // поле, отвечающее за каталог
                    'pk_SD_CATALOG.TITLE_EN' => 'SD_REQUEST.SD_CATALOG_ID',

                    // логкация (пока не выяснил зачем, закоментим)
//                    'incident_location' => $formData['citId'],

                    // основние описание тикета
                    'SD_REQUEST.COMMENT' => $formData['textTiket'],
                    'OLD_SD_REQUEST.COMMENT' => '',
                    'type_SD_REQUEST.COMMENT' => 'memo',
                    'SD_REQUEST.DESCRIPTION' => '',
                    'OLD_SD_REQUEST.DESCRIPTION' => '',
                    'type_SD_REQUEST.DESCRIPTION' => 'memo',

                    // параметры
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

    /*
     *  сохрание переданных в форму параметров
     */
    public function reloadFormGet($session, $link, $parameter)
    {
        $client = $this->client();
        $client->request('GET', $link['urlReloadForm'] . $parameter, ['cookies' => $session['cookieJar']]);
    }

    /*
     *  Отправка файлов
     */
    public function uploadFileForm($session, $link, $urlFile)
    {
        $client = $this->client();
        // путь к файлу
        $urlFile = 'http://w7ru09990004/img/hellfire.jpg';

        // отправляем файл на сервер
        $client->request('POST', $link['urlUploadFile'], [
                'multipart' => [
                    [
                        'name' => 'file_to_upload',
                        'contents' => fopen($urlFile, 'r'),
                    ],
                ],
                'cookies' => $session['cookieJar'],
            ]
        );

        // обновляем таблицы (сохрание отправленного файла)
        $client->request('POST', $link['urlUploadFileUpdateTable'], [
                'multipart' => [
                    [
                        'name' => 'comment_upload_file',
                        'contents' => '',
                    ],
                ],
                'cookies' => $session['cookieJar'],
            ]
        );

        // обновляем номер вложения (визуализация)
        $client->request('GET', $link['urlUploadFileUpdateNumber'], ['cookies' => $session['cookieJar']]);
    }

    /*
     *  выход для освобождения сессии
     */
    public function logout($session, $link)
    {
        $client = $this->client();
        // завершаем работу
        $client->request('GET', $link['urlLogout'], ['cookies' => $session['cookieJar']]);
    }
}
