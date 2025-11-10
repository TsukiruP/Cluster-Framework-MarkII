/// @function player_is_trick_preparing(phase)
function player_is_trick_preparing(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Stop
			x_speed = 0;
			y_speed = 0;
			
			// Animate
			switch (trick_index)
			{
				case TRICK.UP:
				{
					animation_init(PLAYER_ANIMATION.TRICK_UP);
					break;
				}
				case TRICK.DOWN:
				{
					animation_init(PLAYER_ANIMATION.TRICK_DOWN);
					break;
				}
				case TRICK.FRONT:
				{
					animation_init(PLAYER_ANIMATION.TRICK_FRONT);
					break;
				}
				default:
				{
					animation_init(PLAYER_ANIMATION.TRICK_BACK);
				}
			}
			break;
		}
		case PHASE.STEP:
		{
			// Trick
			if (animation_is_finished())
			{
				if ((object_index == objSonic or object_index == objKnuckles or object_index == objAmy) and trick_index == TRICK.DOWN)
				{
					switch (object_index)
					{
						case objSonic:
						case objAmy:
						{
							y_speed = 2;
							animation_data.variant++;
							return player_perform(player_is_trick_bounding);
						}
						
						case objKnuckles:
						{
							x_speed = image_xscale * trick_speed[trick_index][0];
							y_speed = trick_speed[trick_index][1];
							animation_data.variant++;
							return player_perform(player_is_tricking);
						}
					}
				}
				else
				{
					x_speed = image_xscale * trick_speed[trick_index][0];
					y_speed = trick_speed[trick_index][1];
					animation_data.variant++;
					return player_perform(player_is_tricking);
				}
			}
			
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Land
			if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_tricking(phase)
function player_is_tricking(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			break;
		}
		case PHASE.STEP:
		{
			if (trick_time != 0) trick_time--;
			
			var trick_spiral = (object_index == objKnuckles and trick_index == TRICK.UP);
			var trick_glide = (object_index == objKnuckles and (trick_index == TRICK.FRONT or trick_index == TRICK.BACK) and trick_time > 0);
			
			// Accelerate
			if (not trick_spiral or y_speed > 0)
			{
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
			}
			
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Land
			if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
			
			if (not trick_glide)
			{
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
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_trick_bounding(phase)
function player_is_trick_bounding(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			break;
		}
		case PHASE.STEP:
		{
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Land
			if (on_ground) return player_perform(player_is_trick_rebounding);
			
			// Apply air resistance
			if (y_speed < 0 and y_speed > -4 and abs(x_speed) > air_drag_threshold)
			{
				x_speed *= air_drag;
			}
			
			// Fall
			if (y_speed < gravity_cap)
			{
				y_speed = min(y_speed + trick_bound_force, gravity_cap);
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_trick_rebounding(phase)
function player_is_trick_rebounding(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Rebound
			var sine = dsin(local_direction);
			var cosine = dcos(local_direction);
			y_speed = -cosine * trick_bound_height;
			x_speed = sine * trick_bound_height / 2;
			
			// Detach from ground
			player_ground(undefined);
			break;
		}
		case PHASE.STEP:
		{
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
				y_speed = min(y_speed + trick_bound_force, gravity_cap);
			}
			
			if (y_speed > 0)
			{
				animation_data.variant++;
				return player_perform(player_is_falling, false);
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}