function player_is_hammer_whirling(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Stop
            x_speed = 0;
            
            // Animate
            animation_play(AMY_ANIMATION.HAMMER_WHIRL);
            amy_create_attack_trail(HEART_PATTERN.C);
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