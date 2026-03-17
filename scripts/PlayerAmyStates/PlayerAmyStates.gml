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
            animation_play(AMY_ANIMATION.LEAP);
            
            // Sound
            audio_play_single(sfxJump);
            break;
        }
        case PHASE.STEP:
        {
            // Move
            player_move_in_air();
            if (state_changed) exit;
            
            // Land
            if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
            
            // Head Slide
            if (input_button.aux.pressed) return player_perform(player_is_head_sliding);
            
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

function player_is_head_sliding(_phase)
{
    switch (_phase)
    {
        case PHASE.ENTER:
        {
            // Set flags
            head_slide_state = 0;
            
            // Animate
            animation_play(AMY_ANIMATION.HEAD_SLIDE);
            break;
        }
        case PHASE.STEP:
        {
            if (on_ground)
            {
                // Move
                player_move_on_ground();
                if (state_changed) exit;
                
                // Fall
                if (not on_ground)
                {
                    // Set flags
                    if (head_slide_state == 1) head_slide_state = 0;
                    
                    // Detach from ground
                    player_ground(undefined);
                }
                
                // Cancel on steep slopes
                if (not player_check_ground_skill()) x_speed = 0;
                
                // Slide
                switch (head_slide_state)
                {
                    case 0:
                    {
                        var head_slide_speed = 2;
                        if (abs(x_speed) < head_slide_speed) x_speed = image_xscale * head_slide_speed;
                        head_slide_state = 1;
                        break;
                    }
                    case 1:
                    {
                        x_speed -= min(abs(x_speed), 24 / 256) * sign(x_speed);
                        if (x_speed == 0)
                        {
                            head_slide_state = 2;
                            animation_data.variant = 2;
                            break;
                        }
                        
                        if (animation_data.time mod 4 == 0)
                        {
                            // Create brake dust
                            var ox = x + dsin(direction) * y_radius;
                            var oy = y + dcos(direction) * y_radius;
                            particle_create(ox, oy, global.ani_brake_dust_v0);
                        }
                        break;
                    }
                }
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
            
            // Stand
            if (animation_data.variant == 2 and animation_is_finished())
            {
                return player_perform(player_is_standing);
            }
            break;
        }
        case PHASE.EXIT:
        {
            break;
        }
    }
}