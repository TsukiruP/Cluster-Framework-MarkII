/// @function player_is_falling(phase)
function player_is_falling(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Rise
			y_speed = -dsin(local_direction) * x_speed;
			x_speed *= dcos(local_direction);
			
			// Detach from ground
			player_ground(undefined);
            
            // Animate
			animation_init(PLAYER_ANIMATION.FALL, 0, false, [PLAYER_ANIMATION.ROLL]);
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
			
			// Apply air resistance
			if (y_speed < 0 and y_speed > -4 and abs(x_speed) > air_drag_threshold)
			{
				x_speed *= air_drag;
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

/// @function player_is_jumping(phase)
function player_is_jumping(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Set flags
			jump_action = true;
			jump_cap = true;
            
			// Leap
			var sine = dsin(local_direction);
			var cosine = dcos(local_direction);
			y_speed = -sine * x_speed - cosine * jump_height;
			x_speed = cosine * x_speed - sine * jump_height;
			
			// Detach from ground
			player_ground(undefined);
			
			// Animate
			animation_init(PLAYER_ANIMATION.JUMP, 0);
			
			// Sound
			sound_play(sfxJump);
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
			
			// Lower height
			if (jump_cap and not input_button.jump.check and y_speed < -jump_release)
			{
				y_speed = -jump_release;
			}
			
			// Apply air resistance
			if (y_speed < 0 and y_speed > -4 and abs(x_speed) > air_drag_threshold)
			{
				x_speed *= air_drag;
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

/// @function player_is_hurt(phase)
function player_is_hurt(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			break;
		}
		case PHASE.STEP:
		{
			break;
		}
		case PHASE.EXIT:
		{
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
			break;
		}
		case PHASE.STEP:
		{
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}