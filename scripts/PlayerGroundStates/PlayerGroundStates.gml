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

function player_is_standing(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			break;
		}
		case PHASE.STEP:
		{
			// Jump
			if (input_check_pressed(INPUT.ACTION)) return player_perform(player_is_jumping);
			
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
			if ((input_check(INPUT.LEFT) xor input_check(INPUT.RIGHT)) or x_speed != 0)
			{
				return player_perform(player_is_running);
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

function player_is_running(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			break;
		}
		case PHASE.STEP:
		{
			// Jump
			if (input_check_pressed(INPUT.ACTION)) return player_perform(player_is_jumping);
			
			// Handle ground motion
			var input_sign = input_check(INPUT.RIGHT) - input_check(INPUT.LEFT);
			if (input_sign != 0)
			{
				if (control_lock_time == 0)
				{
					// Decelerate
					if (x_speed != 0 and sign(x_speed) != input_sign)
					{
						x_speed += deceleration * input_sign;
						if (sign(x_speed) == input_sign) x_speed = deceleration * input_sign; // Reverse direction
					}
					else
					{
						// Accelerate
						image_xscale = input_sign;
						if (abs(x_speed) < speed_cap)
						{
							x_speed = min(abs(x_speed) + acceleration, speed_cap) * input_sign;
						}
					}
				}
			}
			else
			{
				// Friction (same value as acceleration)
				x_speed -= min(abs(x_speed), acceleration) * sign(x_speed);
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
			
			// Stand
			if (x_speed == 0 and input_sign == 0) return player_perform(player_is_standing);
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}