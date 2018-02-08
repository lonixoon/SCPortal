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

    public function getSlaTarget($htmlSlaTarget)
    {
        $crawler = new Crawler();
        // передаём html в кравлер
        $crawler->addHtmlContent($htmlSlaTarget, 'UTF-8');

        //забираем циклом все поля
        $slaData = $crawler
            // поиск осуществляем по постаянному кусочку от id
            ->filterXPath('//td//b')
            ->each(function (Crawler $node, $i) {
                return $node->text();
            });

        $slaTarget['slaStartDate'] = $slaData[2];
        $slaTarget['slaTarget'] = $slaData[3];

        return $slaTarget;
    }

    /*
     * Формируем ссылки
     * Получаем сессию первой переменной, второй ссылку на новый тикет и его ИД
     * Возвращаем готовые ссылки
     */
    public function crateLink($session, $urlNewTiketAndId)
    {
        // сессия
        $sessionId = $session['PHPSESSID'];
        // время жизни сессии
        $sessionTime = $session['internalurltime'];
        // сессия (кусок ссылки для удобаства)
        $session = 'PHPSESSID=' . $sessionId . '&internalurltime' . $sessionTime;
        // ИД тикета
        $idTiket = $urlNewTiketAndId['idTiket'];
        // Ссылка на новый тикет
        $urlCreateTiket = $urlNewTiketAndId['urlCreateTiket'];


        $link = [
            // ИД тикета
            'idTiket' => $idTiket,

            // сслыка для логаута, чтобы не засорять сессии get
            'urlLogout' => 'https://athena.easyvista.com/index.php?logout=1&' . $session,

            // создаём ссылку получения уникальной ссылки на новый тикет get
            'urlGetIdTiket' => 'index.php?' . $session
                . '&theme=%7BC9F11D78-448E-4EAC-A766-C904ED98458E%7D&do_quickcall=2&quickcall_id=284152&new_rqst=1',

            // ссылка на создание нового тикета get
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
            'urlUploadFile' => 'include/javascript/staff/upload/jquery.fileupload_doc.php?PHPSESSID=' . $sessionId
                . '&wizard_from=quickcall&rqt_id=' . $idTiket . '&id=' . $idTiket . '&tablename=SD_REQUEST',

            // ссылка на обновление таблиц что бы файл прикрепился multi
            'urlUploadFileUpdateTable' => 'upload_f_doc_details.php?PHPSESSID=' . $sessionId
                . '&wizard_from=quickcall&rqt_id=' . $idTiket . '&id=' . $idTiket . '&tablename=SD_REQUEST',

            // ссылка на обновление циферки в тиктет чтобы было видно сколько вложений get
            'urlUploadFileUpdateNumber' => 'qty_doc_upload.php?PHPSESSID=' . $sessionId
                . '&tablename=SD_REQUEST&id=' . $idTiket,

            // получаем список всех групп get
            'urlGetGroups' => '/ajax_widget.php?session_id=' . $sessionId . '&uniqid=' . $sessionTime
                . '&lng=EN&theme={C9F11D78-448E-4EAC-A766-C904ED98458E}&widgetname=ListViewAutocomplete.ListViewAutocompleteWidget&widgetid=59d5adec2f952&WidgetParams=action%3DgetAll%26attachTo%3D%26queryGUID%3D%7B023AC6B8-6F04-4D40-8025-FC3263978A1C%7D%26listQuery%3D%26withoutDomain%3Dtrue%26filter%3DKCgoKEFNX0dST1VQLkdST1VQX0lEIG5vdCBpbiAoMzU1LCAzNTYsIDM1NywgMzU4LCAzNTksIDM2MCwgMzYxLCAzNjIsIDM2MywgMzY0LCAzNjUsIDM2NiwgMzY3LCAzNjgsIDM2OSwgMzcwLCAzNzEsIDM3MiwgMzczLCAzNzQsIDM3NSwgMzc2LCAzNzcsIDM3OCwgMzc5LCAzODAsIDM4MSwgMzgyLCAzODMsIDM4NCwgMzg1LCAzODYsIDM4NywgMzg4LCAzODksIDM5MCwgMzkxLCAzOTIsIDM5MywgMzk0LCAzOTUsIDM5NiwgMzk3LCAzOTgsIDM5OSwgNDAwLCA0MDEsIDQwMiwgNDAzLCA0MDQsIDQwNSwgNDA2LCA0MDcsIDQxNSwgNDE3LCA0MTgsIDQxOSwgNDIwLCA0MjEsIDQyMiwgNDIzLCA0MjQsIDQyNSwgNDI2LCA0MzAsIDQzMSwgNDMyLCA0MzMsIDQzNCwgNDM1LCA0MzYsIDQzNywgNDM4LCA0MzksIDQ0MCwgNDQxLCA0NDIsIDQ0MywgNDQ0LCA0NDUsIDQ0NiwgNDQ3LCA0NDgsIDQ0OSwgNDUwLCA0NTEsIDQ1MiwgNDUzLCA0NTQsIDQ1NSwgNDU2LCA0NTcsIDQ1OCwgNDYwLCA0NjEsIDQ2MiwgNDYzLCA0NjUsIDQ2NiwgNDY3LCA0NjgsIDQ3MSwgNDcyLCA0NzMsIDQ3OCwgNDc5LCA0ODAsIDQ4MSwgNDgyLCA0ODMsIDQ4NCwgNDg1LCA0ODYsIDQ4NywgNDg4LCA0ODksIDQ5MCwgNDkxLCA0OTIsIDQ5MywgNDk1LCA0OTYsIDQ5NywgNDk4LCA0OTksIDUwMCwgNTAxLCA1MDIsIDUwMywgNTA0LCA1MDUsIDUwNiwgNTA3LCA1MDgsIDUwOSwgNTEwLCA1MTEsIDUxMiwgNTEzLCA1MTQsIDUxNSwgNTE2LCA1MTcsIDUxOCwgNTE5LCA1MjAsIDUyMSwgNTIyLCA1MjMsIDUyNCwgNTI1LCA1MjYsIDUyNywgNTI4LCA1MjksIDUzMCwgNTMxLCA1MzIsIDUzMywgNTM0LCA1MzUsIDUzNiwgNTM3LCA1MzgsIDUzOSwgNTQwLCA1NDEsIDU3MywgNTc0LCA1NzUsIDU3NiwgNTc3LCA1NzgsIDU3OSwgNTgwLCA1ODEsIDU4MiwgNTgzLCA1ODQsIDU4NSwgNTg2LCA1ODcsIDU4OCwgNTg5LCA1OTAsIDU5MSwgNTkyLCA1OTMsIDU5NCwgNTk1LCA1OTYsIDU5NywgNTk4LCA1OTksIDYwMiwgNjA3LCA2MDksIDYxMCwgNjExLCA2MTIsIDYxNywgNjE4LCA2MTksIDYyMCwgNjIxLCA2MjIsIDYyMywgNjI0LCA2MjUsIDYyNiwgNjI3LCA2MjgsIDYyOSwgNjMwLCA2MzEsIDYzMiwgNjMzLCA2MzQsIDYzNSwgNjM2LCA2MzcsIDYzOCwgNjM5LCA2NDAsIDY0MSwgNjQyLCA2NDMsIDY0NCwgNjQ1LCA2NDYsIDY0NywgNjQ4LCA2NDksIDY1MCwgNjUxLCA2NTIsIDY1MywgNjU0LCA2NTUsIDY1NiwgNjU3LCA2NTgsIDY1OSwgNjYwLCA2NjEsIDY2NiwgNjcxLCA2NzIsIDY3NCwgNjc2LCA2NzcsIDY3OSwgNjgwLCA2ODIsIDY4NSwgNjg2LCA2ODcsIDY4OSwgNjkxLCA2OTIsIDY5NSwgNjk3LCA3MDEsIDcwMywgNzEwLCA3NTYsIDc2MCwgNzYxLCA3NjIsIDc2NCwgNzY1LCA3NjYsIDc2NywgNzY4LCA3NjkpKSBPUiAoQU1fR1JPVVAuR1JPVVBfSUQgaW4gKDU1MSkpICBPUiAoQU1fR1JPVVAuR1JPVVBfSUQgPSA1NTMpICkpIEFORCAoKCgoKEFNX0RPTUFJTi5MT0NBVElPTl9JRCBpbiAoU0VMRUNUIExPQ0FUSU9OX0lEIEZST00gQU1fTE9DQVRJT04gV0hFUkUgKExGVCA8IChTRUxFQ1QgTEZUIEZST00gQU1fTE9DQVRJT04gV0hFUkUgTE9DQVRJT05fSUQgPSAzNjQ0KSBBTkQgUkdUID4gKFNFTEVDVCBSR1QgRlJPTSBBTV9MT0NBVElPTiBXSEVSRSBMT0NBVElPTl9JRCA9IDM2NDQpKSBPUiBBTV9ET01BSU4uTE9DQVRJT05fSUQgPSAzNjQ0KSkgQU5EIChBTV9ET01BSU4uREVQQVJUTUVOVF9JRCBpbiAoU0VMRUNUIERFUEFSVE1FTlRfSUQgRlJPTSBBTV9ERVBBUlRNRU5UIFdIRVJFIChMRlQgPCAoU0VMRUNUIExGVCBGUk9NIEFNX0RFUEFSVE1FTlQgV0hFUkUgREVQQVJUTUVOVF9JRCA9IDUpIEFORCBSR1QgPiAoU0VMRUNUIFJHVCBGUk9NIEFNX0RFUEFSVE1FTlQgV0hFUkUgREVQQVJUTUVOVF9JRCA9IDUpKSBPUiBBTV9ET01BSU4uREVQQVJUTUVOVF9JRCA9IDUpKSAgQU5EIChBTV9ET01BSU4uU0RfQ0FUQUxPR19JRCBpbiAoU0VMRUNUIFNEX0NBVEFMT0dfSUQgRlJPTSBTRF9DQVRBTE9HIFdIRVJFIChMRlQgPCAoU0VMRUNUIExGVCBGUk9NIFNEX0NBVEFMT0cgV0hFUkUgU0RfQ0FUQUxPR19JRCA9IDE4MTUyNykgQU5EIFJHVCA%252BIChTRUxFQ1QgUkdUIEZST00gU0RfQ0FUQUxPRyBXSEVSRSBTRF9DQVRBTE9HX0lEID0gMTgxNTI3KSkgT1IgQU1fRE9NQUlOLlNEX0NBVEFMT0dfSUQgPSAxODE1MjcpKSApKSBPUiAoKChBTV9ET01BSU5fTE9DQVRJT04uTE9DQVRJT05fSUQgaW4gKFNFTEVDVCBMT0NBVElPTl9JRCBGUk9NIEFNX0xPQ0FUSU9OIFdIRVJFIChMRlQgPCAoU0VMRUNUIExGVCBGUk9NIEFNX0xPQ0FUSU9OIFdIRVJFIExPQ0FUSU9OX0lEID0gMzY0NCkgQU5EIFJHVCA%252BIChTRUxFQ1QgUkdUIEZST00gQU1fTE9DQVRJT04gV0hFUkUgTE9DQVRJT05fSUQgPSAzNjQ0KSkgT1IgQU1fRE9NQUlOX0xPQ0FUSU9OLkxPQ0FUSU9OX0lEID0gMzY0NCkpIEFORCAoQU1fRE9NQUlOX0RFUEFSVE1FTlQuREVQQVJUTUVOVF9JRCBpbiAoU0VMRUNUIERFUEFSVE1FTlRfSUQgRlJPTSBBTV9ERVBBUlRNRU5UIFdIRVJFIChMRlQgPCAoU0VMRUNUIExGVCBGUk9NIEFNX0RFUEFSVE1FTlQgV0hFUkUgREVQQVJUTUVOVF9JRCA9IDUpIEFORCBSR1QgPiAoU0VMRUNUIFJHVCBGUk9NIEFNX0RFUEFSVE1FTlQgV0hFUkUgREVQQVJUTUVOVF9JRCA9IDUpKSBPUiBBTV9ET01BSU5fREVQQVJUTUVOVC5ERVBBUlRNRU5UX0lEID0gNSkpICBBTkQgKEFNX0RPTUFJTl9TRF9DQVRBTE9HLlNEX0NBVEFMT0dfSUQgaW4gKFNFTEVDVCBBTV9ET01BSU5fU0RfQ0FUQUxPRy5TRF9DQVRBTE9HX0lEIGZyb20gQU1fRE9NQUlOX1NEX0NBVEFMT0cgd2hlcmUgQU1fRE9NQUlOX1NEX0NBVEFMT0cuU0RfQ0FUQUxPR19JRCBpbiAoIFNFTEVDVCBTRF9DQVRBTE9HX0lEIEZST00gU0RfQ0FUQUxPRyBXSEVSRSAoTEZUIDwgKFNFTEVDVCBMRlQgRlJPTSBTRF9DQVRBTE9HIFdIRVJFIFNEX0NBVEFMT0dfSUQgPSAxODE1MjcpIEFORCBSR1QgPiAoU0VMRUNUIFJHVCBGUk9NIFNEX0NBVEFMT0cgV0hFUkUgU0RfQ0FUQUxPR19JRCA9IDE4MTUyNykpKSBPUiBBTV9ET01BSU5fU0RfQ0FUQUxPRy5TRF9DQVRBTE9HX0lEID0gMTgxNTI3KSkgKSkgKSkgKQ%253D%253D%26keyFirst%3D%26noUrldecode%3DNOURLDECODE_TAG%26applyHashingValue%3Dtrue%26params%3D[]%26recipientId%3D%26requestorId%3D%26term%3D',

            // связка с группой get
            'urlAssignTiket' => '/Wizard.php?PHPSESSID=' . $sessionId
                . '&init_wizard=true&dialog_guid=%7B90D54E77-40A5-4F0F-8029-5A7A05F5814D%7D&batch_id=' . $idTiket
                . '&wizard_from=quickcall&guid=%7B949F1C2D-7BBF-4BE3-9E49-1ADD0A9436DA%7D&pk_tablename=SD_REQUEST&theme=%7BC9F11D78-448E-4EAC-A766-C904ED98458E%7D&wizard_next_pages=true&main_guid_var=VAR_949F1C2D_7BBF_4BE3_9E49_1ADD0A9436DA',

            // связка с группой get
            'urlAfterTiket' => '/Wizard.php?' . $session
                . '&init_wizard=true&dialog_guid=%7B90D54E77-40A5-4F0F-8029-5A7A05F5814D%7D&batch_id=' . $idTiket
                . '&wizard_from=quickcall&guid=%7B949F1C2D-7BBF-4BE3-9E49-1ADD0A9436DA%7D&pk_tablename=SD_REQUEST&theme=%7BC9F11D78-448E-4EAC-A766-C904ED98458E%7D&wizard_next_pages=true&main_guid_var=VAR_949F1C2D_7BBF_4BE3_9E49_1ADD0A9436DA',

            // шаг 1 ссылка для отправки на группу post
            'urlSendOnGroupTiket1' => '/Wizard.php?PHPSESSID=' . $sessionId
                . '&guid=949F1C2D-7BBF-4BE3-9E49-1ADD0A9436DA&main_guid_var=VAR_949F1C2D_7BBF_4BE3_9E49_1ADD0A9436DA&cpt=6&frompage=6&action=next',
            // шаг 2 ссылка для отправки на группу get
            'urlSendOnGroupTiket2' => '/Wizard.php?PHPSESSID=' . $sessionId
                . '&guid=949F1C2D-7BBF-4BE3-9E49-1ADD0A9436DA&main_guid_var=VAR_949F1C2D_7BBF_4BE3_9E49_1ADD0A9436DA&cpt=9&frompage=10&action=next',
            // шаг 3 ссылка для отправки на группу post
            'urlSendOnGroupTiket3' => '/Wizard.php?PHPSESSID=' . $sessionId
                . '&guid=949F1C2D-7BBF-4BE3-9E49-1ADD0A9436DA&main_guid_var=VAR_949F1C2D_7BBF_4BE3_9E49_1ADD0A9436DA&cpt=10&frompage=65&action=next',

        ];

        return $link;
    }

    public function getFormData()
    {
        $formData = [
            'nameGroup' => 'RUS L1 - Support Center',
            // получаем функцией в процессе
            'idGroup' => '',
            // путь к файлу
            'urlFile' => 'http://w7ru09990004/img/hellfire.jpg',
            //
            'citId' => '3680',
            //
            'citName' => '999R - Multiple Sites Russia',
            //
            'cimPriority' => '2',
            // прогназируемое время решения, получаем из функции reloadFormGet()
            'sla' => [],
            //
            'typeTiket' => 'Incident',
            //
            'topicNameiket' => 'COUNTRY BUSINESS/GIMA/TRANSFERS',
            //
            'topicId' => '181570',
            //
            'title' => 'АУРА',
            //
            'freeComment' => 'УРА',
            //
            'textTiket' => 'Тест999',
        ];

        return $formData;
    }
}
