<?php

namespace App\Models;

class Battle extends Model
{
    protected $fillable = ['LevelID', 'BackgroundPic', 'BossDPS%', 'BossHP%', 'BossPosition', 'BOSSSIZE%', 'Chest1ID', 'Chest1Mult', 'Chest2ID', 'Chest2Mult', 'Chest3ID', 'Chest3Mult', 'Chest4ID', 'Chest4Mult', 'Chest5ID', 'Chest5Mult', 'FDBonus1', 'FDBonus2', 'FDBonus3', 'FDBonus4', 'FDBonus5', 'HFlip', 'Level1', 'Level2', 'Level3', 'Level4', 'Level5', 'MoneyReward1', 'MoneyReward2', 'MoneyReward3', 'MoneyReward4', 'MoneyReward5', 'Monster1ID', 'Monster2ID', 'Monster3ID', 'Monster4ID', 'Monster5ID', 'MonsterDPS%', 'MonsterHP%', 'MP1', 'MP2', 'MP3', 'MP4', 'MP5', 'RaidWaveWeight', 'StageDifficulty', 'StageID', 'StageName', 'Stars1', 'Stars2', 'Stars3', 'Stars4', 'Stars5', 'WaveID'];
}
