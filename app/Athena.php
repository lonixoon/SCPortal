<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Symfony\Component\DomCrawler\Crawler;

class Athena extends Model
{
    public function getSession($html)
    {
        $crawler = new Crawler();
        // передаём html в кравлер
        $crawler->addHtmlContent($html, 'UTF-8');
        // получаем первый токен
        $session = $crawler->filterXPath('//head//script[@language="JavaScript"]')->text();
        // возващаяем массив с двумя токенами
        return $session;
    }

    /*
     * Формируем ссылки
     * Получаем сессию первой переменной, второй ссылку на новый тикет и его ИД
     * Возвращаем готовые ссылки
     */
    public function crateLink($session, $urlCreateTiketAndId)
    {
        // сессия
        $sessionId = $session['PHPSESSID'];
        // время жизни сессии
        $sessionTime = $session['internalurltime'];
        // сессия (кусок ссылки для удобаства)
        $session = 'PHPSESSID=' . $sessionId . '&internalurltime' . $sessionTime;
        // ИД тикета
        $idTiket = $urlCreateTiketAndId['idTiket'];
        // Ссылка на новый тикет
        $urlCreateTiket = $urlCreateTiketAndId['urlCreateTiket'];


        $link = [
            // ИД тикета
            'idTiket' => $idTiket,

            // сслыка для логаута, чтобы не засорять сессии
            'urlLogout' => 'https://athena.easyvista.com/index.php?logout=1&' . $session,

            // создаём ссылку получения уникальной ссылки на новый тикет
            'urlGetIdTiket' => 'index.php?' . $session
                . '&theme=%7BC9F11D78-448E-4EAC-A766-C904ED98458E%7D&do_quickcall=2&quickcall_id=284152&new_rqst=1',

            // ссылка на создание нового тикета
            'urlCreateTiket' => $urlCreateTiket,

            // ссылка для добавления данных в тикет post
            'urlFillingTiketForm' => 'iframefiche.php?' . $session
                . '&theme=%7BC9F11D78-448E-4EAC-A766-C904ED98458E%7D&eventName=ShowEditGrid&q2_dialogId=%7B90D54E77-40A5-4F0F-8029-5A7A05F5814D%7D&sender=%7B98C92B3D-9EEF-4459-B6CD-7CCDB9ADED9D%7D&q2_section=1&q2_element=0&q2_id=' .
                $idTiket . '&action_select=%7BE1FBEB97-20F1-4A05-AF92-7352695AFFB5%7D',

            // ссылка для обновления данных формы (применение изменений данных формы) get
            'urlReloadForm' => 'reload_qc.php?' . $session
                . '&theme=%7BC9F11D78-448E-4EAC-A766-C904ED98458E%7D&eventName=ShowEditGrid&q2_dialogId=%7B90D54E77-40A5-4F0F-8029-5A7A05F5814D%7D&sender=%7B98C92B3D-9EEF-4459-B6CD-7CCDB9ADED9D%7D&q2_section=0&q2_element=0&q2_id='
                . $idTiket . '&field_to_reload=',

            // ссылка на добавления фалов в тикет multi
            'uploadFile' => 'include/javascript/staff/upload/jquery.fileupload_doc.php?PHPSESSID=' . $sessionId
                . '&wizard_from=quickcall&rqt_id=' . $idTiket . '&id=' . $idTiket . '&tablename=SD_REQUEST',

            // ссылка на обновление таблиц что бы файл прикрепился multi
            'uploadFileUpdateTable' => 'upload_f_doc_details.php?PHPSESSID=' . $sessionId
                . '&wizard_from=quickcall&rqt_id=' . $idTiket . '&id=' . $idTiket . '&tablename=SD_REQUEST',

            // ссылка на обновление циферки в тиктет чтобы было видно сколько вложений get
            'uploadFileUpdateNumber' => 'qty_doc_upload.php?PHPSESSID=' . $sessionId
                . '&tablename=SD_REQUEST&id=' . $idTiket,
        ];

        return $link;
    }
}
