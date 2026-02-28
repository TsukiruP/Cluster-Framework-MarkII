/// @function player_is_propeller_flying(phase)
function player_is_propeller_flying(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Fly
            flight_reset_time = 0;
            flight_force = flight_base_force;
            
            // Detach from ground
            player_ground(undefined);
            
            // Animate
            animation_play(MILES_ANIMATION.FLIGHT);
            break;
        }
        case PHASE.STEP:
        {
            // Accelerate
            if (input_axis_x != 0)
            {
                if (image_xscale != input_axis_x and flight_time < PROPELLER_FLIGHT_DURATION) animation_play(animation_data.index, 1);
                
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
                animation_play(MILES_ANIMATION.FLIGHT_CANCEL);
                return player_perform(player_is_falling, false);
            }
            
            // Ascend
            if (input_button.jump.pressed and flight_time < PROPELLER_FLIGHT_DURATION and y_speed >= PROPELLER_FLIGHT_THRESHOLD)
            {
                flight_reset_time = 60;
                flight_force = -flight_ascent_force;
            }
            
            // Apply air resistance
            if (y_speed < 0 and y_speed > -4 and abs(x_speed) > AIR_DRAG_THRESHOLD)
            {
                x_speed *= AIR_DRAG;
            }
            
            // Fall
            y_speed += flight_force;
            
            // Reset
            if (y_speed < PROPELLER_FLIGHT_THRESHOLD or flight_reset_time == 0)
            {
                flight_force = flight_base_force;
            }
            
            if (y < 0 and y_speed < 0)
            {
                y_speed = 0;
            }
            
            // Timers
            flight_time = min(++flight_time, PROPELLER_FLIGHT_DURATION);
            flight_reset_time = max(--flight_reset_time, 0);
            
            // Animate
            if (flight_time < PROPELLER_FLIGHT_DURATION)
            {
                animation_play(MILES_ANIMATION.FLIGHT);
                if (not audio_is_playing(sfxPropellerFlight))
                {
                    audio_stop_sound(flight_soundid);
                    flight_soundid = audio_play_single(sfxPropellerFlight, true);
                }
            }
            else
            {
                animation_play(MILES_ANIMATION.FLIGHT_TIRED);
                if (not audio_is_playing(sfxPropellerFlightTired))
                {
                    audio_stop_sound(flight_soundid);
                    flight_soundid = audio_play_single(sfxPropellerFlightTired, true);
                }
            }
            break;
        }
        case PHASE.EXIT:
        {
            audio_stop_sound(flight_soundid);
            break;
        }
    }
}