<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class DomainUser extends Model
{
    public function users()
    {
        $adminUser = $this->all()->filter(function ($value, $key) {
            return $value['id'] == '2';
        });
        $adminUser = $adminUser['1'];
        return $adminUser;
    }

    public function usersXru()
    {
        $user = $this->all()->filter(function ($value, $key) {
            return $value['id'] == '1';
        });
        $user = $user['0'];
        return $user;

    }
}
