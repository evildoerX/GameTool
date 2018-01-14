<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Battle;

class BattlePolicy extends Policy
{
    public function update(User $user, Battle $battle)
    {
        // return $battle->user_id == $user->id;
        return true;
    }

    public function destroy(User $user, Battle $battle)
    {
        return true;
    }
}
