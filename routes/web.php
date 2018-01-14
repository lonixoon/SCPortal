<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//Route::get('/', function () {
//    return view('welcome');
//});
Route::get('/', 'SCPortalController@index');

Auth::routes();
//Route::get('/home', 'HomeController@index')->name('home');

// DailyStatusPortal DS
//Route::get('/po', 'DailyStatusPortalController@getHtmlComparativeReport');
Route::get('/po', 'DailyStatusPortalController@getPortalClassicHtml');
Route::get('/po2', 'DailyStatusPortalController@getPortalAtakHtml');
Route::get('/por', 'DailyStatusPortalController@processingData');
//Route::get('/por', 'DailyStatusPortalController@processingData');

// HD DS
Route::get('/daily-status-helpdesk', 'DailyStatusHDController@index');
Route::post('/daily-status-helpdesk/result', 'DailyStatusHDController@getFile');

Route::group(['middleware' => ['auth'], 'prefix' => 'admin', 'as' => 'admin.'], function () {
    Route::get('companies', 'CompaniesController@index')->name('companies.index');
});
