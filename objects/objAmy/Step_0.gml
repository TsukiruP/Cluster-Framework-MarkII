/// @description Hearts
event_inherited();
if (ctrlGame.game_paused) exit;

with (hammer_trail)
{
    if (state != other.state)
    {
        if (visible)
        {
            for (var i = 0; i < HEART_COUNT; i++)
            {
                with (hearts[i])
                {
                    visible = false;
                    animation_set(undefined);
                }
            }
            
            visible = false;
        }
    }
    else if (visible)
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
                gravity_direction = other.gravity_direction;
                other.amy_refresh_hammer_trail();
                offset_index = ++offset_index mod 8;
                if (offset_index == 0) time = 0;
            }
        }
    }
}