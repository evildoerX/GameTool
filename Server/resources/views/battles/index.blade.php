@extends('layouts.app')

@section('content')
<div class="container">
    <div class="col-md-10 col-md-offset-1">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h1>
                    <i class="glyphicon glyphicon-align-justify"></i> Battle
                    <a class="btn btn-success pull-right" href="{{ route('battles.create') }}"><i class="glyphicon glyphicon-plus"></i> Create</a>
                </h1>
            </div>

            <div class="panel-body">
                @if($battles->count())
                    <table class="table table-condensed table-striped">
                        <thead>
                            <tr>
                                <th class="text-center">#</th>
                                <th>LevelID</th> <th>BackgroundPic</th> <th>BossDPS%</th> <th>BossHP%</th> <th>BossPosition</th> <th>BOSSSIZE%</th> <th>Chest1ID</th> <th>Chest1Mult</th> <th>Chest2ID</th> <th>Chest2Mult</th> <th>Chest3ID</th> <th>Chest3Mult</th> <th>Chest4ID</th> <th>Chest4Mult</th> <th>Chest5ID</th> <th>Chest5Mult</th> <th>FDBonus1</th> <th>FDBonus2</th> <th>FDBonus3</th> <th>FDBonus4</th> <th>FDBonus5</th> <th>HFlip</th> <th>Level1</th> <th>Level2</th> <th>Level3</th> <th>Level4</th> <th>Level5</th> <th>MoneyReward1</th> <th>MoneyReward2</th> <th>MoneyReward3</th> <th>MoneyReward4</th> <th>MoneyReward5</th> <th>Monster1ID</th> <th>Monster2ID</th> <th>Monster3ID</th> <th>Monster4ID</th> <th>Monster5ID</th> <th>MonsterDPS%</th> <th>MonsterHP%</th> <th>MP1</th> <th>MP2</th> <th>MP3</th> <th>MP4</th> <th>MP5</th> <th>RaidWaveWeight</th> <th>StageDifficulty</th> <th>StageID</th> <th>StageName</th> <th>Stars1</th> <th>Stars2</th> <th>Stars3</th> <th>Stars4</th> <th>Stars5</th> <th>WaveID</th>
                                <th class="text-right">OPTIONS</th>
                            </tr>
                        </thead>

                        <tbody>
                            @foreach($battles as $battle)
                                <tr>
                                    <td class="text-center"><strong>{{$battle->id}}</strong></td>

                                    <td>{{$battle->LevelID}}</td> <td>{{$battle->BackgroundPic}}</td> <td>{{$battle->BossDPS%}}</td> <td>{{$battle->BossHP%}}</td> <td>{{$battle->BossPosition}}</td> <td>{{$battle->BOSSSIZE%}}</td> <td>{{$battle->Chest1ID}}</td> <td>{{$battle->Chest1Mult}}</td> <td>{{$battle->Chest2ID}}</td> <td>{{$battle->Chest2Mult}}</td> <td>{{$battle->Chest3ID}}</td> <td>{{$battle->Chest3Mult}}</td> <td>{{$battle->Chest4ID}}</td> <td>{{$battle->Chest4Mult}}</td> <td>{{$battle->Chest5ID}}</td> <td>{{$battle->Chest5Mult}}</td> <td>{{$battle->FDBonus1}}</td> <td>{{$battle->FDBonus2}}</td> <td>{{$battle->FDBonus3}}</td> <td>{{$battle->FDBonus4}}</td> <td>{{$battle->FDBonus5}}</td> <td>{{$battle->HFlip}}</td> <td>{{$battle->Level1}}</td> <td>{{$battle->Level2}}</td> <td>{{$battle->Level3}}</td> <td>{{$battle->Level4}}</td> <td>{{$battle->Level5}}</td> <td>{{$battle->MoneyReward1}}</td> <td>{{$battle->MoneyReward2}}</td> <td>{{$battle->MoneyReward3}}</td> <td>{{$battle->MoneyReward4}}</td> <td>{{$battle->MoneyReward5}}</td> <td>{{$battle->Monster1ID}}</td> <td>{{$battle->Monster2ID}}</td> <td>{{$battle->Monster3ID}}</td> <td>{{$battle->Monster4ID}}</td> <td>{{$battle->Monster5ID}}</td> <td>{{$battle->MonsterDPS%}}</td> <td>{{$battle->MonsterHP%}}</td> <td>{{$battle->MP1}}</td> <td>{{$battle->MP2}}</td> <td>{{$battle->MP3}}</td> <td>{{$battle->MP4}}</td> <td>{{$battle->MP5}}</td> <td>{{$battle->RaidWaveWeight}}</td> <td>{{$battle->StageDifficulty}}</td> <td>{{$battle->StageID}}</td> <td>{{$battle->StageName}}</td> <td>{{$battle->Stars1}}</td> <td>{{$battle->Stars2}}</td> <td>{{$battle->Stars3}}</td> <td>{{$battle->Stars4}}</td> <td>{{$battle->Stars5}}</td> <td>{{$battle->WaveID}}</td>
                                    
                                    <td class="text-right">
                                        <a class="btn btn-xs btn-primary" href="{{ route('battles.show', $battle->id) }}">
                                            <i class="glyphicon glyphicon-eye-open"></i> 
                                        </a>
                                        
                                        <a class="btn btn-xs btn-warning" href="{{ route('battles.edit', $battle->id) }}">
                                            <i class="glyphicon glyphicon-edit"></i> 
                                        </a>

                                        <form action="{{ route('battles.destroy', $battle->id) }}" method="POST" style="display: inline;" onsubmit="return confirm('Delete? Are you sure?');">
                                            {{csrf_field()}}
                                            <input type="hidden" name="_method" value="DELETE">

                                            <button type="submit" class="btn btn-xs btn-danger"><i class="glyphicon glyphicon-trash"></i> </button>
                                        </form>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                    {!! $battles->render() !!}
                @else
                    <h3 class="text-center alert alert-info">Empty!</h3>
                @endif
            </div>
        </div>
    </div>
</div>

@endsection