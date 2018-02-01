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
     */
    public function crateLink($session)
    {
        // сессия
        $PHPSESSID = $session['PHPSESSID'];
        // время жизни сессии
        $internalurltime = $session['internalurltime'];


        $link = [
            // сслыка для логаута, чтобы не засорять сессии
            'urlLogout' => 'https://athena.easyvista.com/index.php?logout=1&PHPSESSID=' . $PHPSESSID
                . '&internalurltime' . $internalurltime,
            // создаём ссылку получения уникальной ссылки на новый тикет
            'urlGetIdTiket' => 'index.php?PHPSESSID=' . $PHPSESSID . '&internalurltime=' . $internalurltime
                . '&theme=%7BC9F11D78-448E-4EAC-A766-C904ED98458E%7D&do_quickcall=2&quickcall_id=284152&new_rqst=1',
        ];

        return $link;
    }
}
