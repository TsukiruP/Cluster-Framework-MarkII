/// @description Hearts
event_inherited();
if (ctrlGame.game_paused) exit;

if (attack_trail.state == state)
{
    with (attack_trail)
    {
        for (var i = 0; i < HEART_COUNT; i++)
        {
            with (hearts[i])
            {
                if (visible and animation_is_finished)
                {
                    visible = false;
                    animation_set(undefined);
                }
            }
        }
        
        var duration = other.attack_trail_offsets[pattern][offset_index][0];
        if (duration != -1)
        {
            var old_time = time;
            time += other.animation_data.speed;
            
            if (old_time >= duration)
            {
                other.amy_refresh_attack_trail();
                offset_index = ++offset_index mod 8;
                if (offset_index == 0) time = 0;
            }
        }
    }
}