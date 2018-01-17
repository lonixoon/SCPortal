@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-default">
                <div class="panel-heading">Support Center Portal</div>

                <div class="panel-body">
                    <router-view name="portalIndex"></router-view>
                    <router-view></router-view>
                    {{--<p>--}}
                        {{--<a href="http://w7ru09990004/daily-status-portal/result">Daily Status Portal</a>--}}
                    {{--</p>--}}
                    {{--<p>--}}
                        {{--<a href="http://w7ru09990004/daily-status-helpdesk">Daily Status Helpdesk</a>--}}
                    {{--</p>--}}
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
