<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Symfony\Component\DomCrawler\Crawler;

class DailyStatusAdminPortal extends Model
{
    /*
     * в переданном html ищем нужные поля и сохраняем их в массивы
     * получаем html, возвращаем массивы с данными
     */
    public function getDataInAdminPortal($html)
    {
        // создаем новую модель кравлера
        $crawler = new Crawler();
        // добавляем ссылку в кравлер и получаем весь контент
        $crawler->addHtmlContent($html, 'UTF-8');

        // забираем циклом название проблемных витрин
        $dataAdminPortal['showcaseNames'] = $crawler
            // поиск осуществляем по постаянному кусочку от id
//            ->filterXPath('//td//*[contains(@id,"' . $tegParse['showcaseName'] . '")]')
            ->filterXPath('//td//*[contains(@id,"Name")]')
            ->each(function (Crawler $node, $i) {
                return $node->text();
            });
        // первый элемент с указанным кусочком id какая хрень, его отсикаем
        $dataAdminPortal['showcaseNames'] = array_slice($dataAdminPortal['showcaseNames'], 1);

        //забираем циклом статус проблемных витрин
        $dataAdminPortal['showcaseStatus'] = $crawler
            // поиск осуществляем по постаянному кусочку от id
            ->filterXPath('//span[contains(@id,"_lblStatus")]')
            ->each(function (Crawler $node, $i) {
                return $node->text();
            });

        // возванищая два миссва 1) название всех витрин 2) статусы
        return $dataAdminPortal;
    }

    /*
     *  Передаём массивы с данными, получаем один массив: витрина => статус
     */
    public function processingData(array $dataAdminPortal)
    {
        // массив где ключ это название витрины, наение её статус
        $allShowcase = [];
        $problemShowcase = [];


        /*
         * Перебираем название витрин.
         * Добавляем к нему индекс (витрину могут перезапустить и получится два ключа с одинаковым именем).
         */
//        $arrCount = count($dataAdminPortal['showcaseNames']);
//        foreach ($dataAdminPortal['showcaseNames'] as $key => $showcaseName) {
////            $showcaseName = $key + 1 . ') ' . $showcaseName;
//            --$arrCount;
//            $showcaseName = $arrCount + 1 . ') ' . $showcaseName;
//            $allShowcase[$showcaseName] = $dataAdminPortal['showcaseStatus'][$key];
//        }

        /*
         * Передаём массивы с данными и убераем перезапущенные витрины,
         * получаем один массив: витрина => статус
         */
        foreach ($dataAdminPortal['showcaseNames'] as $showcaseIndex => $showcaseName) {
            if (!(array_key_exists($showcaseName, $allShowcase))) {
                $allShowcase[$showcaseName] = $dataAdminPortal['showcaseStatus'][$showcaseIndex];
            }
        }
//        dd($allShowcase);

        /*
         *  Оставляем витрины в статусе Ошибка
         */
        foreach ($allShowcase as $showcase => $status) {
            if ($status === 'Ошибка') {
                $problemShowcase[$showcase] = $status;
            }
        }
        // возвращаем массив: Название витрины => Статус
        return $problemShowcase;
    }


    /*
     * Получения токена для формы
     * Примает html, взващает массив с двуми токенами
     */
    public function getToken($html)
    {
        $crawler = new Crawler();
        // передаём html в кравлер
        $crawler->addHtmlContent($html, 'UTF-8');
        // получаем первый токен
        $token['viewState'] = $crawler->filterXPath('//input[@id="__VIEWSTATE"]')->attr('value');
        // получаем второй токен
        $token['eventValidation'] = $crawler->filterXPath('//input[@id="__EVENTVALIDATION"]')->attr('value');
        // возващаяем массив с двумя токенами
        return $token;
    }


    /*
     *  Создаёт нуженые нам даты для отправики пост запроса
     */
    public function createDateForForm()
    {
        $date['today'] = date("d.m.Y");
        $date['previousDay'] = date("d.m.Y", strtotime("-1 days"));
        // делаем формат ПРИМЕР! '28.03.2018 18:00'
        $dateForm['previousDay'] = $date['previousDay'] . ' 18:00';
        // делаем формат ПРИМЕР! '29.03.2018 23:59'
        $dateForm['today'] = $date['today'] . ' 23:59';
        // возвращаем массив с двумя датами
        return $dateForm;
    }
}
