<?php

namespace App\Http\Controllers;

use GuzzleHttp\Cookie\CookieJar;
use Illuminate\Http\Request;
use Symfony\Component\DomCrawler\Crawler;
//use Goutte\Client;
use GuzzleHttp\Client;


class PortalControllerCOPY extends Controller
{
    public $user = 'rus9211689';
    public $password = 'Cc123123*';
    public $baseUrl = 'http://portal.ru.auchan.com/portal/';
//    public $url = 'http://portal.ru.auchan.com/portal/Login.aspx';
    public $ua =  'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36';


    //    public function index()
//    {
//        return view('portal.index');
//    }

    // получаем разметку страници
//    public function getHtml()
//    {
//        return $html = file_get_contents($this->url);
//    }

    // забираем токены с формы
//    public function getToken()
////    public function index()
//    {
//        $html = $this->getHtml();
//        $crawler = new Crawler(null, $this->url);
//        $crawler->addHtmlContent($html, 'UTF-8');
//        $result['viewState'] = $crawler->filter('#__VIEWSTATE')->attr('value');
//        $result['eventValidation'] = $crawler->filter('#__EVENTVALIDATION')->attr('value');
//        dump($result);
//        return $result;
//    }

//    public function getAuth()
    public function index()
    {
        $client = new Client([
            // Base URI is used with relative requests
            'base_uri' => 'http://portal.ru.auchan.com/portal/',
            // You can set any number of default request options.
            'timeout'  => 60.0,
        ]);
        $cookieJar = new CookieJar();
/*
        $response = $client->post('Login.aspx', [
                'form_params' => [
                    '__EVENTTARGET' => '',
                    '__EVENTARGUMENT' => '',
                    '__LASTFOCUS' => '',
                    '__VIEWSTATE' => '/wEPDwUJMzgzMzg4MjUwD2QWAgIDD2QWCmYPDxYCHgRUZXh0BQrQm9C+0LPQuNC9ZGQCAg8PFgIfAAUM0J/QsNGA0L7Qu9GMZGQCBA8PFgIfAAUI0K/Qt9GL0LpkZAIFDxBkZBYBZmQCBg8WAh4FdmFsdWUFCNCS0YXQvtC0ZGQniGTj7tOUIsgb60FVI4XE91+HLQ==',
                    '__EVENTVALIDATION' => '/wEWCQKAufxaAq+m6rYIAvK94JEPAvn6+RsCyYGW8wICjo+S1wQCgtyHhgwC7c2/agL6r+qNDFf2caYpL6FwNpwNbTiwK+9t04HV',
                    'username' => $this->user,
                    'password' => $this->password,
                    'ddlLanguage' => 'ru-RU',
                    'btnLogin' => 'Вход',
                    'hidscreenWidth' => '',
                    'hidscreenHeight' => '',
//                    'action' => 'btnLogin',

                ],
                'cookies' => $cookieJar,
                'headers' => [
                    'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36',
                    'Accept'     => 'application/x-www-form-urlencoded',
                ],
                'allow_redirects' => true,
            ]
        );
        */

        $response = $client->request('POST', 'Login.aspx', [
                'form_params' => [
                    '__EVENTTARGET' => '',
                    '__EVENTARGUMENT' => '',
                    '__LASTFOCUS' => '',
                    '__VIEWSTATE' => '/wEPDwUJMzgzMzg4MjUwD2QWAgIDD2QWCmYPDxYCHgRUZXh0BQrQm9C+0LPQuNC9ZGQCAg8PFgIfAAUM0J/QsNGA0L7Qu9GMZGQCBA8PFgIfAAUI0K/Qt9GL0LpkZAIFDxBkZBYBZmQCBg8WAh4FdmFsdWUFCNCS0YXQvtC0ZGQniGTj7tOUIsgb60FVI4XE91+HLQ==',
                    '__EVENTVALIDATION' => '/wEWCQKAufxaAq+m6rYIAvK94JEPAvn6+RsCyYGW8wICjo+S1wQCgtyHhgwC7c2/agL6r+qNDFf2caYpL6FwNpwNbTiwK+9t04HV',
                    'username' => $this->user,
                    'password' => $this->password,
                    'ddlLanguage' => 'ru-RU',
                    'btnLogin' => 'Вход',
                    'hidscreenWidth' => '',
                    'hidscreenHeight' => '',
//                    'action' => 'btnLogin',

                ],
                'cookies' => $cookieJar,
                'headers' => [
                    'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36',
                    'Accept'     => 'application/x-www-form-urlencoded',
                ],
                'allow_redirects' => true,
            ]
        );
/*
        $response2 = $client->post('Brief.aspx?pg=412100', [
                'form_params' => [
                    'ctl00$smPortal' => 'ctl00$cphMain$upStore|ctl00$cphMain$ctl06$btn',
                    '__EVENTTARGET' => '',
                    '__EVENTARGUMENT' => '',
                    '__VIEWSTATE' => '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YWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EOMzksIDM5LCAyMCwgMjAyxQIAAQAAAP////8BAAAAAAAAAAwCAAAAUVN5c3RlbS5EcmF3aW5nLCBWZXJzaW9uPTIuMC4wLjAsIEN1bHR1cmU9bmV1dHJhbCwgUHVibGljS2V5VG9rZW49YjAzZjVmN2YxMWQ1MGEzYQUBAAAAIVN5c3RlbS5EcmF3aW5nLlByaW50aW5nLlBhcGVyU2l6ZQUAAAAEa2luZARuYW1lBXdpZHRoBmhlaWdodBtjcmVhdGVkQnlEZWZhdWx0Q29uc3RydWN0b3IEAQAAACFTeXN0ZW0uRHJhd2luZy5QcmludGluZy5QYXBlcktpbmQCAAAACAgBAgAAAAX9////IVN5c3RlbS5EcmF3aW5nLlByaW50aW5nLlBhcGVyS2luZAEAAAAHdmFsdWVfXwAIAgAAAAAAAAAGBAAAAACdBAAAJwYAAAALZ2QyrAkAAQAAAP////8BAAAAAAAAAAwCAAAAY01pY3Jvc29mdC5SZXBvcnRWaWV3ZXIuV2ViRm9ybXMsIFZlcnNpb249MTAuMC4wLjAsIEN1bHR1cmU9bmV1dHJhbCwgUHVibGljS2V5VG9rZW49YjAzZjVmN2YxMWQ1MGEzYQUBAAAAMU1pY3Jvc29mdC5SZXBvcnRpbmcuV2ViRm9ybXMuRGV2aWNlSW5mb0NvbGxlY3Rpb24FAAAAGktleWVkQ29sbGVjdGlvbmAyK2NvbXBhcmVyFktleWVkQ29sbGVjdGlvbmAyK2RpY3QaS2V5ZWRDb2xsZWN0aW9uYDIra2V5Q291bnQbS2V5ZWRDb2xsZWN0aW9uYDIrdGhyZXNob2xkEkNvbGxlY3Rpb25gMStpdGVtcwMDAAADFlN5c3RlbS5PcmRpbmFsQ29tcGFyZXKUAlN5c3RlbS5Db2xsZWN0aW9ucy5HZW5lcmljLkRpY3Rpb25hcnlgMltbU3lzdGVtLlN0cmluZywgbXNjb3JsaWIsIFZlcnNpb249Mi4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iNzdhNWM1NjE5MzRlMDg5XSxbTWljcm9zb2Z0LlJlcG9ydGluZy5XZWJGb3Jtcy5EZXZpY2VJbmZvLCBNaWNyb3NvZnQuUmVwb3J0Vmlld2VyLldlYkZvcm1zLCBWZXJzaW9uPTEwLjAuMC4wLCBDdWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2FdXQgIsQFTeXN0ZW0uQ29sbGVjdGlvbnMuR2VuZXJpYy5MaXN0YDFbW01pY3Jvc29mdC5SZXBvcnRpbmcuV2ViRm9ybXMuRGV2aWNlSW5mbywgTWljcm9zb2Z0LlJlcG9ydFZpZXdlci5XZWJGb3JtcywgVmVyc2lvbj0xMC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iMDNmNWY3ZjExZDUwYTNhXV0CAAAACQMAAAAKAAAAAAAAAAAJBAAAAAQDAAAAFlN5c3RlbS5PcmRpbmFsQ29tcGFyZXIBAAAAC19pZ25vcmVDYXNlAAEBBAQAAACxAVN5c3RlbS5Db2xsZWN0aW9ucy5HZW5lcmljLkxpc3RgMVtbTWljcm9zb2Z0LlJlcG9ydGluZy5XZWJGb3Jtcy5EZXZpY2VJbmZvLCBNaWNyb3NvZnQuUmVwb3J0Vmlld2VyLldlYkZvcm1zLCBWZXJzaW9uPTEwLjAuMC4wLCBDdWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2FdXQMAAAAGX2l0ZW1zBV9zaXplCF92ZXJzaW9uBAAAKU1pY3Jvc29mdC5SZXBvcnRpbmcuV2ViRm9ybXMuRGV2aWNlSW5mb1tdAgAAAAgICQUAAAAAAAAAAAAAAAcFAAAAAAEAAAAAAAAABCdNaWNyb3NvZnQuUmVwb3J0aW5nLldlYkZvcm1zLkRldmljZUluZm8CAAAACxYCAgEPZBYCZg9kFgJmD2QWDAIBDw8WAh8EaGQWAgIDD2QWBAIBDw8WAh8ABQVydS1SVWRkAgIPEA8WAh4HQ2hlY2tlZGhkZGRkAgIPZBYCAgIPFgIeBVZhbHVlBQVmYWxzZWQCAw9kFgJmD2QWAmYPDxYCHwRoZGQCBQ9kFgICAg8WAh8NBQVmYWxzZWQCBg9kFgJmD2QWAmYPZBYEZg8PZBYCHgVzdHlsZQUQdmlzaWJpbGl0eTpub25lO2QCAw8PFgIeDVZpZXdJdGVyYXRpb24CAWQWBAIBDxYCHgdFbmFibGVkaGQCBA8WAh8NBQhGdWxsUGFnZWQCCg9kFgICAQ8WAh8NBQVGYWxzZWQCAw8PFgIfAGVkZAIXD2QWAgIDD2QWBmYPFgIfBQUO0KHQv9GA0LDQstC60LBkAgIPZBYCAgEPFgIfBQUS0J3QsNGB0YLRgNC+0LnQutC4ZAIDDw9kFgIeB29uQ2xpY2sFMnJldHVybiBjb25maXJtKCfQl9Cw0LrQvtC90YfQuNGC0Ywg0YDQsNCx0L7RgtGDPycpZBgBBR5fX0NvbnRyb2xzUmVxdWlyZVBvc3RCYWNrS2V5X18WAwUhY3RsMDAkY3BoTWFpbiR1Y05vbWFUcmVlMjEkdHdUZXN0BSZjdGwwMCRjcGhNYWluJHJ2UmVwb3J0JFRvZ2dsZVBhcmFtJGltZwUgY3RsMDAkY3BoTWFpbiRydlJlcG9ydCRjdGwwOCRpbWc4WTbSh1/CH1qQObX/RkIvhd19Pg==',
                    'ctl00$cphMain$ucNomaTree21$heightTree' => '10',
                    'ctl00$cphMain$ucNomaTree21$positionTB' => '',
                    'ctl00$cphMain$ctl06$inlineDay' => '08.01.2018',
                    'ctl00$cphMain$ctl06$inlineDay2' => '08.01.2018',
                    'ctl00$cphMain$tb_Position' => '0',
                    'ctl00$cphMain$tbTreeY' => '182',
                    'ctl00$cphMain$rvReport$ctl03$ctl00' => '',
                    'ctl00$cphMain$rvReport$ctl03$ctl01' => '',
                    'ctl00$cphMain$rvReport$ctl11' => '',
                    'ctl00$cphMain$rvReport$ctl12' => 'quirks',
                    'ctl00$cphMain$rvReport$AsyncWait$HiddenCancelField' => 'False',
                    'ctl00$cphMain$rvReport$ToggleParam$store' => '',
                    'ctl00$cphMain$rvReport$ToggleParam$collapse' => 'false',
                    'ctl00$cphMain$rvReport$ctl09$ClientClickedId' => '',
                    'ctl00$cphMain$rvReport$ctl08$store' => '',
                    'ctl00$cphMain$rvReport$ctl08$collapse' => 'false',
                    'ctl00$cphMain$rvReport$ctl10$VisibilityState$ctl00' => 'ReportPage',
                    'ctl00$cphMain$rvReport$ctl10$ScrollPosition' => '',
                    'ctl00$cphMain$rvReport$ctl10$ReportControl$ctl02' => '',
                    'ctl00$cphMain$rvReport$ctl10$ReportControl$ctl03' => '',
                    'ctl00$cphMain$rvReport$ctl10$ReportControl$ctl04' => 'FullPage',
                    'ctl00$cphMain$txtExit' => '',
                    '__ASYNCPOST' => 'true',
                    'ctl00$cphMain$ctl06$btn' => 'Показать отчёт',
                ],
                'cookies' => $cookieJar,
                'headers' => [
                    'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36',
                    'Accept'     => 'application/x-www-form-urlencoded; charset=UTF-8',
                ],
                'allow_redirects' => true,
            ]
        );
*/
        $response2 = $client->get('main.aspx', ['cookies' => $cookieJar]);
//        $response3 = $client->get('pg412100.aspx', ['cookies' => $cookieJar]);
        $xml = $response2->getBody()->getContents();
        echo $xml;

        /*
        $http = curl_init($this->url);
        $token = $this->getToken();
        curl_setopt($http, CURLOPT_HEADER, 1);// показывать заголовки (в них куки):
        curl_setopt($http, CURLOPT_USERAGENT, $this->ua);// это чтобы прикинуться браузером:
        curl_setopt($http, CURLOPT_REFERER, $this->url);
        curl_setopt($http, CURLOPT_POSTFIELDS, [
            "__EVENTTARGET" => ''
            , "__EVENTARGUMENT" => ''
            , "__LASTFOCUS" => ''
//            , "__VIEWSTATE" => '/wEPDwUJMzgzMzg4MjUwD2QWAgIDD2QWCmYPDxYCHgRUZXh0BQrQm9C+0LPQuNC9ZGQCAg8PFgIfAAUM0J/QsNGA0L7Qu9GMZGQCBA8PFgIfAAUI0K/Qt9GL0LpkZAIFDxBkZBYBZmQCBg8WAh4FdmFsdWUFCNCS0YXQvtC0ZGQniGTj7tOUIsgb60FVI4XE91+HLQ=='
            , "__VIEWSTATE" => $token['viewState']
//            , "__EVENTVALIDATION" => '/wEWCQKAufxaAq+m6rYIAvK94JEPAvn6+RsCyYGW8wICjo+S1wQCgtyHhgwC7c2/agL6r+qNDFf2caYpL6FwNpwNbTiwK+9t04HV'
            , "__EVENTVALIDATION" => $token['eventValidation']
            , "username" => $this->user
            , "password" => $this->password
            , "ddlLanguage" => 'ru-RU'
            , "btnLogin" => 'Вход'
            , "hidscreenWidth" => ''
            , "hidscreenHeight" => ''
        ]);
        curl_setopt($http, CURLOPT_RETURNTRANSFER, true);
        $result = curl_exec($http);
        echo $result;

        dump($result);
        curl_close($http);
        */
    }
}
