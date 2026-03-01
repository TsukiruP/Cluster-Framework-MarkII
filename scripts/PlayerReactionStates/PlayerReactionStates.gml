/// @function player_is_sprung(phase)
function player_is_sprung(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Detach from ground
            player_ground(undefined);
            
            // Animate
            var ani_spring = (abs(x_speed) > 2.5 ? PLAYER_ANIMATION.SPRING_TWIRL : PLAYER_ANIMATION.SPRING);
            animation_play(ani_spring, 0);
            break;
        }
        case PHASE.STEP:
        {
            // Trick
            if (state_time > 0) state_time--;
            if (player_try_trick(state_time)) exit;
            
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
            
            // Skill
            if (player_try_skill()) exit;
            
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