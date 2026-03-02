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
            animation_play(flight_hammer ? MILES_ANIMATION.HAMMER_FLIGHT : MILES_ANIMATION.FLIGHT);
            break;
        }
        case PHASE.STEP:
        {
            // Accelerate
            if (input_axis_x != 0)
            {
                // Turn
                if (image_xscale != input_axis_x and flight_time < PROPELLER_FLIGHT_DURATION and not flight_hammer)
                {
                    animation_play(animation_data.index, 1);
                }
                
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
            
            // Ignore inputs when hammer attacking
            if (animation_data.index != MILES_ANIMATION.HAMMER_FLIGHT or animation_data.variant == 0)
            {
                // Cancel
                if ((player_index == 0 or cpu_gamepad_time > 0) and input_axis_y == 1 and input_button.jump.pressed)
                {
                    animation_play(MILES_ANIMATION.FLIGHT_CANCEL);
                    return player_perform(player_is_falling, false);
                }
                
                // Ascend
                var flight_config = db_read(SAVE_DATABASE, MILES_FLIGHT_STYLE.CLASSIC, "miles", "flight_style");
                var input_flight = input_button.jump.pressed or (flight_config and input_button.jump.check);
                if (input_flight and flight_time < PROPELLER_FLIGHT_DURATION and y_speed >= PROPELLER_FLIGHT_THRESHOLD)
                {
                    flight_reset_time = 60;
                    flight_force = -flight_ascent_force;
                }
            }
            
            // Apply air resistance
            if (y_speed < 0 and y_speed > -4)
            {
                x_speed -= x_speed / 32;
            }
            
            // Fall
            y_speed += flight_force;
            
            // Reset
            if (y_speed < PROPELLER_FLIGHT_THRESHOLD or flight_reset_time == 0)
            {
                flight_force = flight_base_force;
            }
            
            // Ceiling cap
            if (y < 0 and y_speed < 0)
            {
                y_speed = 0;
            }
            
            // Timers
            if (flight_time < PROPELLER_FLIGHT_DURATION) flight_time++;
            if (flight_reset_time > 0) flight_reset_time--;
            if (flight_carry_time > 0) flight_carry_time--;
            
            // Animate
            if (flight_time < PROPELLER_FLIGHT_DURATION)
            {
                animation_play(flight_hammer ? MILES_ANIMATION.HAMMER_FLIGHT : MILES_ANIMATION.FLIGHT);
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
            
            // Buddy Flight
            if (not flight_hammer)
            {
                if (flight_carry == false)
                {
                    if (flight_carry_time == 0)
                    {
                        with (objPlayer)
                        {
                            // Abort if...
                            if (object_index == objMiles or input_axis_y == 1 or on_ground) continue; // "Other" player is Miles, holding down, or grounded
                            if (state != player_is_falling and state != player_is_jumping) continue; // Not in an appropriate state
                            
                            var dx = (other.x - x) div 1;
                            var dy = (other.y - y) div 1;
                            
                            var sine = dsin(gravity_direction);
                            var cosine = dcos(gravity_direction);
                            
                            var x_dist = (sine == 0 ? cosine * dx : -sine * dy) + 16;
                            var y_dist = (sine == 0 ? cosine * dy : sine * dx) + 32;
                            
                            if (abs(x_dist) < 32 and abs(y_dist) < 16)
                            {
                                flight_ride = other.id;
                                other.flight_carry = true;
                                other.flight_buddy = id;
                                audio_play_single(sfxGrab);
                                player_perform(player_is_flight_riding);
                                break;
                            }
                        }
                    }
                }
                
                if (flight_carry)
                {
                    var sine = dsin(gravity_direction);
                    var cosine = dcos(gravity_direction);
                    
                    with (flight_buddy)
                    {
                        if (state == player_is_flight_riding)
                        {
                            x = other.x + sine * 32;
                            y = other.y + cosine * 32;
                            image_xscale = other.image_xscale;
                            
                            if (collision_layer != other.collision_layer)
                            {
                                collision_layer = other.collision_layer;
                                tilemaps[1] = ctrlStage.tilemaps[collision_layer + 1];
                            }
                        }
                        else
                        {
                            other.flight_carry = false;
                            other.flight_buddy = noone;
                        }
                    }
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