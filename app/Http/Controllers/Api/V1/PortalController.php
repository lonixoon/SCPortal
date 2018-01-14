<?php

namespace App\Http\Controllers\Api\V1;

use App\DailyStatusPortal;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class PortalController extends Controller
{
    public function index()
    {
        return DailyStatusPortal::all();
    }

    public function show($id)
    {
        return DailyStatusPortal::findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $Portal = DailyStatusPortal::findOrFail($id);
        $Portal->update($request->all());

        return $Portal;
    }

    public function store(Request $request)
    {
        $Portal = DailyStatusPortal::create($request->all());
        return $Portal;
    }

    public function destroy($id)
    {
        $Portal = DailyStatusPortal::findOrFail($id);
        $Portal->delete();
        return '';
    }
}
