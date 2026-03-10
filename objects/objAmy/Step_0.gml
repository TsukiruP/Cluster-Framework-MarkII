/// @description Hearts
event_inherited();
if (ctrlGame.game_paused) exit;

if (attack_trail.state != state)
{
    with (attack_trail)
    {
        if (pattern != -1)
        {
            for (var i = 0; i < HEART_COUNT; i++)
            {
                with (hearts[i])
                {
                    visible = false;
                    animation_set(undefined);
                }
            }
            
            pattern = -1;
        }
    }
}
else if (attack_trail.pattern != -1)
{
    with (attack_trail)
    {
        for (var i = 0; i < HEART_COUNT; i++)
        {
            with (hearts[i])
            {
                if (visible and animation_is_finished())
                {
                    visible = false;
                    animation_set(undefined);
                }
            }
        }
        
        var duration = offsets[pattern][offset_index][0];
        if (duration != -1)
        {
            var old_time = time++;
            if (old_time > duration)
            {
                other.amy_refresh_attack_trail();
                offset_index = ++offset_index mod 8;
                if (offset_index == 0) time = 0;
            }
        }
    }
}