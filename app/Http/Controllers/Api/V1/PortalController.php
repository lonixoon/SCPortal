<?php

namespace App\Http\Controllers\Api\V1;

use App\Portal;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class PortalController extends Controller
{
    public function index()
    {
        return Portal::all();
    }

    public function show($id)
    {
        return Portal::findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $Portal = Portal::findOrFail($id);
        $Portal->update($request->all());

        return $Portal;
    }

    public function store(Request $request)
    {
        $Portal = Portal::create($request->all());
        return $Portal;
    }

    public function destroy($id)
    {
        $Portal = Portal::findOrFail($id);
        $Portal->delete();
        return '';
    }
}
