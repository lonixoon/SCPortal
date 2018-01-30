<?php

namespace App\Http\Controllers;

use App\DomainUser;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    /*
     * Раздаём логин из базы по всем функциеям которые его требуют
     */
    public function userAuthData()
    {
        $DomainUser = new DomainUser();
        $user = $DomainUser->users();
        return $user;
    }
}
