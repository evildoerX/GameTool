<?php

namespace App\Http\Controllers;

use App\Models\Battle;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\BattleRequest;

class BattlesController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth', ['except' => ['index', 'show']]);
    }

	public function index()
	{
		$battles = Battle::paginate();
		return $battles;
	}

    public function show(Battle $battle)
    {
        return view('battles.show', compact('battle'));
    }

	public function create(Battle $battle)
	{
		return view('battles.create_and_edit', compact('battle'));
	}

	public function store(BattleRequest $request)
	{
		$battle = Battle::create($request->all());
		return redirect()->route('battles.show', $battle->id)->with('message', 'Created successfully.');
	}

	public function edit(Battle $battle)
	{
        $this->authorize('update', $battle);
		return view('battles.create_and_edit', compact('battle'));
	}

	public function update(BattleRequest $request, Battle $battle)
	{
		$this->authorize('update', $battle);
		$battle->update($request->all());

		return redirect()->route('battles.show', $battle->id)->with('message', 'Updated successfully.');
	}

	public function destroy(Battle $battle)
	{
		$this->authorize('destroy', $battle);
		$battle->delete();

		return redirect()->route('battles.index')->with('message', 'Deleted successfully.');
	}
}