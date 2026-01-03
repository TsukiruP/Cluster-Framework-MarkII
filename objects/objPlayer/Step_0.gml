/// @description Behave
if (ctrlGame.game_paused) exit;

#region Input

if (player_index == 0 or cpu_gamepad_time > 0)
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

if (player_index != 0 and cpu_gamepad_time == 0)
{
	player_reset_input();
	var leader_inst = ctrlStage.stage_players[0];
	if (instance_exists(leader_inst))
	{
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
			        	image_xscale = esign(leader_inst.x - x, leader_inst.image_xscale);
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
				
                var leader_extra_distance = 32 * (abs(leader_inst.x_speed) < 4);
                input_axis_x = leader_inst.cpu_axis_x[0];
                input_axis_y = leader_inst.cpu_axis_y[0];
                input_button.jump.check = leader_inst.cpu_input_jump[0];
                input_button.jump.pressed = leader_inst.cpu_input_jump_pressed[0];
                
                // TODO: Check for propeller flight
                
                // Move
                // TODO: The checks for xscale should also check if the player is pushing
                if (x > leader_inst.x + 16 + leader_extra_distance)
                {
                    input_axis_x = -1;
                    if (image_xscale == 1 and x_speed != 0) x++;
                }
                if (x < leader_inst.x - 16 - leader_extra_distance)
                {
                    input_axis_x = 1;
                    if (image_xscale == -1 and x_speed != 0) x--;
                }
                
                // Jump
                var jump_auto = 0;
                // TODO: Check for pushing first
                if (y - leader_inst.y < 32)
                {
                    jump_auto = 2;
                    cpu_state_time = 64;
                }
                else
                {
                	if (cpu_state_time > 0) cpu_state_time--;
                    jump_auto = (cpu_state_time > 0 ? 1 : 0);
                }
                
                if (leader_inst.state != player_is_dead)
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
        
        // Swap to player
        if (InputCheckMany(-1, player_index)) cpu_gamepad_time = CPU_GAMEPAD_DURATION;
	}
}

#endregion

#region Perform

state(PHASE.STEP);
if (state_changed) state_changed = false;
player_animate();

#endregion

#region Spin Dash Dust

with (spin_dash_stamp)
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
    else if (not is_undefined(animation_data.ani))
    {
        animation_set(undefined);
    }
}

#endregion

#region Shield

with (shield_stamp)
{
    var shield = other.shield;
    var invincible = (other.invin_time > 0);
    if (shield != SHIELD.NONE or invincible)
    {
        var x_int = other.x div 1;
        var y_int = other.y div 1;
        var sine = dsin(other.gravity_direction);
        var cosine = dcos(other.gravity_direction);
        x = x_int;
        y = y_int;
        
        var shield_advance = (shield == SHIELD.BASIC or shield == SHIELD.MAGNETIC or invincible);
        var flicker_config = db_read(global.config_database, CONFIG_DEFAULT_FLICKER, "flicker");
        animation_init(invincible ? -1 : shield);
        switch (animation_data.index)
        {
            case -1:
            {
                animation_set(global.ani_shield_invin_v0);
                if (animation_data.time mod 8 == 0)
                {
                    var x_off = irandom_range(-16, 16);
                    var y_off = irandom_range(-16, 16);
                    particle_create(x + x_off, y + y_off, global.ani_shield_invin_sparkle_v0);
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
            case SHIELD.FIRE:
            {
                if (animation_data.variant == 1 and animation_is_finished()) animation_data.variant = 0;
                animation_set(global.ani_shield_fire);
                break;
            }
            case SHIELD.BUBBLE:
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
                animation_set(global.ani_shield_bubble);
                visible = (animation_data.variant == 0 ? animation_data.time mod 4 < 2 : true);
                break;
            }
            case SHIELD.LIGHTNING:
            {
                if (animation_is_finished()) animation_data.variant = (animation_data.variant == 0 ? 1 : 0);
                animation_set(global.ani_shield_lightning);
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
        else if (animation_data.index == SHIELD.BUBBLE and animation_data.variant == 0)
        {
            visible = animation_data.time mod 4 < 2;
        }
        else
        {
            visible = true;
        }
        if (not (animation_data.index == SHIELD.FIRE and animation_data.variant == 1))
        {
            image_xscale = (shield_advance ? 1 : other.image_xscale);
        }
        image_angle = other.gravity_direction;
        image_alpha = (shield_advance and flicker_config == CONFIG_FLICKER.OFF ? 0.8 : 1);
    }
    else if (not is_undefined(animation_data.ani))
    {
        animation_set(undefined);
    }
}

#endregion

// Direct camera
with (camera)
{
    x = other.x div 1;
    y = other.y div 1;
    gravity_direction = other.gravity_direction;
    
    // Center
    if (y_scroll != 0)
	{
		var action = other.state;
		if ((action != player_is_looking and action != player_is_crouching) or other.camera_look_time > 0)
		{
			y_scroll -= 2 * sign(y_scroll);
		}
	}
}