/// @description Movement

/// @method player_move_on_ground
/// @description Updates the player's position on the ground and checks for collisions.
player_move_on_ground = function ()
{
	// Ride moving platforms
	with (ground_id)
	{
		var dx = x - xprevious;
		var dy = y - yprevious;
		if (dx != 0) other.x += dx;
		if (dy != 0) other.y += dy;
	}
	
	// Calculate movement steps
	var total_steps = 1 + abs(x_speed) div 13;
	var step = x_speed / total_steps;
	
	var floor_reach = y_radius + min(2 + abs(x_speed) div 1, y_tile_reach);
	
	repeat (total_steps)
	{
		x += dcos(direction) * step;
		y -= dsin(direction) * step;
		
		// Detect walls
		if (player_linecast(hard_colliders) and sign(x_speed) == player_escape_wall())
		{
			x_speed = 0;
		}
		
		// Detect floor
		if (player_boxcast(hard_colliders, floor_reach))
		{
			player_ground(true);
			player_rotate_mask();
		}
		else on_ground = false;
		
		// Abort if stopped or airborne
		if (x_speed == 0 or not on_ground) break;
	}
};

/// @method player_move_in_air
/// @description Updates the player's position in the air and checks for collisions.
player_move_in_air = function ()
{
	// Calculate movement steps
	var total_steps = 1 + abs(x_speed) div 13 + abs(y_speed) div 13;
	var x_step = x_speed / total_steps;
	var y_step = y_speed / total_steps;
	
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	repeat (total_steps)
	{
		x += cosine * x_step + sine * y_step;
		y += -sine * x_step + cosine * y_step;
		
		// Detect walls
		if (player_linecast(hard_colliders) and sign(x_speed) == player_escape_wall())
		{
			x_speed = 0;
		}
		
		// Detect floors / ceilings
		if (y_speed >= 0)
		{
			if (player_boxcast(hard_colliders, y_radius))
			{
				landed = true;
				player_ground(true);
				player_rotate_mask();
			}
		}
		else if (player_boxcast(hard_colliders, -y_radius))
		{
			// Flip mask and land on the ceiling
			mask_direction = (mask_direction + 180) mod 360;
			landed = true;
			player_ground(true);
			
			// Abort if rising slowly or the ceiling is too shallow
			if (y_speed > -4 or (local_direction >= 135 and local_direction <= 225))
			{
				// Slide against it
				sine = dsin(local_direction);
				cosine = dcos(local_direction);
				var g_speed = cosine * x_speed - sine * y_speed;
				x_speed = cosine * g_speed;
				y_speed = -sine * g_speed;
				
				// Revert mask rotation and abort
				mask_direction = gravity_direction;
				landed = false;
				break;
			}
		}
		
		// Land
		if (landed)
		{
			// Stay flat on solid objects
			if (ground_id != noone)
			{
				direction = gravity_direction;
				local_direction = 0;
			}
			
			// Calculate new horizontal speed
			if (abs(x_speed) <= abs(y_speed) and local_direction >= 22.5 and local_direction <= 337.5)
			{
				x_speed = -y_speed * sign(dsin(local_direction));
				if (local_direction < 45 or local_direction > 315) x_speed *= 0.5;
			}
			
			// Stop falling, and abort
			y_speed = 0;
			landed = false;
			on_ground = true;
			if (rolling) rolling = false;
			break;
		}
	}
};