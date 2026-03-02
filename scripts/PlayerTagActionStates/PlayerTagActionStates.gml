/// @function player_is_flight_riding(phase)
function player_is_flight_riding(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Stop
            x_speed = 0;
            y_speed = 0;
            
            // Detach from ground
            player_ground(undefined);
            
            // Animate
            animation_play(PLAYER_ANIMATION.FLIGHT_RIDE);
            break;
        }
        case PHASE.STEP:
        {
            // Jump
            if ((player_index == 0 or cpu_gamepad_time > 0) and input_axis_y = 1)
            {
                if (player_try_jump()) exit;
            }
            
            // Move
            player_move_in_air();
            if (state_changed) exit;
            
            // Land
            if (on_ground)
            {
                x_speed = flight_ride.x_speed;
                return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
            }
            
            // Disconnect
            if ((dsin(gravity_direction) == 0 and x div 1 != flight_ride.x div 1) or (dsin(gravity_direction) != 0 and y div 1 != flight_ride.y div 1)
                or flight_ride.state != player_is_propeller_flying)
            {
                return player_perform(player_is_falling, false);
            }
            break;
        }
        case PHASE.EXIT:
        {
            with (flight_ride) flight_carry_time = 30;
            flight_ride = noone;
            break;
        }
    }
}