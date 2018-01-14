<?php

namespace App\Http\Controllers;

use App\DailyStatusHD;
use Illuminate\Http\Request;

class DailyStatusHDController extends Controller
{
    public function index()
    {
        return view('portal.daily-status-hd.test2-1');
    }

    public function getFile(Request $rtf)
    {
        $this->validate($rtf, [
            'file' => 'required | mimes:rtf'
        ]);

        // получаем файл
        $file = $rtf->file('file');
        // создаём новую модель
        $test2 = new DailyStatusHD();
        // Передаём файл -> получаем очищенный от всех тегов текст
        $text = $test2->rtf2text($file);
        // Передаём текст -> получаем очищенный массив
        $array = $test2->getArray($text);
        // Передаём очищенный массив -> получаем готовые данные
        $result['list'] = $test2->getData($array);
        // Получаем количство тикетов
//        $result['numberOfRecords'] = count($result['list']);

        return view('portal.daily-status-hd.test2-2', $result);
    }
}


//        foreach ($result as $key => $value) {
//            echo '<p>';
//            echo '<div>' . $key . '</div>
//                  <div>sites:</div>';
//            foreach ($value as $key2 => $value2) {
//                echo '<span>' . $value2 . ', </span>';
//            }
//            echo '<div>------------------------------------------------------------</div>
//                  </p>';
//        }
// поиск по массиву с помощью регулярки
//        $arrSite = $filtered = array_filter($catalogOnly, function ($item) {
//            return preg_match('/T.*$/', $item);
//        });
