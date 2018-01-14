<?php

namespace App\Http\Controllers;

use GuzzleHttp\Cookie\CookieJar;
use Illuminate\Http\Request;
use Symfony\Component\DomCrawler\Crawler;
use GuzzleHttp\Client;


class SCPortalController extends Controller
{
        public function index()
    {
        return view('portal.index');
    }
}
