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
        $DailyStatusHD = new DailyStatusHD();
        // Передаём файл -> получаем очищенный от всех тегов текст
        $text = $DailyStatusHD->rtf2text($file);
        // Передаём текст -> получаем очищенный массив
        $array = $DailyStatusHD->getArray($text);
        // Передаём очищенный массив -> получаем готовые данные
        $result['sopraInGica'] = $DailyStatusHD->getSopraInGica($array);
        $result['catalogFromGica'] = $DailyStatusHD->getData($array);
//        $result = $DailyStatusHD->getData($array);

//        return view('portal.daily-status-hd.test2-2', $result);
        return $result;
    }

    public function getFile2(Request $rtf)
    {
        $this->validate($rtf, [
            'file' => 'required | mimes:rtf'
        ]);

        // получаем файл
        $file = $rtf->file('file');
        // создаём новую модель
        $DailyStatusHD = new DailyStatusHD();
        // Передаём файл -> получаем очищенный от всех тегов текст
        $text = $DailyStatusHD->rtf2text($file);
        // Передаём текст -> получаем очищенный массив
        $array = $DailyStatusHD->getArray($text);
        // Передаём очищенный массив -> получаем готовые данные
        $result = $DailyStatusHD->getSopraInGica($array);
//        $result = $DailyStatusHD->getData($array);

//        return view('portal.daily-status-hd.test2-2', $result);
        return $result;
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
