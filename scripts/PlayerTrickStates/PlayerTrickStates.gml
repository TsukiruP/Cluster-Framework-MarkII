/// @function player_is_trick_preparing(phase)
function player_is_trick_preparing(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Stop
            x_speed = 0;
            y_speed = 0;
            
            // Animate
            animation_play(PLAYER_ANIMATION.TRICK_UP + trick_index);
            break;
        }
        case PHASE.STEP:
        {
            // Trick
            if (animation_is_finished())
            {
                if ((object_index == objSonic or object_index == objKnuckles or object_index == objAmy) and trick_index == TRICK.DOWN)
                {
                    switch (object_index)
                    {
                        case objSonic:
                        case objAmy:
                        {
                            y_speed = 2;
                            return player_perform(player_is_trick_bounding);
                        }
                        
                        case objKnuckles:
                        {
                            y_speed = 1;
                            return player_perform(player_is_trick_drill_clawing);
                        }
                    }
                }
                else
                {
                    x_speed = image_xscale * trick_speed[trick_index][0];
                    y_speed = trick_speed[trick_index][1];
                    return player_perform(player_is_tricking);
                }
            }
            
            // Move
            player_move_in_air();
            if (state_changed) exit;
            
            // Land
            if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
            break;
        }
        case PHASE.EXIT:
        {
            break;
        }
    }
}

/// @function player_is_tricking(phase)
function player_is_tricking(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Set time
            if ((object_index == objSonic or object_index == objAmy) and trick_index == TRICK.FRONT) state_time = 45;
            else if (object_index == objKnuckles and (trick_index == TRICK.FRONT or trick_index == TRICK.BACK)) state_time = 10;
            else state_time = 0;
            
            // Animate
            animation_data.variant++;
            break;
        }
        case PHASE.STEP:
        {
            if (state_time > 0) state_time--;
            if ((object_index == objSonic or object_index == objAmy) and trick_index == TRICK.FRONT and state_time == 0) animation_play(PLAYER_ANIMATION.FALL);
            
            var trick_spiral = (object_index == objKnuckles and trick_index == TRICK.UP);
            var trick_glide = (object_index == objKnuckles and (trick_index == TRICK.FRONT or trick_index == TRICK.BACK) and state_time > 0);
            
            // Accelerate
            if (not trick_spiral or y_speed > 0)
            {
                if (input_axis_x != 0)
                {
                    if (abs(x_speed) < speed_limit or sign(x_speed) != input_axis_x)
                    {
                        x_speed += air_acceleration * input_axis_x;
                        if (abs(x_speed) > speed_limit and sign(x_speed) == input_axis_x)
                        {
                            x_speed = speed_limit * input_axis_x;
                        }
                    }
                }
            }
            
            // Move
            player_move_in_air();
            if (state_changed) exit;
            
            // Land
            if (on_ground)
            {
                if (object_index == objKnuckles and trick_index == TRICK.FRONT) return player_perform(player_is_trick_somersaulting);
                return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
            }
            
            // Skill
            if (player_try_skill()) exit;
            
            if (not trick_glide)
            {
                // Apply air resistance
                if (y_speed < 0 and y_speed > -4)
                {
                    x_speed -= x_speed / 32;
                }
                
                // Fall
                if (y_speed < gravity_cap)
                {
                    var trick_force = gravity_force;
                    var trick_float = ((object_index == objMiles or object_index == objCream) and (trick_index == TRICK.FRONT or trick_index == TRICK.BACK) and y_speed < 0);
                    if (trick_float) trick_force /= 2;
                    y_speed = min(y_speed + trick_force, gravity_cap);
                }
            }
            break;
        }
        case PHASE.EXIT:
        {
            break;
        }
    }
}

#region Sonic/Amy

/// @function player_is_trick_bounding(phase)
function player_is_trick_bounding(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Animate
            animation_data.variant++;
            break;
        }
        case PHASE.STEP:
        {
            // Move
            player_move_in_air();
            if (state_changed) exit;
            
            // Rebound
            if (on_ground) return player_perform(player_is_trick_rebounding);
            
            // Apply air resistance
            if (y_speed < 0 and y_speed > -4)
            {
                x_speed -= x_speed / 32;
            }
            
            // Fall
            if (y_speed < gravity_cap)
            {
                y_speed = min(y_speed + trick_bound_force, gravity_cap);
            }
            break;
        }
        case PHASE.EXIT:
        {
            break;
        }
    }
}

/// @function player_is_trick_rebounding(phase)
function player_is_trick_rebounding(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Rebound
            var sine = dsin(local_direction);
            var cosine = dcos(local_direction);
            y_speed = -cosine * trick_bound_height;
            x_speed = -sine * trick_bound_height / 2;
            
            // Detach from ground
            player_ground(undefined);
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
                y_speed = min(y_speed + trick_bound_force, gravity_cap);
            }
            
            if (y_speed > 0)
            {
                animation_data.variant++;
                return player_perform(player_is_falling, false);
            }
            break;
        }
        case PHASE.EXIT:
        {
            break;
        }
    }
}

#endregion

#region Knuckles

/// @function player_is_trick_drill_clawing(phase)
function player_is_trick_drill_clawing(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Animate
            animation_data.variant++;
            break;
        }
        case PHASE.STEP:
        {
            if (animation_data.variant == 2)
            {
                // Move
                player_move_on_ground();
                if (state_changed) exit;
                
                // Fall
                if (not on_ground) return player_perform(player_is_falling);
                
                // Stand
                if (animation_is_finished()) return player_perform(player_is_standing);
            }
            else
            {
                // Move
                player_move_in_air();
                if (state_changed) exit;
                
                // Land
                if (on_ground) return player_perform(player_is_trick_drill_clawing);
                
                // Apply air resistance
                if (y_speed < 0 and y_speed > -4)
                {
                    x_speed -= x_speed / 32;
                }
                
                // Fall
                if (y_speed < gravity_cap)
                {
                    y_speed = min(y_speed + (42 / 256), gravity_cap);
                }
            }
            break;
        }
        case PHASE.EXIT:
        {
            break;
        }
    }
}

/// @function player_is_trick_somersaulting(phase)
function player_is_trick_somersaulting(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Animate
            animation_data.variant++;
            break;
        }
        case PHASE.STEP:
        {
            if (on_ground)
            {
                // Move
                player_move_on_ground();
                if (state_changed) exit;
            }
            else
            {
                // Move
                player_move_in_air();
                if (state_changed) exit;
                
                // Fall
                if (not on_ground)
                {
                    if (y_speed < gravity_cap)
                    {
                        y_speed = min(y_speed + gravity_force, gravity_cap);
                    }
                }
            }
            
            // Roll
            if (animation_is_starting(5)) audio_play_single(sfxRoll);
            if (animation_is_finished())
            {
                animation_play(PLAYER_ANIMATION.ROLL);
                return player_perform(on_ground ? player_is_rolling : player_is_falling, false);
            }
            break;
        }
        case PHASE.EXIT:
        {
            break;
        }
    }
}

#endregion