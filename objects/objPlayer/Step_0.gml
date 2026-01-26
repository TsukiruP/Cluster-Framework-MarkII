/// @description Behave
if (ctrlGame.game_paused) exit;

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
}

// CPU
if (player_index != 0 and cpu_gamepad_time == 0)
{
    player_refresh_inputs();
    var leader = ctrlStage.stage_players[0];
    if (instance_exists(leader))
    {
        var sine = dsin(gravity_direction);
        var cosine = dcos(gravity_direction);
        var x_dist = leader.x - x;
        var y_dist = leader.y - y;
        
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
                // TODO: The checks for xscale should also check if the player is pushing
                var leader_x_dist = (sine == 0 ? cosine * x_dist : -sine * y_dist );
                if (leader_x_dist + 16 + leader_extra_dist < 0)
                {
                    input_axis_x = -1;
                    if (image_xscale == -1 and x_speed != 0)
                    {
                        if (sine == 0) x -= sign(cosine);
                        else y -= -sine;
                    }
                }
                if (leader_x_dist - 16 - leader_extra_dist > 0)
                {
                    input_axis_x = 1;
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
        
        // Respawn
        if (not instance_in_view() and state != player_is_dead)
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
    var partner = ctrlStage.stage_players[1];
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
                        player_index = 0;
                        swap_time = SWAP_DURATION;
                        shield.index = other.shield.index;
                        invincibility_time = other.invincibility_time;
                        superspeed_time = other.superspeed_time;
                        player_refresh_inputs();
                    }
                    
                    player_index = array_length(ctrlStage.stage_players) - 1;
                    player_refresh_status();
                    player_refresh_inputs();
                    player_refresh_records();
                    array_push(global.characters, array_shift(global.characters));
                    with (ctrlStage) array_push(stage_players, array_shift(stage_players));
                    with (objCamera) focus = ctrlStage.stage_players[0];
                    with (objPlayer) depth = ctrlStage.stage_depth + player_index - DEPTH_OFFSET_PLAYER;
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
        var charge = floor(other.spin_dash_charge);
        x = x_int + sine * other.y_radius;
        y = y_int + cosine * other.y_radius;
        image_xscale = other.image_xscale;
        image_angle = other.mask_direction;
        animation_data.variant = (charge > 2);
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
        var x_int = other.x div 1;
        var y_int = other.y div 1;
        x = x_int;
        y = y_int;
        
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