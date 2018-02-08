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
//Route::get('/home', 'HomeController@index')->name('home');
Route::get('/', 'SCPortalController@index');

Auth::routes();


// Portal Daily Status
    // выгружнный отчёт в виде api
Route::get('/daily-status-portal/portal-classic', 'DailyStatusPortalController@indexPortalClassic');
    // выгружнный отчёт в виде api
Route::get('/daily-status-portal/portal-atak', 'DailyStatusPortalController@indexPortalAtak');

// Portal Admin Daily Status
    // выгружнный отчёт в виде api
Route::get('/daily-status-admin-portal/portal-classic', 'DailyStatusAdminPortalController@indexAdminPortalClassic');
    // выгружнный отчёт в виде api
Route::get('/daily-status-admin-portal/portal-atak', 'DailyStatusAdminPortalController@indexAdminPortalAtak');

// HelpDesk Daily Status
    // выгружнный отчёт в виде api
Route::post('/daily-status-helpdesk/result', 'DailyStatusHDController@getFile');

// Атена
Route::get('/athena', 'AthenaController@index');
Route::post('/athena', 'AthenaController@index');

// domain users
//Route::get('/users', 'SCPortalController@users');



// учебный
//Route::group(['middleware' => ['auth'], 'prefix' => 'admin', 'as' => 'admin.'], function () {
    Route::get('companies', 'CompaniesController@index')->name('companies.index');
//});
