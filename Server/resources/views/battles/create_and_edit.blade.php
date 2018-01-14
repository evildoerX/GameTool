@extends('layouts.app')

@section('content')

<div class="container">
    <div class="col-md-10 col-md-offset-1">
        <div class="panel panel-default">
            
            <div class="panel-heading">
                <h1>
                    <i class="glyphicon glyphicon-edit"></i> Battle /
                    @if($battle->id)
                        Edit #{{$battle->id}}
                    @else
                        Create
                    @endif
                </h1>
            </div>

            @include('common.error')

            <div class="panel-body">
                @if($battle->id)
                    <form action="{{ route('battles.update', $battle->id) }}" method="POST" accept-charset="UTF-8">
                        <input type="hidden" name="_method" value="PUT">
                @else
                    <form action="{{ route('battles.store') }}" method="POST" accept-charset="UTF-8">
                @endif

                    <input type="hidden" name="_token" value="{{ csrf_token() }}">

                    
                <div class="form-group">
                	<label for="LevelID-field">LevelID</label>
                	<input class="form-control" type="text" name="LevelID" id="LevelID-field" value="{{ old('LevelID', $battle->LevelID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="BackgroundPic-field">BackgroundPic</label>
                	<input class="form-control" type="text" name="BackgroundPic" id="BackgroundPic-field" value="{{ old('BackgroundPic', $battle->BackgroundPic ) }}" />
                </div> 
                <div class="form-group">
                	<label for="BossDPS%-field">BossDPS%</label>
                	<input class="form-control" type="text" name="BossDPS%" id="BossDPS%-field" value="{{ old('BossDPS%', $battle->BossDPS% ) }}" />
                </div> 
                <div class="form-group">
                	<label for="BossHP%-field">BossHP%</label>
                	<input class="form-control" type="text" name="BossHP%" id="BossHP%-field" value="{{ old('BossHP%', $battle->BossHP% ) }}" />
                </div> 
                <div class="form-group">
                	<label for="BossPosition-field">BossPosition</label>
                	<input class="form-control" type="text" name="BossPosition" id="BossPosition-field" value="{{ old('BossPosition', $battle->BossPosition ) }}" />
                </div> 
                <div class="form-group">
                	<label for="BOSSSIZE%-field">BOSSSIZE%</label>
                	<input class="form-control" type="text" name="BOSSSIZE%" id="BOSSSIZE%-field" value="{{ old('BOSSSIZE%', $battle->BOSSSIZE% ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Chest1ID-field">Chest1ID</label>
                	<input class="form-control" type="text" name="Chest1ID" id="Chest1ID-field" value="{{ old('Chest1ID', $battle->Chest1ID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Chest1Mult-field">Chest1Mult</label>
                	<input class="form-control" type="text" name="Chest1Mult" id="Chest1Mult-field" value="{{ old('Chest1Mult', $battle->Chest1Mult ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Chest2ID-field">Chest2ID</label>
                	<input class="form-control" type="text" name="Chest2ID" id="Chest2ID-field" value="{{ old('Chest2ID', $battle->Chest2ID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Chest2Mult-field">Chest2Mult</label>
                	<input class="form-control" type="text" name="Chest2Mult" id="Chest2Mult-field" value="{{ old('Chest2Mult', $battle->Chest2Mult ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Chest3ID-field">Chest3ID</label>
                	<input class="form-control" type="text" name="Chest3ID" id="Chest3ID-field" value="{{ old('Chest3ID', $battle->Chest3ID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Chest3Mult-field">Chest3Mult</label>
                	<input class="form-control" type="text" name="Chest3Mult" id="Chest3Mult-field" value="{{ old('Chest3Mult', $battle->Chest3Mult ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Chest4ID-field">Chest4ID</label>
                	<input class="form-control" type="text" name="Chest4ID" id="Chest4ID-field" value="{{ old('Chest4ID', $battle->Chest4ID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Chest4Mult-field">Chest4Mult</label>
                	<input class="form-control" type="text" name="Chest4Mult" id="Chest4Mult-field" value="{{ old('Chest4Mult', $battle->Chest4Mult ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Chest5ID-field">Chest5ID</label>
                	<input class="form-control" type="text" name="Chest5ID" id="Chest5ID-field" value="{{ old('Chest5ID', $battle->Chest5ID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Chest5Mult-field">Chest5Mult</label>
                	<input class="form-control" type="text" name="Chest5Mult" id="Chest5Mult-field" value="{{ old('Chest5Mult', $battle->Chest5Mult ) }}" />
                </div> 
                <div class="form-group">
                	<label for="FDBonus1-field">FDBonus1</label>
                	<input class="form-control" type="text" name="FDBonus1" id="FDBonus1-field" value="{{ old('FDBonus1', $battle->FDBonus1 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="FDBonus2-field">FDBonus2</label>
                	<input class="form-control" type="text" name="FDBonus2" id="FDBonus2-field" value="{{ old('FDBonus2', $battle->FDBonus2 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="FDBonus3-field">FDBonus3</label>
                	<input class="form-control" type="text" name="FDBonus3" id="FDBonus3-field" value="{{ old('FDBonus3', $battle->FDBonus3 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="FDBonus4-field">FDBonus4</label>
                	<input class="form-control" type="text" name="FDBonus4" id="FDBonus4-field" value="{{ old('FDBonus4', $battle->FDBonus4 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="FDBonus5-field">FDBonus5</label>
                	<input class="form-control" type="text" name="FDBonus5" id="FDBonus5-field" value="{{ old('FDBonus5', $battle->FDBonus5 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="HFlip-field">HFlip</label>
                	<input class="form-control" type="text" name="HFlip" id="HFlip-field" value="{{ old('HFlip', $battle->HFlip ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Level1-field">Level1</label>
                	<input class="form-control" type="text" name="Level1" id="Level1-field" value="{{ old('Level1', $battle->Level1 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Level2-field">Level2</label>
                	<input class="form-control" type="text" name="Level2" id="Level2-field" value="{{ old('Level2', $battle->Level2 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Level3-field">Level3</label>
                	<input class="form-control" type="text" name="Level3" id="Level3-field" value="{{ old('Level3', $battle->Level3 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Level4-field">Level4</label>
                	<input class="form-control" type="text" name="Level4" id="Level4-field" value="{{ old('Level4', $battle->Level4 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Level5-field">Level5</label>
                	<input class="form-control" type="text" name="Level5" id="Level5-field" value="{{ old('Level5', $battle->Level5 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MoneyReward1-field">MoneyReward1</label>
                	<input class="form-control" type="text" name="MoneyReward1" id="MoneyReward1-field" value="{{ old('MoneyReward1', $battle->MoneyReward1 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MoneyReward2-field">MoneyReward2</label>
                	<input class="form-control" type="text" name="MoneyReward2" id="MoneyReward2-field" value="{{ old('MoneyReward2', $battle->MoneyReward2 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MoneyReward3-field">MoneyReward3</label>
                	<input class="form-control" type="text" name="MoneyReward3" id="MoneyReward3-field" value="{{ old('MoneyReward3', $battle->MoneyReward3 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MoneyReward4-field">MoneyReward4</label>
                	<input class="form-control" type="text" name="MoneyReward4" id="MoneyReward4-field" value="{{ old('MoneyReward4', $battle->MoneyReward4 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MoneyReward5-field">MoneyReward5</label>
                	<input class="form-control" type="text" name="MoneyReward5" id="MoneyReward5-field" value="{{ old('MoneyReward5', $battle->MoneyReward5 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Monster1ID-field">Monster1ID</label>
                	<input class="form-control" type="text" name="Monster1ID" id="Monster1ID-field" value="{{ old('Monster1ID', $battle->Monster1ID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Monster2ID-field">Monster2ID</label>
                	<input class="form-control" type="text" name="Monster2ID" id="Monster2ID-field" value="{{ old('Monster2ID', $battle->Monster2ID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Monster3ID-field">Monster3ID</label>
                	<input class="form-control" type="text" name="Monster3ID" id="Monster3ID-field" value="{{ old('Monster3ID', $battle->Monster3ID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Monster4ID-field">Monster4ID</label>
                	<input class="form-control" type="text" name="Monster4ID" id="Monster4ID-field" value="{{ old('Monster4ID', $battle->Monster4ID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Monster5ID-field">Monster5ID</label>
                	<input class="form-control" type="text" name="Monster5ID" id="Monster5ID-field" value="{{ old('Monster5ID', $battle->Monster5ID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MonsterDPS%-field">MonsterDPS%</label>
                	<input class="form-control" type="text" name="MonsterDPS%" id="MonsterDPS%-field" value="{{ old('MonsterDPS%', $battle->MonsterDPS% ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MonsterHP%-field">MonsterHP%</label>
                	<input class="form-control" type="text" name="MonsterHP%" id="MonsterHP%-field" value="{{ old('MonsterHP%', $battle->MonsterHP% ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MP1-field">MP1</label>
                	<input class="form-control" type="text" name="MP1" id="MP1-field" value="{{ old('MP1', $battle->MP1 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MP2-field">MP2</label>
                	<input class="form-control" type="text" name="MP2" id="MP2-field" value="{{ old('MP2', $battle->MP2 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MP3-field">MP3</label>
                	<input class="form-control" type="text" name="MP3" id="MP3-field" value="{{ old('MP3', $battle->MP3 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MP4-field">MP4</label>
                	<input class="form-control" type="text" name="MP4" id="MP4-field" value="{{ old('MP4', $battle->MP4 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="MP5-field">MP5</label>
                	<input class="form-control" type="text" name="MP5" id="MP5-field" value="{{ old('MP5', $battle->MP5 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="RaidWaveWeight-field">RaidWaveWeight</label>
                	<input class="form-control" type="text" name="RaidWaveWeight" id="RaidWaveWeight-field" value="{{ old('RaidWaveWeight', $battle->RaidWaveWeight ) }}" />
                </div> 
                <div class="form-group">
                	<label for="StageDifficulty-field">StageDifficulty</label>
                	<input class="form-control" type="text" name="StageDifficulty" id="StageDifficulty-field" value="{{ old('StageDifficulty', $battle->StageDifficulty ) }}" />
                </div> 
                <div class="form-group">
                	<label for="StageID-field">StageID</label>
                	<input class="form-control" type="text" name="StageID" id="StageID-field" value="{{ old('StageID', $battle->StageID ) }}" />
                </div> 
                <div class="form-group">
                	<label for="StageName-field">StageName</label>
                	<input class="form-control" type="text" name="StageName" id="StageName-field" value="{{ old('StageName', $battle->StageName ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Stars1-field">Stars1</label>
                	<input class="form-control" type="text" name="Stars1" id="Stars1-field" value="{{ old('Stars1', $battle->Stars1 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Stars2-field">Stars2</label>
                	<input class="form-control" type="text" name="Stars2" id="Stars2-field" value="{{ old('Stars2', $battle->Stars2 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Stars3-field">Stars3</label>
                	<input class="form-control" type="text" name="Stars3" id="Stars3-field" value="{{ old('Stars3', $battle->Stars3 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Stars4-field">Stars4</label>
                	<input class="form-control" type="text" name="Stars4" id="Stars4-field" value="{{ old('Stars4', $battle->Stars4 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="Stars5-field">Stars5</label>
                	<input class="form-control" type="text" name="Stars5" id="Stars5-field" value="{{ old('Stars5', $battle->Stars5 ) }}" />
                </div> 
                <div class="form-group">
                	<label for="WaveID-field">WaveID</label>
                	<input class="form-control" type="text" name="WaveID" id="WaveID-field" value="{{ old('WaveID', $battle->WaveID ) }}" />
                </div>

                    <div class="well well-sm">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <a class="btn btn-link pull-right" href="{{ route('battles.index') }}"><i class="glyphicon glyphicon-backward"></i>  Back</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

@endsection