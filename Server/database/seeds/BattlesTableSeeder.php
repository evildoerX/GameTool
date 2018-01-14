<?php

use Illuminate\Database\Seeder;
use App\Models\Battle;

class BattlesTableSeeder extends Seeder
{
    public function run()
    {
        $battles = factory(Battle::class)->times(50)->make()->each(function ($battle, $index) {
            if ($index == 0) {
                // $battle->field = 'value';
            }
        });

        Battle::insert($battles->toArray());
    }

}

