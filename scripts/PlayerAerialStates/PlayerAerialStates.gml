/// @function player_is_falling(phase)
function player_is_falling(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            if (not (aerial_flags & AERIAL_FLAG_PLATFORM))
            {
                // Rise
                y_speed = -dsin(local_direction) * x_speed;
                x_speed *= dcos(local_direction);
            }
            
            // Detach from ground
            player_ground(undefined);
            
            // Animate
            animation_play(PLAYER_ANIMATION.FALL, 0, [PLAYER_ANIMATION.ROLL]); 
            break;
        }
        case PHASE.STEP:
        {
            // Accelerate
            if (input_axis_x != 0)
            {
                image_xscale = input_axis_x;
                if (abs(x_speed) < speed_cap or sign(x_speed) != input_axis_x)
                {
                    x_speed += air_acceleration * input_axis_x;
                    if (abs(x_speed) > speed_cap and sign(x_speed) == input_axis_x)
                    {
                        x_speed = speed_cap * input_axis_x;
                    }
                }
            }
            
            // Move
            player_move_in_air();
            if (state_changed) exit;
            
            // Land
            if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
            
            // Skill
            if (player_try_skill()) exit;
            
            // Apply air resistance
            if (y_speed < 0 and y_speed > -4 and abs(x_speed) > AIR_DRAG_THRESHOLD)
            {
                x_speed *= AIR_DRAG;
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
            aerial_flags &= ~AERIAL_FLAG_PLATFORM;
            break;
        }
    }
}

/// @function player_is_jumping(phase)
function player_is_jumping(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Set flags
            jump_cap = true;
            
            // Leap
            var sine = dsin(local_direction);
            var cosine = dcos(local_direction);
            y_speed = -sine * x_speed - cosine * jump_height;
            x_speed = cosine * x_speed - sine * jump_height;
            
            // Detach from ground
            player_ground(undefined);
            
            // Animate
            animation_play(PLAYER_ANIMATION.JUMP, 0);
            break;
        }
        case PHASE.STEP:
        {
            // Accelerate
            if (input_axis_x != 0)
            {
                image_xscale = input_axis_x;
                if (abs(x_speed) < speed_cap or sign(x_speed) != input_axis_x)
                {
                    x_speed += air_acceleration * input_axis_x;
                    if (abs(x_speed) > speed_cap and sign(x_speed) == input_axis_x)
                    {
                        x_speed = speed_cap * input_axis_x;
                    }
                }
            }
            
            // Move
            player_move_in_air();
            if (state_changed) exit;
            
            // Land
            if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
            
            // Skill
            if (player_try_skill()) exit;
            
            // Lower height
            var jump_check = (jump_alternate == 2 ? input_button.aux.check : input_button.jump.check)
            if (jump_cap and y_speed < -jump_release and not jump_check)
            {
                y_speed = -jump_release;
            }
            
            // Apply air resistance
            if (y_speed < 0 and y_speed > -4 and abs(x_speed) > AIR_DRAG_THRESHOLD)
            {
                x_speed *= AIR_DRAG;
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
            jump_alternate = 0;
            break;
        }
    }
}

/// @function player_is_hurt(phase)
function player_is_hurt(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
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
            
            // Fall
            if (y_speed < gravity_cap)
            {
                y_speed = min(y_speed + hurt_force, gravity_cap);
            }
            break;
        }
        case PHASE.EXIT:
        {
            recovery_time = RECOVERY_DURATION;
            break;
        }
    }
}

/// @function player_is_dead(phase)
function player_is_dead(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Set time:
            state_time = 64;
            
            // Detach from ground
            player_ground(undefined);
            
            // Animate
            animation_play(PLAYER_ANIMATION.DEAD);
            break;
        }
        case PHASE.STEP:
        {
            if (player_index == 0 and --state_time == 0)
            {
                transition_create(room, TRANSITION.TRY_AGAIN);
                //if (LIVES_ENABLED) global.life_count--;
                with (ctrlStage) pause_allow = false;
            }
            
            // Move
            var sine = dsin(gravity_direction);
            var cosine = dcos(gravity_direction);
            x += sine * y_speed;
            y += cosine * y_speed;
            
            // TODO: SonicForGMS checks if the player is 48 below bound_bottom.
            
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

/// @function player_is_aqua_bounding
function player_is_aqua_bounding(phase)
{
    switch (phase)
    {
        case PHASE.ENTER:
        {
            // Bound
            x_speed = 0;
            y_speed = 8;
            
            // Animate
            animation_play(PLAYER_ANIMATION.ROLL);
            break;
        }
        case PHASE.STEP:
        {
            // Accelerate
            if (input_axis_x != 0)
            {
                image_xscale = input_axis_x;
                if (abs(x_speed) < speed_cap or sign(x_speed) != input_axis_x)
                {
                    x_speed += air_acceleration * input_axis_x;
                    if (abs(x_speed) > speed_cap and sign(x_speed) == input_axis_x)
                    {
                        x_speed = speed_cap * input_axis_x;
                    }
                }
            }
            
            // Move
            player_move_in_air();
            if (state_changed) exit;
            
            // Rebound
            if (on_ground)
            {
                player_perform(player_is_jumping);
                y_speed = -8;
                jump_alternate++;
                audio_play_single(sfxAquaBound);
            }
            
            // Apply air resistance
            if (y_speed < 0 and y_speed > -4 and abs(x_speed) > AIR_DRAG_THRESHOLD)
            {
                x_speed *= AIR_DRAG;
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
            with (shield)
            {
                if (animation_data.index == SHIELD.AQUA) animation_data.variant = 3;
            }
            break;
        }
    }
}