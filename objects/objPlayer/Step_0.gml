/// @description Behave
if (ctrlGame.game_paused) exit;

// Boost Mode
player_refresh_boost_mode();

// Input
if (input_enabled and (player_index == 0 or cpu_gamepad_time > 0))
{
    input_axis_x = InputOpposing(INPUT_VERB.LEFT, INPUT_VERB.RIGHT, player_index);
    input_axis_y = InputOpposing(INPUT_VERB.UP, INPUT_VERB.DOWN, player_index);
    
    struct_foreach(input_button, function(name, value)
    {
        var verb = value.verb;
        value.check = InputCheck(verb, player_index);
        value.pressed = InputPressed(verb, player_index);
        value.released = InputReleased(verb, player_index);
    });
    
    if (confusion_time > 0) input_axis_x *= -1;
    if (cpu_gamepad_time > 0) cpu_gamepad_time--;
    if (input_button.select.pressed) player_gain_rings(150);
}

// CPU
if (player_index != 0 and cpu_gamepad_time == 0)
{
    var leader = ctrlStage.stage_players[0];
    if (instance_exists(leader))
    {
        if (state != player_is_dead)
        {
            var dx = (leader.x - x) div 1;
            var dy = (leader.y - y) div 1;
            
            var sine = dsin(gravity_direction);
            var cosine = dcos(gravity_direction);
            
            switch (cpu_state)
            {
                case CPU_STATE.CROUCH:
                {
                    player_refresh_inputs();
                    
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
                            image_xscale = esign(sine == 0 ? cosine * dx : -sine * dy, leader.image_xscale);
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
                    player_refresh_inputs();
                    
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
                case CPU_STATE.BUDDY_FLIGHT:
                {
                    if (state == player_is_propeller_flying)
                    {
                        player_refresh_inputs();
                        
                        if (flight_carry)
                        {
                            input_axis_x = InputOpposing(INPUT_VERB.LEFT, INPUT_VERB.RIGHT);
                            input_axis_y = InputOpposing(INPUT_VERB.UP, INPUT_VERB.DOWN);
                            input_button.jump.check = InputCheck(INPUT_VERB.JUMP);
                            input_button.jump.pressed = InputPressed(INPUT_VERB.JUMP);
                        }
                        else
                        {
                            var x_dist = (sine == 0 ? cosine * dx : -sine * dy);
                            var y_dist = (sine == 0 ? cosine * dy : sine * dx);
                            if (x_dist > 256 or y_dist > 256 or flight_time > PROPELLER_FLIGHT_DURATION - 30)
                            {
                                cpu_state = CPU_STATE.FOLLOW;
                                break;
                            }
                            else
                            {
                                x_dist -= x_speed * 16;
                                x_dist += leader.x_speed * 16;
                                if (x_dist <= -12)
                                {
                                    input_axis_x = -1;
                                }
                                else if (x_dist >= 12)
                                {
                                    input_axis_x = 1;
                                }
                                
                                y_dist -= y_speed * 16;
                                if (leader.input_axis_y == 1)
                                {
                                    y_dist += 64;
                                }
                                else
                                {
                                    var height_difference = max(64 - abs(leader.y_speed * 16), 0);
                                    y_dist -= height_difference;
                                }
                                
                                if (y_dist <= 0) input_button.jump.pressed = true;;
                            }
                        }
                        break;
                    }
                    else if (cpu_state_time > 0)
                    {
                        input_button.jump.check = true;
                        if (--cpu_state_time == 0 and state == player_is_jumping)
                        {
                            y_speed = max(y_speed, -2);
                            flight_hammer = false;
                            player_perform(player_is_propeller_flying);
                        }
                        break;
                    }
                    
                    cpu_state = CPU_STATE.FOLLOW;
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
                    
                    var x_offset = 32 * (abs(leader.x_speed) < 4);
                    input_axis_x = leader.cpu_axis_x[0];
                    input_axis_y = leader.cpu_axis_y[0];
                    input_button.jump.check = leader.cpu_input_jump[0];
                    input_button.jump.pressed = leader.cpu_input_jump_pressed[0];
                    
                    // Move
                    var x_dist = (sine == 0 ? cosine * dx : -sine * dy);
                    if (x_dist + 16 + x_offset < 0)
                    {
                        input_axis_x = -1;
                        // TODO: The checks for xscale should also check if the player is pushing
                        if (image_xscale == -1 and x_speed != 0)
                        {
                            if (sine == 0) x -= sign(cosine);
                            else y -= -sine;
                        }
                    }
                    else if (x_dist - 16 - x_offset > 0)
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
                    var y_dist = (sine == 0 ? cosine * dy : sine * dx);
                    var jump_auto = 0;
                    // TODO: Check for pushing first
                    if (y_dist + 32 > 0)
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
if (input_button.swap.pressed)
{
	if (player_index == 0 and array_length(ctrlStage.stage_players) > 1 and state != player_is_hurt and state != player_is_dead)
	{
		var swap_config = db_read(SAVE_DATABASE, true, "swap");
		var partner = (input_button.alt.check ? array_last(ctrlStage.stage_players) : ctrlStage.stage_players[1]);
		if (swap_config and partner.cpu_gamepad_time == 0)
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
                    
                    cpu_state = (state == player_is_propeller_flying ? CPU_STATE.BUDDY_FLIGHT : CPU_STATE.FOLLOW);
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
        var flicker_config = db_read(CONFIG_DATABASE, CONFIG_DEFAULT_FLICKER, "flicker");
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

// Afterimages
player_update_animation_history();

afterimage_visible = boost_mode;
if (afterimage_visible)
{
	for (var i = 0; i < AFTERIMAGE_COUNT; i++)
	{
	    var delay = i * 2 + 2;
        var history_index = modwrap(animation_history_index - delay, 0, ANIMATION_RECORD_COUNT);
        var record = animation_history[history_index];
        with (afterimage_list[i])
        {
            x = record.x;
            y = record.y;
            image_xscale = record.image_xscale;
            image_yscale = record.image_yscale;
            image_angle = record.image_angle;
            animation_set(record.ani);
            animation_data.speed = record.ani_speed;
        }
	}
}