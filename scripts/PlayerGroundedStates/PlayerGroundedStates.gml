/// @function player_is_ready(phase)
function player_is_ready(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			break;
		}
		case PHASE.STEP:
		{
			player_perform(player_is_standing);
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_standing(phase)
function player_is_standing(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Check if standing on a cliff
			cliff_sign = 0;
			var height = y_radius + y_tile_reach;
			
			if (not player_ray_collision(tilemaps, 0, height))
			{
				cliff_sign = player_ray_collision(tilemaps, -x_radius, height) - player_ray_collision(tilemaps, x_radius, height);
			}
			
			// Animate
            var ani_idle = (cliff_sign != 0 ? PLAYER_ANIMATION.TEETER : PLAYER_ANIMATION.IDLE);
            animation_init(ani_idle, 0, [PLAYER_ANIMATION.TURN]);
			break;
		}
		case PHASE.STEP:
		{
			// Jump
			if (player_try_jump()) return true;
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;
			
			// Fall
			if (not on_ground or (local_direction >= 90 and local_direction <= 270))
			{
				return player_perform(player_is_falling);
			}
			
			// Slide down steep slopes
			if (local_direction >= 45 and local_direction <= 315)
			{
				control_lock_time = slide_duration;
				return player_perform(player_is_running);
			}
			
			// Turn
            if (animation_data.index != PLAYER_ANIMATION.TEETER and input_axis_x != 0 and image_xscale != input_axis_x)
            {
                animation_init(PLAYER_ANIMATION.TURN);
                image_xscale *= -1;
            }
            
            if (animation_data.index == PLAYER_ANIMATION.TURN and animation_is_finished())
            {
            	animation_init(PLAYER_ANIMATION.IDLE);
            }
            
            if (animation_data.index != PLAYER_ANIMATION.TURN)
            {
                // Run
                if (x_speed != 0 or input_axis_x != 0)
                {
                    return player_perform(player_is_running);
                }
                
                // Look / crouch
                if (cliff_sign == 0)
                {
                    if (input_axis_y == -1) return player_perform(player_is_looking);
                    if (input_axis_y == 1) return player_perform(player_is_crouching);
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

/// @function player_is_running(phase)
function player_is_running(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Animate
            animation_init(PLAYER_ANIMATION.RUN);
            break;
		}
		case PHASE.STEP:
		{
			// Jump
			if (player_try_jump()) return true;
			
			// Handle ground motion
			var can_brake = false;
            var can_turn = false;
			
			if (control_lock_time == 0)
			{
				if (input_axis_x != 0)
				{
					// If moving in the opposite direction...
					if (x_speed != 0 and sign(x_speed) != input_axis_x)
					{
						// Decelerate and reverse direction
						can_brake = true;
						x_speed += deceleration * input_axis_x;
                        if (sign(x_speed) == input_axis_x)
                        {
                            // Turn
                            if (image_xscale != input_axis_x) can_turn = true;
                            x_speed = deceleration * input_axis_x;
                        }
					}
					else
					{
						// Accelerate
						can_brake = false;
						image_xscale = input_axis_x;
						if (abs(x_speed) < speed_cap)
						{
							x_speed = min(abs(x_speed) + acceleration, speed_cap) * input_axis_x;
						}
					}
				}
				else
				{
					// Friction
					x_speed -= min(abs(x_speed), friction) * sign(x_speed);
				}
			}
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;
			
			// Fall
			if (not on_ground) return player_perform(player_is_falling);
			
			// Slide down steep slopes
			if (abs(x_speed) < slide_threshold)
			{
				if (local_direction >= 90 and local_direction <= 270)
				{
					return player_perform(player_is_falling);
				}
				else if (local_direction >= 45 and local_direction <= 315)
				{
					control_lock_time = slide_duration;
				}
			}
			
			// Apply slope friction
			player_resist_slope(0.125);
			
			// Roll
			if (abs(x_speed) >= 1.03125 and input_axis_x == 0 and input_axis_y == 1)
			{
				audio_play_single(sfxRoll);
				return player_perform(player_is_rolling);
			}
			
			// Stand
			if (x_speed == 0 and input_axis_x == 0) return player_perform(player_is_standing);
			
			// Animate
            if (can_turn)
            {
                x_speed = 0;
                animation_init(PLAYER_ANIMATION.TURN, animation_data.index == PLAYER_ANIMATION.BRAKE);
                image_xscale *= -1;
                return player_perform(player_is_standing);
            }
			else if (can_brake)
			{
				if (animation_data.index != PLAYER_ANIMATION.BRAKE)
				{
					if (mask_direction == gravity_direction and abs(x_speed) >= 4)
					{
						animation_init(PLAYER_ANIMATION.BRAKE, abs(x_speed) > 9.0);
						audio_play_single(sfxBrake);
					}
				}
				else if (ctrlWindow.image_index mod 4 == 0)
				{
                    // Create brake dust
					var ox = x + dsin(direction) * y_radius;
					var oy = y + dcos(direction) * y_radius;
					particle_create(ox, oy, global.ani_brake_dust_v0);
				}
			}
			else
			{
				animation_init(PLAYER_ANIMATION.RUN);
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_looking(phase)
function player_is_looking(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			camera_look_time = 120;
			animation_init(PLAYER_ANIMATION.LOOK);
			break;
		}
		case PHASE.STEP:
		{
			// Jump
			if (player_try_jump()) return true;
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;
			
			// Fall
			if (not on_ground or (local_direction >= 90 and local_direction <= 270))
			{
				return player_perform(player_is_falling);
			}
			
			// Slide down steep slopes
			if (local_direction >= 45 and local_direction <= 315)
			{
				control_lock_time = slide_duration;
				return player_perform(player_is_running);
			}
			
			// Run
			if (x_speed != 0) return player_perform(player_is_running);
			
			// Stand
            if (animation_data.index == PLAYER_ANIMATION.LOOK and animation_data.variant == 1 and animation_is_finished())
            {
            	return player_perform(player_is_standing);
            }
            
			if (input_axis_x == 0 and input_axis_y == 0)
            {
                if (animation_data.index == PLAYER_ANIMATION.LOOK and animation_data.variant == 0) animation_data.variant = 1;
            }
            else if (input_axis_y != -1)
            {
                return player_perform(player_is_standing);
            }
			
			// Ascend camera
			if (camera_look_time > 0)
			{
				--camera_look_time;
			}
			else
			{
				if (camera_offset_y > -104) camera_offset_y -= 2;
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_crouching(phase)
function player_is_crouching(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			camera_look_time = 120;
            animation_init(PLAYER_ANIMATION.CROUCH);
			break;
		}
		case PHASE.STEP:
		{
			// Spindash
			if (input_button.jump.pressed) return player_perform(player_is_spin_dashing);
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;
			
			// Fall
			if (not on_ground or (local_direction >= 90 and local_direction <= 270))
			{
				return player_perform(player_is_falling);
			}
			
			// Slide down steep slopes
			if (local_direction >= 45 and local_direction <= 315)
			{
				control_lock_time = slide_duration;
				return player_perform(player_is_running);
			}
			
			// Run
			if (x_speed != 0) return player_perform(player_is_running);
			
			// Stand
            if (animation_data.index == PLAYER_ANIMATION.CROUCH and animation_data.variant == 1 and animation_is_finished())
            {
            	return player_perform(player_is_standing);
            }
            
			if (input_axis_x == 0 and input_axis_y == 0)
            {
                if (animation_data.index == PLAYER_ANIMATION.CROUCH and animation_data.variant == 0) animation_data.variant = 1;
            }
            else if (input_axis_y != 1)
            {
                return player_perform(player_is_standing);
            }
			
			// Descend camera
			if (camera_look_time > 0)
			{
				--camera_look_time;
			}
			else
			{
				if (camera_offset_y < 88) camera_offset_y += 2;
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_rolling(phase)
function player_is_rolling(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			animation_init(PLAYER_ANIMATION.ROLL);
			break;
		}
		case PHASE.STEP:
		{
			// Jump
			if (player_try_jump()) return true;
			
			// Decelerate
			if (control_lock_time == 0)
			{
				if (input_axis_x != 0)
				{
					if (sign(x_speed) != input_axis_x)
					{
						x_speed += roll_deceleration * input_axis_x;
						if (sign(x_speed) == input_axis_x) x_speed = roll_deceleration * input_axis_x;
					}
					else image_xscale = input_axis_x;
				}
				
				// Friction
				x_speed -= min(abs(x_speed), roll_friction) * sign(x_speed);
			}
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;
			
			// Fall
			if (not on_ground) return player_perform(player_is_falling);
			
			// Slide down steep slopes
			if (abs(x_speed) < slide_threshold)
			{
				if (local_direction >= 90 and local_direction <= 270)
				{
					return player_perform(player_is_falling);
				}
				else if (local_direction >= 45 and local_direction <= 315)
				{
					control_lock_time = slide_duration;
				}
			}
			
			// Apply slope friction
			var friction_uphill = 0.078125;
			var friction_downhill = 0.3125;
			var slope_friction = (sign(x_speed) == sign(dsin(local_direction)) ? friction_uphill : friction_downhill);
			player_resist_slope(slope_friction);
			
			// Unroll
			if (abs(x_speed) < 0.5) return player_perform(player_is_running);
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_spin_dashing(phase)
function player_is_spin_dashing(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			spin_dash_charge = 0;
            animation_init(PLAYER_ANIMATION.SPIN_DASH);
			audio_play_single(sfxSpinRev);
			break;
		}
		case PHASE.STEP:
		{
			// Move
			player_move_on_ground();
			if (state_changed) exit;
			
			// Fall
			if (not on_ground or (local_direction >= 90 and local_direction <= 270))
			{
				return player_perform(player_is_falling);
			}
			
			// Slide down steep slopes
			if (local_direction >= 45 and local_direction <= 315)
			{
				control_lock_time = slide_duration;
				return player_perform(player_is_rolling);
			}
			
			// Roll
			if (input_axis_y != 1)
			{
				x_speed = image_xscale * (8 + spin_dash_charge div 2);
				with (camera) lag_x = 16;
				audio_stop_sound(sfxSpinRev);
				audio_play_single(sfxSpinDash);
				return player_perform(player_is_rolling);
			}
			
			// Charge / atrophy
			if (input_button.jump.pressed)
			{
				spin_dash_charge = min(spin_dash_charge + 2, 8);
                animation_init(PLAYER_ANIMATION.SPIN_DASH, 1);
                
				// Sound
				var rev_sound = audio_play_single(sfxSpinRev);
				audio_sound_pitch(rev_sound, 1 + spin_dash_charge * 0.0625);
			}
			else spin_dash_charge *= 0.96875;
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}