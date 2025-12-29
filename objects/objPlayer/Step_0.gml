/// @description Behave
if (ctrlGame.game_paused) exit;

#region Input

if (player_index == 0 or cpu_gamepad_time > 0)
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
			        --cpu_state_time;
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
					--cpu_state_time;
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

#region Camera

var sine = dsin(gravity_direction);
var cosine = dcos(gravity_direction);

#region Offset

var ox = 0;
var oy = 0;

if (mask_direction == gravity_direction and abs(x_speed) > 6)
{
    if (camera_offset_x != 64 * sign(x_speed)) camera_offset_x += 2 * sign(x_speed);
}
else if (camera_offset_x != 0)
{
    camera_offset_x -= 2 * sign(camera_offset_x);
}

if (camera_offset_y != 0 and ((state != player_is_looking and state != player_is_crouching) or camera_look_time > 0))
{
    camera_offset_y -= 2 * sign(camera_offset_y);
}

ox += cosine * camera_offset_x + sine * camera_offset_y;
oy += -sine * camera_offset_x + cosine * camera_offset_y;

#endregion

#region Padding

var px = 0;
var py = 0;

camera_padding_y = PLAYER_HEIGHT - y_radius;

px += (gravity_direction mod 180 == 0) * camera_padding_x + (gravity_direction mod 180 != 0) * camera_padding_y;
py += (gravity_direction mod 180 == 0) * camera_padding_y + (gravity_direction mod 180 != 0) * camera_padding_x;

#endregion

with (camera)
{
    offset(ox, oy);
    padding(px, py);
    center(false, other.on_ground);
    spd_max_y = (other.x_speed >= 8 or not other.on_ground ? 24 : 6);
    
    if (other.state != player_is_dead)
    {
        if (follow != other)
        {
            move(other.x, other.y);
            follow = other;
        }
    }
    else if (follow == other)
    {
        follow = noone;
    }
}

#endregion