function player_is_hammer_whirling(_phase)
{
    switch (_phase)
    {
        case PHASE.ENTER:
        {
            // Stop
            x_speed = 0;
            
            // Animate
            animation_play(AMY_ANIMATION.HAMMER_WHIRL);
            amy_create_hammer_trail(HEART_PATTERN.HAMMER_WHIRL);
            break;
        }
        case PHASE.STEP:
        {
            // Accelerate
            if (input_axis_x != 0)
            {
                image_xscale = input_axis_x;
                if (abs(x_speed) < speed_limit or sign(x_speed) != input_axis_x)
                {
                    x_speed += air_acceleration * input_axis_x;
                    if (abs(x_speed) > speed_limit and sign(x_speed) == input_axis_x)
                    {
                        x_speed = speed_limit * input_axis_x;
                    }
                }
            }
            
            // Apply speed cap
            if (abs(x_speed) > speed_cap) x_speed = speed_cap * sign(x_speed);
            
            // Move
            player_move_in_air();
            if (state_changed) exit;
            
            // Land
            if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
            
            // Apply air resistance
            if (y_speed < 0 and y_speed > -4)
            {
                x_speed -= x_speed / 32;
            }
            
            // Fall
            if (y_speed < gravity_cap)
            {
                y_speed = min(y_speed + gravity_force, gravity_cap);
            }
            break;
        }
        case PHASE.EXIT:
        {
            break;
        }
    }
}

function player_is_leaping(_phase)
{
    switch (_phase)
    {
        case PHASE.ENTER:
        {
            // Leap
            var sine = dsin(local_direction);
            var cosine = dcos(local_direction);
            y_speed = -sine * image_xscale * 4 - cosine * 1.25;
            x_speed = cosine * image_xscale * 4 - sine * 1.25;
            
            // Detach from ground
            player_ground(undefined);
            
            // Animate
            animation_play(AMY_ANIMATION.LEAP, 0);
            break;
        }
        case PHASE.STEP:
        {
            // Move
            player_move_in_air();
            if (state_changed) exit;
            
            // Land
            if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
            
            // Apply air resistance
            if (y_speed < 0 and y_speed > -4)
            {
                x_speed -= x_speed / 32;
            }
            
            // Fall
            if (y_speed < gravity_cap)
            {
                y_speed = min(y_speed + gravity_force, gravity_cap);
            }
            break;
        }
        case PHASE.EXIT:
        {
            break;
        }
    }
}