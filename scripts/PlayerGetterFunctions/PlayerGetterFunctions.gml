/// @function player_detect_entities()
/// @description Executes the reactions of all interactable objects.
/// It also records any solid tilemaps for terrain collision detection.
function player_detect_entities()
{
	// Reset tilemaps
	array_resize(tilemaps, tilemap_count);
	
	// Reset ground instance
    ground_id = noone;
	
	with (objInteractable) reaction(other);
    
	// Evaluate semisolid tilemap collision
    if (semisolid_tilemap != -1 and player_beam_collision(semisolid_tilemap) == noone)
    {
        array_push(tilemaps, semisolid_tilemap);
    }
    
    /* AUTHOR NOTE:
	There is a limitation with the semisolid tilemap detection where, if the player passes through it whilst standing on it,
	they will fall as it will be delisted from their `tilemaps` array. */
}

/// @function player_calc_tile_normal(x, y, rot)
/// @description Calculates the surface normal of the 16x16 solid chunk found at the given point.
/// @param {Real} x x-coordinate of the point.
/// @param {Real} y y-coordinate of the point.
/// @param {Real} rot Direction to extend / regress the angle sensors in multiples of 90 degrees.
/// @returns {Real}
function player_calc_tile_normal(ox, oy, rot)
{
	// Setup angle sensors
	var sine = dsin(rot);
	var cosine = dcos(rot);
	
	if (sine == 0)
	{
		var sensor_y = array_create(2, oy);
		var sensor_x = array_create(2, ox div 16 * 16);
		sensor_x[rot == 0] += 15;
	}
	else
	{
		var sensor_x = array_create(2, ox);
		var sensor_y = array_create(2, oy div 16 * 16);
		sensor_y[rot == 270] += 15;
	}
	
	// Extend / regress angle sensors
	for (var n = 0; n < 2; n++)
	{
		repeat (y_tile_reach)
		{
			if (collision_point(sensor_x[n], sensor_y[n], tilemaps, true, false) == noone)
			{
				sensor_x[n] += sine;
				sensor_y[n] += cosine;
			}
			else if (collision_point(sensor_x[n] - sine, sensor_y[n] - cosine, tilemaps, true, false) != noone)
			{
				sensor_x[n] -= sine;
				sensor_y[n] -= cosine;
			}
			else break;
		}
	}
	
	// Calculate the direction between both angle sensors
	return point_direction(sensor_x[0], sensor_y[0], sensor_x[1], sensor_y[1]) div 1;
}
