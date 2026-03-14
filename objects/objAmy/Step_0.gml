/// @description Hearts
event_inherited();
if (ctrlGame.game_paused) exit;

// Hammer trail
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

// Trick trail
with (trick_trail)
{
    if (visible)
    {
        if (destroy and active == 0)
        {
            visible = false;
            exit;
        }
        
        var j = 1;
        for (var i = 0; i < HEART_COUNT; i++)
        {
            if (active & j)
            {
                with (hearts[i])
                {
                    if (animation_is_finished())
                    {
                        animation_set(undefined);
                        other.active &= ~(1  << i);
                    }
                }
            }
            
            j = j << 1;
        }
        
        if (not destroy)
        {
            if (time == 0)
            {
                other.amy_offset_trick_trail(0);
            }
            else if (time == 3)
            {
                other.amy_offset_trick_trail(1);
            }
            else if (time == 7)
            {
                other.amy_offset_trick_trail(2);
            }
            else if (time == 11)
            {
                other.amy_offset_trick_trail(3);
            }
        }
        
        time = ++time mod 15;
        if (other.animation_data.index != PLAYER_ANIMATION.TRICK_FRONT) destroy = true;
    }
}