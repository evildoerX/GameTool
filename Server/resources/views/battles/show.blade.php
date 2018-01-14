@extends('layouts.app')

@section('content')

<div class="container">
    <div class="col-md-10 col-md-offset-1">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h1>Battle / Show #{{ $battle->id }}</h1>
            </div>

            <div class="panel-body">
                <div class="well well-sm">
                    <div class="row">
                        <div class="col-md-6">
                            <a class="btn btn-link" href="{{ route('battles.index') }}"><i class="glyphicon glyphicon-backward"></i> Back</a>
                        </div>
                        <div class="col-md-6">
                             <a class="btn btn-sm btn-warning pull-right" href="{{ route('battles.edit', $battle->id) }}">
                                <i class="glyphicon glyphicon-edit"></i> Edit
                            </a>
                        </div>
                    </div>
                </div>

                <label>LevelID</label>
<p>
	{{ $battle->LevelID }}
</p> <label>BackgroundPic</label>
<p>
	{{ $battle->BackgroundPic }}
</p> <label>BossDPS%</label>
<p>
	{{ $battle->BossDPS% }}
</p> <label>BossHP%</label>
<p>
	{{ $battle->BossHP% }}
</p> <label>BossPosition</label>
<p>
	{{ $battle->BossPosition }}
</p> <label>BOSSSIZE%</label>
<p>
	{{ $battle->BOSSSIZE% }}
</p> <label>Chest1ID</label>
<p>
	{{ $battle->Chest1ID }}
</p> <label>Chest1Mult</label>
<p>
	{{ $battle->Chest1Mult }}
</p> <label>Chest2ID</label>
<p>
	{{ $battle->Chest2ID }}
</p> <label>Chest2Mult</label>
<p>
	{{ $battle->Chest2Mult }}
</p> <label>Chest3ID</label>
<p>
	{{ $battle->Chest3ID }}
</p> <label>Chest3Mult</label>
<p>
	{{ $battle->Chest3Mult }}
</p> <label>Chest4ID</label>
<p>
	{{ $battle->Chest4ID }}
</p> <label>Chest4Mult</label>
<p>
	{{ $battle->Chest4Mult }}
</p> <label>Chest5ID</label>
<p>
	{{ $battle->Chest5ID }}
</p> <label>Chest5Mult</label>
<p>
	{{ $battle->Chest5Mult }}
</p> <label>FDBonus1</label>
<p>
	{{ $battle->FDBonus1 }}
</p> <label>FDBonus2</label>
<p>
	{{ $battle->FDBonus2 }}
</p> <label>FDBonus3</label>
<p>
	{{ $battle->FDBonus3 }}
</p> <label>FDBonus4</label>
<p>
	{{ $battle->FDBonus4 }}
</p> <label>FDBonus5</label>
<p>
	{{ $battle->FDBonus5 }}
</p> <label>HFlip</label>
<p>
	{{ $battle->HFlip }}
</p> <label>Level1</label>
<p>
	{{ $battle->Level1 }}
</p> <label>Level2</label>
<p>
	{{ $battle->Level2 }}
</p> <label>Level3</label>
<p>
	{{ $battle->Level3 }}
</p> <label>Level4</label>
<p>
	{{ $battle->Level4 }}
</p> <label>Level5</label>
<p>
	{{ $battle->Level5 }}
</p> <label>MoneyReward1</label>
<p>
	{{ $battle->MoneyReward1 }}
</p> <label>MoneyReward2</label>
<p>
	{{ $battle->MoneyReward2 }}
</p> <label>MoneyReward3</label>
<p>
	{{ $battle->MoneyReward3 }}
</p> <label>MoneyReward4</label>
<p>
	{{ $battle->MoneyReward4 }}
</p> <label>MoneyReward5</label>
<p>
	{{ $battle->MoneyReward5 }}
</p> <label>Monster1ID</label>
<p>
	{{ $battle->Monster1ID }}
</p> <label>Monster2ID</label>
<p>
	{{ $battle->Monster2ID }}
</p> <label>Monster3ID</label>
<p>
	{{ $battle->Monster3ID }}
</p> <label>Monster4ID</label>
<p>
	{{ $battle->Monster4ID }}
</p> <label>Monster5ID</label>
<p>
	{{ $battle->Monster5ID }}
</p> <label>MonsterDPS%</label>
<p>
	{{ $battle->MonsterDPS% }}
</p> <label>MonsterHP%</label>
<p>
	{{ $battle->MonsterHP% }}
</p> <label>MP1</label>
<p>
	{{ $battle->MP1 }}
</p> <label>MP2</label>
<p>
	{{ $battle->MP2 }}
</p> <label>MP3</label>
<p>
	{{ $battle->MP3 }}
</p> <label>MP4</label>
<p>
	{{ $battle->MP4 }}
</p> <label>MP5</label>
<p>
	{{ $battle->MP5 }}
</p> <label>RaidWaveWeight</label>
<p>
	{{ $battle->RaidWaveWeight }}
</p> <label>StageDifficulty</label>
<p>
	{{ $battle->StageDifficulty }}
</p> <label>StageID</label>
<p>
	{{ $battle->StageID }}
</p> <label>StageName</label>
<p>
	{{ $battle->StageName }}
</p> <label>Stars1</label>
<p>
	{{ $battle->Stars1 }}
</p> <label>Stars2</label>
<p>
	{{ $battle->Stars2 }}
</p> <label>Stars3</label>
<p>
	{{ $battle->Stars3 }}
</p> <label>Stars4</label>
<p>
	{{ $battle->Stars4 }}
</p> <label>Stars5</label>
<p>
	{{ $battle->Stars5 }}
</p> <label>WaveID</label>
<p>
	{{ $battle->WaveID }}
</p>
            </div>
        </div>
    </div>
</div>

@endsection
