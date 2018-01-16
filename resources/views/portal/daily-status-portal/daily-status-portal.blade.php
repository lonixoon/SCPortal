@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">Daily Status Portal</div>

                <div class="panel-body">
                    <div style="display: inline-flex">
                        @foreach ($allProblemCiteArr as $portalName => $portalData)
                            <div style="margin-right: 40px">
                                <h3>{{ $portalName }}</h3>
                                <table border="2">
                                    @foreach ($portal as $citeNme => $status) {
                                        <tr>
                                            <td>{{ $citeNme }}</td>
                                            <td>{{ $status }}</td>
                                        </tr>
                                    @endforeach
                                </table>
                            </div>
                        @endforeach
                    </div>';
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
