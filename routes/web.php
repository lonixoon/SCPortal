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
Route::get('/daily-status-portal/portal-classic', 'DailyStatusPortalController@getPortalClassicHtml');
Route::get('/daily-status-portal/portal-atak', 'DailyStatusPortalController@getPortalAtakHtml');

Route::get('/daily-status-admin-portal/portal-classic', 'DailyStatusAdminPortalController@getAdminPortalClassicHtml');

// без испульзования VueJS
//Route::get('/daily-status-portal/result', 'DailyStatusPortalController@index');

Route::get('/daily-status-portal/api/classic', 'DailyStatusPortalController@apiClassic');
Route::get('/daily-status-portal/api/atak', 'DailyStatusPortalController@apiAtak');

//Route::get('/daily-status-portal/api/admin-classic', 'DailyStatusPortalController@apiAdminClassic');

// HD DS
Route::get('/daily-status-helpdesk', 'DailyStatusHDController@index');
Route::post('/daily-status-helpdesk/result', 'DailyStatusHDController@getFile');

//Route::group(['middleware' => ['auth'], 'prefix' => 'admin', 'as' => 'admin.'], function () {
    Route::get('companies', 'CompaniesController@index')->name('companies.index');
//});
