<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBattlesTable extends Migration 
{
	public function up()
	{
		Schema::create('battles', function(Blueprint $table) {
            $table->increments('id');
            $table->string('LevelID')->nullable();
            $table->string('BackgroundPic')->nullable();
            $table->string('BossDPS%')->nullable();
            $table->string('BossHP%')->nullable();
            $table->string('BossPosition')->nullable();
            $table->string('BOSSSIZE%')->nullable();
            $table->string('Chest1ID')->nullable();
            $table->string('Chest1Mult')->nullable();
            $table->string('Chest2ID')->nullable();
            $table->string('Chest2Mult')->nullable();
            $table->string('Chest3ID')->nullable();
            $table->string('Chest3Mult')->nullable();
            $table->string('Chest4ID')->nullable();
            $table->string('Chest4Mult')->nullable();
            $table->string('Chest5ID')->nullable();
            $table->string('Chest5Mult')->nullable();
            $table->string('FDBonus1')->nullable();
            $table->string('FDBonus2')->nullable();
            $table->string('FDBonus3')->nullable();
            $table->string('FDBonus4')->nullable();
            $table->string('FDBonus5')->nullable();
            $table->string('HFlip')->nullable();
            $table->string('Level1')->nullable();
            $table->string('Level2')->nullable();
            $table->string('Level3')->nullable();
            $table->string('Level4')->nullable();
            $table->string('Level5')->nullable();
            $table->string('MoneyReward1')->nullable();
            $table->string('MoneyReward2')->nullable();
            $table->string('MoneyReward3')->nullable();
            $table->string('MoneyReward4')->nullable();
            $table->string('MoneyReward5')->nullable();
            $table->string('Monster1ID')->nullable();
            $table->string('Monster2ID')->nullable();
            $table->string('Monster3ID')->nullable();
            $table->string('Monster4ID')->nullable();
            $table->string('Monster5ID')->nullable();
            $table->string('MonsterDPS%')->nullable();
            $table->string('MonsterHP%')->nullable();
            $table->string('MP1')->nullable();
            $table->string('MP2')->nullable();
            $table->string('MP3')->nullable();
            $table->string('MP4')->nullable();
            $table->string('MP5')->nullable();
            $table->string('RaidWaveWeight')->nullable();
            $table->string('StageDifficulty')->nullable();
            $table->string('StageID')->nullable();
            $table->string('StageName')->nullable();
            $table->string('Stars1')->nullable();
            $table->string('Stars2')->nullable();
            $table->string('Stars3')->nullable();
            $table->string('Stars4')->nullable();
            $table->string('Stars5')->nullable();
            $table->string('WaveID')->nullable();
            $table->timestamps();
        });
	}

	public function down()
	{
		Schema::drop('battles');
	}
}
