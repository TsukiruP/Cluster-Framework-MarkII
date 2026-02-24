/// @description Behave
if (ctrlGame.game_paused) exit;

// Boost Mode
if (db_read(DATABASE_SAVE, false, "boost"))
{
    boost_index = (global.ring_count > 10 ? 1 : 0) + min(global.ring_count / 50, 3);
    
    if (boost_mode)
    {
        if (on_ground or superspeed_time < 0)
        {
            boost_speed = boost_threshold[boost_index];
            if (abs(x_speed) < 4.5 or superspeed_time < 0)
            {
                boost_mode = false;
                boost_speed = 0;
            }
        }
    }
    else
    {
        if (on_ground and abs(x_speed) >= speed_limit and not (superspeed_time < 0))
        {
            if (boost_speed >= boost_threshold[boost_index])
            {
                boost_mode = true;
                player_speed_break();
                camera_set_x_lag_time(16);
                audio_play_single(sndSpeedBreak);
            }
        }
        else
        {
            boost_speed = 0;
        }
    }
    
    if (boost_mode or superspeed_time > 0)
    {
        speed_limit = 12;
        speed_cap = 15;
    }
    else
    {
        speed_limit = 6;
        speed_cap = 9;
    }
    
    // TODO: Halve speed_limit when underwater.
    
    acceleration = base_acceleration + (2 / 256) * min(global.ring_count / 50, 30);
    if (global.ring_count > 10) acceleration += 4 / 256;
    air_acceleration = acceleration * 2;
}

// Input
if (input_enabled and (player_index == 0 or cpu_gamepad_time > 0))
{
    input_axis_x = InputOpposing(INPUT_VERB.LEFT, INPUT_VERB.RIGHT, player_index);
    input_axis_y = InputOpposing(INPUT_VERB.UP, INPUT_VERB.DOWN, player_index);
    if (confusion_time > 0) input_axis_x *= -1;
    
    struct_foreach(input_button, function(name, value)
    {
        var verb = value.verb;
        value.check = InputCheck(verb, player_index);
        value.pressed = InputPressed(verb, player_index);
        value.released = InputReleased(verb, player_index);
    });
    
    if (cpu_gamepad_time > 0) cpu_gamepad_time--;
    if (input_button.select.pressed) player_speed_break();
}

// CPU
if (player_index != 0 and cpu_gamepad_time == 0)
{
    player_refresh_inputs();
    var leader = ctrlStage.stage_players[0];
    if (instance_exists(leader))
    {
        if (state != player_is_dead)
        {
            var x_dist = leader.x - x;
            var y_dist = leader.y - y;
            
            var sine = dsin(gravity_direction);
            var cosine = dcos(gravity_direction);
            
            switch (cpu_state)
            {
                case CPU_STATE.CROUCH:
                {
                    if (cpu_state_time == 0)
                    {
                        cpu_state = CPU_STATE.FOLLOW;
                        cpu_state_time = 0;
                    }
                    else
                    {
                        if (abs(x_speed) < 0.25 and control_lock_time == 0 and on_ground)
                        {
                            x_speed = 0;
                            input_axis_y = 1;
                            image_xscale = esign(sine == 0 ? cosine * x_dist : -sine * y_dist, leader.image_xscale);
                            if (state == player_is_crouching)
                            {
                                cpu_state = CPU_STATE.SPIN_DASH;
                                cpu_state_time = 64;
                            }
                        }
                        cpu_state_time--;
                    }
                    break;
                }
                case CPU_STATE.SPIN_DASH:
                {
                    if (cpu_state_time == 0)
                    {
                        cpu_state = CPU_STATE.FOLLOW;
                        cpu_state_time = 0;
                    }
                    else
                    {
                        input_axis_y = 1;
                        input_button.jump.pressed = (cpu_state_time mod 16 == 0);
                        cpu_state_time--;
                    }
                    break;
                }
                default:
                {
                    // Panic
                    if (abs(x_speed) < 0.5 and control_lock_time > 0)
                    {
                        cpu_state = CPU_STATE.CROUCH;
                        cpu_state_time = 128;
                        break;
                    }
                    
                    var leader_extra_dist = 32 * (abs(leader.x_speed) < 4);
                    input_axis_x = leader.cpu_axis_x[0];
                    input_axis_y = leader.cpu_axis_y[0];
                    input_button.jump.check = leader.cpu_input_jump[0];
                    input_button.jump.pressed = leader.cpu_input_jump_pressed[0];
                    
                    // TODO: Check for propeller flight
                    
                    // Move
                    var leader_x_dist = (sine == 0 ? cosine * x_dist : -sine * y_dist );
                    if (leader_x_dist + 16 + leader_extra_dist < 0)
                    {
                        input_axis_x = -1;
                        // TODO: The checks for xscale should also check if the player is pushing
                        if (image_xscale == -1 and x_speed != 0)
                        {
                            if (sine == 0) x -= sign(cosine);
                            else y -= -sine;
                        }
                    }
                    if (leader_x_dist - 16 - leader_extra_dist > 0)
                    {
                        input_axis_x = 1;
                        // TODO: The checks for xscale should also check if the player is pushing
                        if (image_xscale == 1 and x_speed != 0)
                        {
                            if (sine == 0) x += sign(cosine);
                            else y += -sine;
                        }
                    }
                    
                    // Jump
                    var jump_dist = (sine == 0 ? cosine * y_dist : sine * x_dist);
                    var jump_auto = 0;
                    // TODO: Check for pushing first
                    if (jump_dist + 32 > 0)
                    {
                        jump_auto = 2;
                        cpu_state_time = 64;
                    }
                    else
                    {
                        if (cpu_state_time > 0) cpu_state_time--;
                        jump_auto = (cpu_state_time > 0 ? 1 : 0);
                    }
                    
                    if (leader.state != player_is_dead)
                    {
                        switch (jump_auto)
                        {
                            case 0:
                            {
                                if (on_ground)
                                {
                                    if (not input_button.jump.check) input_button.jump.pressed = true;
                                    input_button.jump.check = true;
                                }
                                jump_cap = false;
                                break;
                            }
                            case 1:
                            {
                                input_button.jump.check = true;
                                break;
                            }
                        }
                    }
                }
            }
        }
        
        // Respawn
        if (not instance_in_view())
        {
            if (--cpu_respawn_time == 0) player_respawn_cpu();
        }
        else if (cpu_respawn_time != CPU_RESPAWN_DURATION)
        {
            cpu_respawn_time = CPU_RESPAWN_DURATION;
        }
        
        // Swap to player
        if (InputCheckMany(-1, player_index)) cpu_gamepad_time = CPU_GAMEPAD_DURATION;
    }
}

// State
state(PHASE.STEP);
if (state_changed) state_changed = false;
player_animate();

// Swap
if (player_index == 0 and array_length(ctrlStage.stage_players) > 1 and state != player_is_hurt and state != player_is_dead)
{
    var partner = (input_button.alt.check ? array_last(ctrlStage.stage_players) : ctrlStage.stage_players[1]);
    if (input_button.swap.pressed)
    {
        if (partner.cpu_gamepad_time == 0)
        {
            if (instance_in_view(partner))
            {
                var can_leader_swap = (swap_time == 0 and sign(superspeed_time) != -1 and confusion_time == 0);
                var can_partner_swap = false;
                with (partner) can_partner_swap = (state != player_is_hurt and state != player_is_dead);
                if (can_leader_swap and can_partner_swap)
                {
                    with (partner)
                    {
                        swap_time = SWAP_DURATION;
                        shield.index = other.shield.index;
                        invincibility_time = other.invincibility_time;
                        superspeed_time = other.superspeed_time;
                        player_refresh_inputs();
                    }
                    
                    if (input_button.alt.check)
                    {
                        array_insert(global.characters, 0, array_pop(global.characters));
                        with (ctrlStage) array_insert(stage_players, 0, array_pop(stage_players));
                    }
                    else
                    {
                        array_push(global.characters, array_shift(global.characters));
                        with (ctrlStage) array_push(stage_players, array_shift(stage_players));
                    }
                    
                    cpu_state = CPU_STATE.FOLLOW;
                    player_refresh_status();
                    player_refresh_inputs();
                    player_refresh_records();
                    audio_play_single(sfxSwap);
                    InputVerbConsume(INPUT_VERB.SWAP);
                    with (objCamera) focus = ctrlStage.stage_players[0];
                    with (objPlayer)
                    {
                        player_index = array_get_index(ctrlStage.stage_players, id);
                        depth = ctrlStage.player_depth + player_index;
                    }
                    instance_create_depth(x, y, ctrlStage.display_depth, objSwapCooldown);
                }
                else
                {
                    audio_play_single(sfxSwapFail);
                }
            }
            else
            {
                var can_respawn = false;
                with (partner) can_respawn = (state != player_is_hurt and state != player_is_dead);
                if (can_respawn) partner.player_respawn_cpu();
            }
        }
    }
}

// Spin Dash Dust
with (spin_dash_dust)
{
    var action = other.state;
    if (action == player_is_spin_dashing)
    {
        var x_int = other.x div 1;
        var y_int = other.y div 1;
        
        var sine = dsin(other.gravity_direction);
        var cosine = dcos(other.gravity_direction);
        
        x = x_int + sine * other.y_radius;
        y = y_int + cosine * other.y_radius;
        image_xscale = other.image_xscale;
        image_angle = other.mask_direction;
        animation_data.variant = (floor(other.spin_dash_charge) > 2);
        animation_set(global.ani_spin_dash_dust);
    }
    else if (animation_data.ani != undefined)
    {
        animation_set(undefined);
    }
}

// Shield
with (shield)
{
    var invincible = (other.invincibility_time > 0);
    if (index != SHIELD.NONE or invincible)
    {
        x = other.x div 1;
        y = other.y div 1;
        
        var shield_advance = (index == SHIELD.BASIC or index == SHIELD.MAGNETIC or invincible);
        var flicker_config = db_read(DATABASE_CONFIG, CONFIG_DEFAULT_FLICKER, "flicker");
        animation_play(invincible ? -1 : index);
        switch (animation_data.index)
        {
            case -1:
            {
                animation_set(global.ani_shield_invincibility_v0);
                if (animation_data.time mod 8 == 0)
                {
                    var x_off = irandom_range(-16, 16);
                    var y_off = irandom_range(-16, 16);
                    particle_create(x + x_off, y + y_off, global.ani_shield_invincibility_sparkle_v0);
                }
                break;
            }
            case SHIELD.BASIC:
            {
                animation_set(global.ani_shield_basic_v0);
                break;
            }
            case SHIELD.MAGNETIC:
            {
                animation_set(global.ani_shield_magnetic_v0);
                break;
            }
            case SHIELD.AQUA:
            {
                if (animation_is_finished())
                {
                    switch (animation_data.variant)
                    {
                        case 1:
                        {
                            animation_data.variant = 2;
                            break;
                        }
                        case 3:
                        {
                            animation_data.variant = 0;
                            break;
                        }
                    }
                }
                animation_set(global.ani_shield_aqua);
                break;
            }
            case SHIELD.FLAME:
            {
                if (animation_data.variant == 1 and animation_is_finished()) animation_data.variant = 0;
                animation_set(global.ani_shield_flame);
                break;
            }
            case SHIELD.THUNDER:
            {
                if (animation_is_finished()) animation_data.variant = (animation_data.variant == 0 ? 1 : 0);
                animation_set(global.ani_shield_thunder);
                break;
            }
        }
        
        // Visible
        if (shield_advance)
        {
            switch (flicker_config)
            {
                case CONFIG_FLICKER.ORIGINAL:
                {
                    visible = animation_data.time mod 4 < 2;
                    break;
                }
                case CONFIG_FLICKER.VIRTUAL_CONSOLE:
                case CONFIG_FLICKER.VIRTUAL_CONSOLE_ADVANCE_3:
                {
                    visible = animation_data.time mod 6 < (flicker_config == CONFIG_FLICKER.VIRTUAL_CONSOLE_ADVANCE_3 ? 4 : 2);
                    break;
                }
            }
        }
        else if (animation_data.index == SHIELD.AQUA and animation_data.variant == 0)
        {
            visible = animation_data.time mod 4 < 2;
        }
        else
        {
            visible = true;
        }
        
        if (not (animation_data.index == SHIELD.FLAME and animation_data.variant == 1))
        {
            image_xscale = 1;
        }
        image_angle = other.gravity_direction;
        image_alpha = (shield_advance and flicker_config == CONFIG_FLICKER.OFF ? 0.6 : 1);
    }
    else if (animation_data.ani != undefined)
    {
        animation_set(undefined);
    }
}

// Miasma
with (miasma)
{
    var debuffed = other.superspeed_time < 0 or other.confusion_time > 0;
    if (debuffed)
    {
        var x_int = other.x div 1;
        var y_int = other.y div 1;
        
        var sine = dsin(other.gravity_direction);
        var cosine = dcos(other.gravity_direction);
        
        x = x_int - sine * 16;
        y = y_int - cosine * 16;
        image_angle = other.mask_direction;
        animation_set(global.ani_miasma_v0);
    }
    else if (animation_data.ani != undefined)
    {
        animation_set(undefined);
    }
}

// Speed Break
with (speed_break)
{
    if (visible)
    {
        x = other.x div 1;
        y = other.y div 1;
        
        switch (animation_data.variant)
        {
            case 1:
            {
                if (time++ > 24)
                {
                    visible = false;
                    animation_set(undefined);
                    break;
                }
                
                for (var i = 0; i < SPEED_BREAK_COUNT; i++)
                {
                    positions[i][0] += accelerations[i][0];
                    positions[i][1] += accelerations[i][1];
                    
                    positions[i][0] -= unkE2;
                    positions[i][1] -= unkE4;
                    
                    accelerations[i][0] *= 0.78125;
                    accelerations[i][1] *= 0.78125;
                    
                    unkE2 *= 1.00390625;
                    unkE4 *= 1.00390625;
                }
                break;
            }
            default:
            {
                for (var i = 0; i < SPEED_BREAK_COUNT / 2; i++)
                {
                    if (i & 1)
                    {
                        positions[i][0] += accelerations[i][0];
                        positions[i][1] += accelerations[i][1];
                    }
                    else
                    {
                        positions[i][0] -= accelerations[i][0];
                        positions[i][1] -= accelerations[i][1];
                    }
                    
                    accelerations[i][0] *= 0.78125;
                    accelerations[i][1] *= 0.78125;
                }
                
                if (time++ > 8)
                {
                    var x_scale = other.image_xscale;
                    var rot = other.direction;
                    animation_data.variant = 1;
                    animation_set(global.ani_speed_break);
                    for (var i = 0; i < SPEED_BREAK_COUNT; i++)
                    {
                        var rand_rot = irandom(359);
                        if (x_scale == -1)
                        {
                            rand_rot += 90;
                            unkE2 = dcos(rot + 180) * 4;
                            unkE4 = -dsin(rot + 180) * 4;
                        }
                        else
                        {
                            unkE2 = dcos(rot) * 4;
                            unkE4 = -dsin(rot) * 4;
                        }
                        
                        var accel = irandom(4) + 6;
                        accelerations[i][0] = dcos(rand_rot) * accel;
                        accelerations[i][1] = -dsin(rand_rot) * accel;
                    }
                }
            }
        }
    }
}

// Afterimage
afterimage_history[afterimage_index].x = x div 1;
afterimage_history[afterimage_index].y = y div 1;
afterimage_history[afterimage_index].image_xscale = image_xscale;
afterimage_history[afterimage_index].image_yscale = image_yscale;
afterimage_history[afterimage_index].image_angle = image_angle;
afterimage_history[afterimage_index].ani = animation_data.ani;
afterimage_history[afterimage_index].ani_speed = animation_data.speed;
afterimage_index = ++afterimage_index mod array_length(afterimage_history);

afterimage_visible = boost_mode;
if (afterimage_visible)
{
	for (var i = 0; i < AFTERIMAGE_COUNT; i++)
	{
	    with (boost_afterimages[i])
	    {
	        var delay = (i * 2) + 2;
	        var record_index = modwrap(other.afterimage_index - delay, 0, AFTERIMAGE_RECORD_COUNT);
	        record = other.afterimage_history[record_index];
	        animation_set(record.ani);
	        animation_data.speed = record.ani_speed;
	    }
	}
}