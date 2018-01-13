<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Portal extends Model
{
    public $user = 'rus9211689';
    public $pass = 'Cc123123*';
    public $url = 'http://portal.ru.auchan.com/portal/Login.aspx';
    public $ua = 'User-Agent:Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 YaBrowser/17.6.0.1631 Yowser/2.5 Safari/537.36';


    public function getAuth()
    {

    }

    public function getToken()
    {

    }

}
