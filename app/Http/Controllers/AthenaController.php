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
    public function index(Request $request)
    {
        $Athena = new Athena();
        // получаем сессию и куки из html
        $session = $this->getAuth();
        // формируем ссылки
        $link = $Athena->crateLink($session, null);

        $formData = $Athena->getFormData($request);
        // получем ИД группы
        $formData['idGroup'] = $this->urlGetGroupId($session, $link, $formData);

        // получаем ссылку на новый тикет и ИД этого тикета
        $urlNewTiketAndId = $this->getLinkNewTiketAndId($session, $link);
        // снова формируем ссылки
        $link = $Athena->crateLink($session, $urlNewTiketAndId);

        // вставляем данные в верхнюю форму
        $this->headerFormPost($session, $link, $formData);
        // обновляем (сохраняем) заголовки верхней формы
        $this->reloadFormGet($session, $link, 'NEWS_QUERY');

        // вставляем данные в тело (нижнюю форму)
        $this->bodyFormPost($session, $link, $formData);
        // обновляем(сохраняем) приоритет тикета
        $htmlSlaTarget = $this->reloadFormGet($session, $link, 'URGENCY_ID');
        // добавляем срок SLA в FormData
        $formData['sla'] = $Athena->getSlaTarget($htmlSlaTarget);
        // обновляем(сохраняем) топик
        $this->reloadFormGet($session, $link, 'SD_CATALOG_ID');

        // создаём тикет
        $this->createTiket($session, $link);

        // отпарвляем файл (не всегда требуется, потом придумаем как реализовать)
//        $this->uploadFileForm($session, $link, $formData);

        // подготовка к отправке тикета
        $this->getPreSendTiket($session, $link);
        // отправляем тикет на грппу
        $this->postTiketOnGroup($session, $link, $formData);

        // завершаем сессию
        $this->logout($session, $link);

        // возвращаем номер тикета
        return $urlNewTiketAndId['numberTiket'];


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
            'proxy' => 'proxy.ru.auchan.com:3128'
            //            'proxy' => 'LOGIN:PASSWORD@proxy.ru.auchan.com:3128'
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
        // получаем номер тикета
        $stringNumberTiket = explode('&q2_rfcnumber=', $urlNewTiketAndId['urlCreateTiket'])[1];
        $urlNewTiketAndId['numberTiket'] = explode('&q2_id=', $stringNumberTiket)[0];
        return $urlNewTiketAndId;
    }

    /*
     * Принемает сессию и ссылки
     */
    public function createTiket($session, $link)
    {
        $client = $this->client();
        // создаём тикет
        $client->request('GET', $link['urlCreateTiket'], ['cookies' => $session['cookieJar']]);
    }


    /*
     *  Заполняем шапку формы отправки тикета
     */
    public function headerFormPost($session, $link, $formData)
    {
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
                    'SD_REQUEST.AVAILABLE_FIELD_1' => $formData['title'],
                    'OLD_SD_REQUEST.AVAILABLE_FIELD_1' => '',
                    'pk_SD_REQUEST.AVAILABLE_FIELD_1' => 'SD_REQUEST.AVAILABLE_FIELD_1',
                    'type_SD_REQUEST.AVAILABLE_FIELD_1' => 'string',

                    // свободный комент (Free comments)
                    'SD_REQUEST.AVAILABLE_FIELD_3' => $formData['freeComment'],
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
                    'SD_CATALOG.TITLE_EN' => $formData['typeTiket'] . '/PROD/RUSSIA/' . $formData['topicNameTiket'], // тип .'/PROD/RUSSIA/'. название топика (полное соответствие  в aura)
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

        if ($parameter == 'URGENCY_ID') {
            $html = $client->request('GET', $link['urlReloadForm'] . $parameter, ['cookies' => $session['cookieJar']])
                ->getBody()->getContents();
            return $html;
        } else {
            $client->request('GET', $link['urlReloadForm'] . $parameter, ['cookies' => $session['cookieJar']]);
        }
    }

    /*
     *  Отправка файлов
     */
    public function uploadFileForm($session, $link, $formData)
    {
        $client = $this->client();

        // отправляем файл на сервер
        $client->request('POST', $link['urlUploadFile'], [
                'multipart' => [
                    [
                        'name' => 'file_to_upload',
                        'contents' => fopen($formData['urlFile'], 'r'),
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
     *  подготовка к отправке титета
     */

    public function getPreSendTiket($session, $link)
    {
        $client = $this->client();

        $client->request('GET', $link['urlAssignTiket'], ['cookies' => $session['cookieJar']]);
        $client->request('GET', $link['urlAfterTiket'], ['cookies' => $session['cookieJar']]);
    }

    /*
     * Отправка титека на группу пост запросом
     */
    public function postTiketOnGroup($session, $link, $formData)
    {
        $client = $this->client();

        $client->request('POST', $link['urlSendOnGroupTiket1'], [
                'form_params' => [
                    'PHPSESSID' => $session['PHPSESSID'],
                    'phone' => '-',
                    'email' => 'Notice_it@auchan.ru',
                    '__questionnaire__questionnaire_id' => 34269,
                    '__questionnaire__request_id' => $link['idTiket'],
                    '__questionnaire__request_detail_id' => '',
                    '__questionnaire__36627type' => 'comment',
                    '__questionnaire__36627guid' => '{EC9FA872-734C-4723-8BFD-48EC66D8ADF1}',
                    '__questionnaire__36627answer' => 0,
                    '__questionnaire__36627displayed' => 1,
                    '__questionnaire__36627required' => 0,
                    '__questionnaire__36627conditionnal' => 0,
                    '__questionnaire__ids' => 36627,
                ],
                'cookies' => $session['cookieJar'],
            ]
        )->getBody()->getContents();

        $client->request('GET', $link['urlSendOnGroupTiket2'], ['cookies' => $session['cookieJar']]);

        $client->request('POST', $link['urlSendOnGroupTiket3'], [
                'form_params' => [
                    'PHPSESSID' => $session['PHPSESSID'],
                    'Group_hide' => trim($formData['idGroup']),
                    'Group' => trim($formData['nameGroup']),
                    'Done_by' => '',
                    'Start_date' => strval($formData['sla']['slaStartDate']),
                    'resolution_date' => strval($formData['sla']['slaTarget']) . ' (GMT+07:00) Novosibirsk',
                    'End_date' => '',
                    'Intervention_end_date' => '',
                ],
                'cookies' => $session['cookieJar'],
            ]
        );
    }

    /*
     * Получения ИД группы отправки
     */
    public function urlGetGroupId($session, $link, $formData)
    {
        $nameGroupBase64 = base64_encode($formData['nameGroup']);

        $client = $this->client();
        // получает html где есть ИД группы
        $html = $client->request('GET', $link['urlGetGroups'] . $nameGroupBase64, ['cookies' => $session['cookieJar']])
            ->getBody()
            ->getContents();

        // получем из html сам ИД группы
        $htmlIdGroup = explode('"id":"', $html)[1];
        $idGroup = explode('"', $htmlIdGroup)[0];

        return $idGroup;
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
