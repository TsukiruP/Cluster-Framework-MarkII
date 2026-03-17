/// @description Actions

/// @description Checks if the player performs a jump.
/// @returns {Bool}
player_try_jump = function()
{
    if (object_index == objAmy)
    {
        if (player_check_ground_skill())
        {
            // Hammer Jump
            if (input_button.aux.pressed and ((input_axis_y == 1 and input_axis_x == 0) or input_button.alt.check))
            {
                var hammer_jump_save = db_read(SAVE_DATABASE, AMY_DEFAULT_HAMMER_JUMP, "amy", "hammer_jump");
                if (hammer_jump_save)
                {
                    var hammer_jump_height = 6;
                    
                    /* TODO: Hammer Jump is 3.375 underwater */
                    
                    // Set flags
                    jump_cap = false;
                    aerial_flags |= AERIAL_FLAG_HAMMER;
                    
                    // Leap
                    var sine = dsin(local_direction);
                    var cosine = dcos(local_direction);
                    y_speed = -sine * x_speed - cosine * hammer_jump_height;
                    x_speed = cosine * x_speed - sine * hammer_jump_height;
                    
                    // Detact from ground
                    player_ground(undefined);
                    
                    // Perform
                    player_perform(player_is_jumping, false);
                    
                    // Animate
                    animation_play(AMY_ANIMATION.HAMMER_JUMP);
                    
                    // Sound
                    audio_play_single(sfxJump);
                    return true;
                }
            }
            
            // Leap
            if (input_button.jump.pressed and input_axis_y == 1 and input_axis_x == 0)
            {
                var spin_save = db_read(SAVE_DATABASE, AMY_DEFAULT_SPIN, "amy", "spin");
                var spin_alt_save = db_read(SAVE_DATABASE, AMY_DEFAULT_SPIN_ALT, "amy", "spin_alt");
                if (spin_save == false and spin_alt_save == AMY_SPIN_ALT.LEAP)
                {
                    player_perform(player_is_leaping);
                    return true;
                }
            }
        }
    }
    
    if (input_button.jump.pressed)
    {
        // Don't jump when crouching
        if (state != player_is_crouching)
        {
            // Perform
            player_perform(player_is_jumping);
            
            // Animate
            animation_play(object_index == objAmy ? PLAYER_ANIMATION.SPRING : PLAYER_ANIMATION.JUMP);
            
            // Sound
            audio_play_single(sfxJump);
            return true;
        }
    }
    
    return false;
};

/// @desctiption Checks if the player performs a Trick Action.
/// @param [time] Time to check (optional, defaults to 0).
/// @returns {Bool}
player_try_trick_action = function(_time = 0)
{
    if (input_button.tag.pressed)
    {
        var trick_actions_config = db_read(CONFIG_DATABASE, CONFIG_DEFAULT_TRICK_ACTIONS, "trick_actions");
        if (trick_actions_config and _time == 0)
        {
            trick_index = TRICK.BACK;
            if (input_axis_y == -1)
            {
                trick_index = TRICK.UP;
            }
            else if (input_axis_y == 1)
            {
                trick_index = TRICK.DOWN;
                if (object_index == objSonic or object_index == objAmy) boost_mode = false;
            }
            else if (input_axis_x == image_xscale)
            {
                trick_index = TRICK.FRONT;
            }
            
            player_gain_score(100);
            player_perform(player_is_trick_preparing);
            if (not ((object_index == objSonic or object_index == objKnuckles or object_index == objAmy) and
                trick_index == TRICK.DOWN))
            {
                audio_play_single(sfxTrickAction);
            }
            
            return true;
        }
    }
    
    return false;
};

/// @description Check is the player calls for a Flight Assist.
/// @returns {Bool}
player_try_flight_assist = function()
{
    if (state == player_is_jumping)
    {
        if (input_axis_y == -1)
        {
            var flight_assist_config = db_read(CONFIG_DATABASE, CONFIG_DEFAULT_FLIGHT_ASSIST, "flight_assist");
            if (flight_assist_config)
            {
                if (array_length(ctrlStage.stage_players) > 1 and ctrlStage.stage_players[1].object_index == objMiles)
                {
                    var partner = ctrlStage.stage_players[1];
                    var dx = partner.x - x;
                    var dy = partner.y - y;
                    
                    var sine = dsin(gravity_direction);
                    var cosine = dcos(gravity_direction);
                    var x_dist = (sine == 0 ? cosine * dx : -sine * dy);
                    var y_dist = (sine == 0 ? cosine * dy : sine * dx);
                    
                    if (partner.cpu_gamepad_time == 0 and partner.cpu_state == CPU_STATE.FOLLOW and x_dist < 192 and y_dist < 128)
                    {
                        var start_flight = false;
                        if (partner.state == player_is_jumping)
                        {
                            start_flight = true;
                        }
                        else if (partner.on_ground)
                        {
                            with (partner)
                            {
                                player_refresh_inputs();
                                input_button.jump.pressed = true;
                                cpu_state = CPU_STATE.FLIGHT_ASSIST;
                                cpu_state_time = 8;
                            }
                        }
                        
                        if (start_flight)
                        {
                            with (partner)
                            {
                                y_speed = max(y_speed, -1.5);
                                cpu_state = CPU_STATE.FLIGHT_ASSIST;
                                cpu_state_time = 0;
                                flight_hammer = false;
                                player_perform(player_is_propeller_flying);
                            }
                            
                            /*var can_skill = false;
                            
                            switch (object_index)
                            {
                                case objSonic:
                                {
                                    // TODO: Check Sonic's skills.
                                    //var skill_save = db_read(SAVE_DATABASE, MILES_GROUND_SKILL.NONE, "sonic", "jump_skill");
                                    can_skill = true;
                                    break;
                                }
                                case objCream:
                                {
                                    can_skill = true;
                                    break;
                                }
                            }
                            
                            return not can_skill;*/
                            return false;
                            
                            /* AUTHOR NOTE: Sonic 3 AIR only checks for the Flame Dash, Aqua Bound, or glide. */
                        }
                    }
                }
            }
        }
    }
    
    return true;
};

/// @description Checks if the player performs a Shield Action.
/// @returns {Bool}
player_try_shield_action = function()
{
    aerial_flags |= AERIAL_FLAG_SHIELD_ACTION;
    switch (shield.index)
    {
        case SHIELD.AQUA:
        {
            // Set flags
            jump_alternate = input_button.aux.pressed;
            
            // Perform
            player_perform(player_is_aqua_bounding);
            
            // Animate
            with (shield)
            {
                if (animation_data.index == SHIELD.AQUA) animation_data.variant = 1;
            }
            
            return true;
        }
        case SHIELD.FLAME:
        {
            // Dash
            x_speed = image_xscale * 6;
            y_speed = 0;
            
            // Perform
            player_perform(player_is_jumping, false);
            
            // Animate
            camera_set_x_lag_time(16);
            animation_play(PLAYER_ANIMATION.JUMP, 1);
            with (shield)
            {
                if (animation_data.index == SHIELD.FLAME)
                {
                    image_xscale = other.image_xscale;
                    animation_data.variant = 1;
                }
            }
            
            // Sound
            audio_play_single(sfxFlameDash);
            return true;
        }
        case SHIELD.THUNDER:
        {
            // Leap
            y_speed = -4.125;
            
            // Perform
            player_perform(player_is_jumping, false);
            
            // Animate
            animation_play(PLAYER_ANIMATION.JUMP, 1);
            for (var i = 45; i <= 315; i += 90)
            {
                var sine = dcos(i);
                var cosine = dsin(i);
                particle_create(x, y, global.ani_shield_thunder_spark_v0, gravity_direction, 20, sine * 2, -cosine * 2, 0, 0);
            }
            
            // Sound
            audio_play_single(sfxThunderJump);
            return true;
        }
    }
    
    return false;
};

/// @description Checks if the player can perform a ground skill.
/// @returns {Bool}
player_check_ground_skill = function()
{
    return (on_ground and not (local_direction >= 90 and local_direction <= 270));
};

/// @description Check if the player performs a ground skill.
/// @returns {Bool}
player_try_ground_skill = function()
{
    // Abort if not player controlled
    if (player_index != 0 and cpu_gamepad_time == 0) return false;
    
    switch (object_index)
    {
        case objAmy:
        {
            if (input_button.aux.pressed and player_check_ground_skill())
            {
                // Perform
                player_perform(player_is_hammer_attacking);
                
                // Animate
                var hammer_skill_save = db_read(SAVE_DATABASE, AMY_DEFAULT_HAMMER_SKILL, "amy", "hammer_skill");
                if (hammer_skill_save == AMY_HAMMER_SKILL.BIG_HAMMER_ATTACK)
                {
                    animation_play(AMY_ANIMATION.BIG_HAMMER_ATTACK);
                }
                else
                {
                    amy_create_hammer_trail(HEART_PATTERN.HAMMER_ATTACK);
                }
                return true;
            }
            break;
        }
    }
    
    return false;
};

/// @description Checks if the player performs an air skill.
/// @returns {Bool}
player_try_air_skill = function()
{
    // Abort if not player controlled
    if (player_index != 0 and cpu_gamepad_time == 0) return false;
    
    var air_skills_config = db_read(CONFIG_DATABASE, CONFIG_DEFAULT_AIR_SKILLS, "air_skills");
    
    switch (object_index)
    {
        case objSonic:
        {
            if (state == player_is_jumping or air_skills_config)
            {
                if (input_button.jump.pressed and player_try_flight_assist())
                {
                    if (not (aerial_flags & AERIAL_FLAG_SHIELD_ACTION))
                    {
                        return player_try_shield_action();
                    }
                }
                
                if (input_button.aux.pressed)
                {
                    if (not (aerial_flags & AERIAL_FLAG_AIR_DASH))
                    {
                        var uncurl = (not (animation_data.index == PLAYER_ANIMATION.ROLL or animation_data.index == PLAYER_ANIMATION.JUMP));
                        
                        // Set flags
                        aerial_flags |= AERIAL_FLAG_AIR_DASH;
                        
                        // Dash
                        x_speed += image_xscale * 2.25;
                        y_speed = 0;
                        
                        // Perform
                        player_perform(player_is_falling, false);
                        
                        // Animate
                        animation_play(SONIC_ANIMATION.AIR_DASH, uncurl);
                        
                        // Sound
                        audio_play_single(sfxAirDash);
                        return true;
                    }
                }
            }
            break;
        }
        case objMiles:
        {
            if (state == player_is_jumping or air_skills_config)
            {
                if (input_button.jump.pressed)
                {
                    if (state != player_is_propeller_flying and flight_time < PROPELLER_FLIGHT_DURATION)
                    {
                        // Set flags
                        var ground_skill_save = db_read(SAVE_DATABASE, MILES_DEFAULT_GROUND_SKILL, "miles", "ground_skill");
                        flight_hammer = (ground_skill_save == MILES_GROUND_SKILL.HAMMER_ATTACK);
                        
                        // Perform
                        player_perform(player_is_propeller_flying);
                        return true;
                    }
                }
                
                if (input_button.aux.pressed)
                {
                    if (not (aerial_flags & AERIAL_FLAG_SHIELD_ACTION))
                    {
                        return player_try_shield_action();
                    }
                }
            }
            break;
        }
        case objKnuckles:
        {
            if (state == player_is_jumping or air_skills_config)
            {
                if (input_button.jump.pressed and player_try_flight_assist())
                {
                    return false;
                }
                
                if (input_button.aux.pressed)
                {
                    if (not (aerial_flags & AERIAL_FLAG_SHIELD_ACTION))
                    {
                        return player_try_shield_action();
                    }
                }
            }
            break;
        }
        case objAmy:
        {
            if (input_button.jump.pressed and player_try_flight_assist())
            {
                if (not (aerial_flags & AERIAL_FLAG_SHIELD_ACTION))
                {
                    return player_try_shield_action();
                }
            }
            
            if (input_button.aux.pressed)
            {
                if (not (aerial_flags & AERIAL_FLAG_HAMMER))
                {
                    // Set flags
                    aerial_flags |= AERIAL_FLAG_HAMMER;
                    
                    // Hammer Whirl
                    if (input_axis_y == 1 and input_axis_x == 0)
                    {
                        var hammer_whirl_save = db_read(SAVE_DATABASE, AMY_DEFAULT_HAMMER_WHIRL, "amy", "hammer_whirl");
                        if (hammer_whirl_save)
                        {
                            // Perform
                            player_perform(player_is_hammer_whirling);
                            return true;
                        }
                    }
                    
                    // Perform
                    player_perform(player_is_falling, false);
                    
                    // Animate
                    animation_play(AMY_ANIMATION.AIR_HAMMER_ATTACK);
                    amy_create_hammer_trail(HEART_PATTERN.AIR_HAMMER_ATTACK);
                    
                    // Sound
                    audio_play_single(sfxAirHammerAttack);
                    return true;
                }
            }
            break;
        }
        case objCream:
        {
            if (state == player_is_jumping or air_skills_config)
            {
                if (input_button.jump.pressed and player_try_flight_assist())
                {
                    if (state != player_is_fan_flying and flight_time < FAN_FLIGHT_DURATION)
                    {
                        player_perform(player_is_fan_flying);
                        return true;
                    }
                }
                
                if (input_button.aux.pressed)
                {
                    if (not (aerial_flags & AERIAL_FLAG_SHIELD_ACTION))
                    {
                        return player_try_shield_action();
                    }
                }
            }
            break;
        }
    }
    
    return false;
};

/// @description Resets air skills when grounded.
player_refresh_air_skills = function()
{
    switch (object_index)
    {
        case objMiles:
        case objCream:
        {
            if (on_ground) flight_time = 0;
            break;
        }
    }
};

/// @description Evaluates the player's condition after taking a hit.
/// @param {Id.Instance} inst Instance to check. Set to id to force a death, or noone to just hurt the player.
player_damage = function(inst)
{
    // Abort if the player is already dead or hurt
    if (state == player_is_dead or ((state == player_is_hurt or recovery_time > 0 or invincibility_time > 0) and inst != id)) exit;
    
    if (inst == id or (player_index == 0 and shield.index == SHIELD.NONE and global.ring_count == 0))
    {
        y_speed = -4.875; // TODO: Underwater, this is -2.625
        audio_play_single(inst != noone and inst.object_index == objSpikes ? sfxHurtSpikes : sfxHurt);
        return player_perform(player_is_dead);
    }
    else
    {
        var hurt_speed = -1.5;
        var ring_loss = false;
        animation_play(PLAYER_ANIMATION.HURT);
        if (inst == noone or abs(x_speed) <= 2.5)
        {
            if (abs(x_speed) > 0.625) x_speed = sign(x_speed) * hurt_speed;
            else x_speed = image_xscale * hurt_speed;
            animation_data.variant = 0;
        }
        else
        {
            x_speed = sign(x_speed) * -hurt_speed;
            animation_data.variant = 1;
        }
        
        y_speed = -3;
        
        if (player_index == 0)
        {
            if (shield.index != SHIELD.NONE)
            {
                shield.index = SHIELD.NONE;
            }
            else
            {
                ring_loss = true;
                player_drop_rings();
            }
        }
        
        if (not ring_loss) audio_play_single(inst != noone and inst.object_index == objSpikes ? sfxHurtSpikes : sfxHurt);
        return player_perform(player_is_hurt);
    }
};