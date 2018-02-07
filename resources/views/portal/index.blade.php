@extends('layouts.app')

@section('navbar')
    <nav class="navbar navbar-default navbar-static-top">
        <div class="navbar-header">
            <!-- Branding Image -->
            <router-link to="/" class="navbar-brand">SCPortal</router-link>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="nav__item">
                    <router-link :to="{ name: 'dailyStatusPortal'}">Daily Status Portal</router-link>
                </li>
                <li class="nav__item">
                    <router-link :to="{name: 'dailyStatusHD'}">Daily Status Helpdesk</router-link>
                </li>
                <li class="nav__item">
                    <router-link :to="{name: 'dailyStatusHDTest'}">Test DS HD</router-link>
                </li>
            </ul>
        </div>
    </nav>
@endsection

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
        {{--<div class="col-md-10 col-md-offset-2">--}}
            <div class="panel panel-default">
                {{--<div class="panel-heading">Support Center Portal</div>--}}

                <div class="panel-body">
                    <router-view name="portalIndex"></router-view>
                    <router-view></router-view>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection