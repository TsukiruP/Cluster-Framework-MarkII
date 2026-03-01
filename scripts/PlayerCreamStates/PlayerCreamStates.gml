/// @function player_is_fan_flying(phase)
function player_is_fan_flying(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Fly
            flight_reset_time = 1;
            
            // Detach from ground
            player_ground(undefined);
            
            // Animate
            animation_play(CREAM_ANIMATION.FLIGHT);
            break;
        }
        case PHASE.STEP:
        {
            // Apply flight resistance
            /*var boost_mode_config = db_read(SAVE_DATABASE, "true", "boost_mode");
            if (boost_mode_config)
            {
                if (abs(x_speed) > flight_drag_thresholds[boost_index])
                {
                    x_speed += -air_acceleration * sign(x_speed);
                }
            }*/
            
            /* AUTHOR NOTE: The code above applies a strict cap, which is too drastic a change imo.
            I believe disabling it makes it behave closer to Advance 3. */
            
            // Accelerate
            if (input_axis_x != 0)
            {
                if (image_xscale != input_axis_x and flight_time < FAN_FLIGHT_DURATION) animation_play(animation_data.index, 1);
                
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
            
            // Cancel
            if (input_axis_y == 1 and input_button.jump.pressed)
            {
                animation_play(CREAM_ANIMATION.FLIGHT_CANCEL);
                return player_perform(player_is_falling, false);
            }
            
            // Ascend
            if (flight_reset_time != 1)
            {
                if (y_speed >= FAN_FLIGHT_THRESHOLD)
                {
                    y_speed -= flight_ascent_force;
                    if (++flight_reset_time == 32) flight_reset_time = 1;
                }
                else
                {
                    flight_reset_time = 1;
                }
            }
            else
            {
                if (input_button.jump.pressed and flight_time < FAN_FLIGHT_DURATION and y_speed >= FAN_FLIGHT_THRESHOLD)
                {
                    flight_reset_time = 2;
                }
                
                // Fall
                y_speed += flight_base_force;
            }
            
            // Apply air resistance
            if (y_speed < 0 and y_speed > -4)
            {
                x_speed -= x_speed / 32;
            }
            
            // Reset
            if (y < 0 and y_speed < 0)
            {
                y_speed = 0;
            }
            
            // Timer
            flight_time = min(++flight_time, FAN_FLIGHT_DURATION);
            
            // Animate
            if (flight_time < FAN_FLIGHT_DURATION)
            {
                animation_play(CREAM_ANIMATION.FLIGHT);
            }
            else
            {
                animation_play(CREAM_ANIMATION.FLIGHT_TIRED);
            }
            break;
        }
        case PHASE.EXIT:
        {
            break;
        }
    }
}