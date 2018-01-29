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
}
