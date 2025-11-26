/// @function player_calc_ground_normal(x, y, rot)
/// @description Calculates the surface normal of the 16x16 solid chunk found at the given point.
/// @param {Real} x x-coordinate of the point.
/// @param {Real} y y-coordinate of the point.
/// @param {Real} rot Rotation of the point in multiples of 90 degrees.
/// @returns {Real}
function player_calc_ground_normal(ox, oy, rot)
{
	// Setup angle sensors
	var sensor_x = array_create(2, ox);
	var sensor_y = array_create(2, oy);
	var sine = dsin(rot);
	var cosine = dcos(rot);
	
	if (rot mod 180 != 0)
	{
		var right = (rot == 90);
		sensor_y[right] = oy div 16 * 16;
		sensor_y[not right] = sensor_y[right] + 15;
	}
	else
	{
		var up = (rot == 180);
		sensor_x[up] = ox div 16 * 16;
		sensor_x[not up] = sensor_x[up] + 15;
	}
	
	// Extend / regress angle sensors
	for (var n = 0; n < 2; ++n)
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

/// @function player_detect_entities()
/// @description Finds any instances intersecting a minimum bounding rectangle centered on the player, executes their reaction, and registers their solidity.
/// It also refreshes the player's local tilemaps by (de)listing the semisolid layer if applicable.
function player_detect_entities()
{
	// Reset instances
    ground_id = noone;
    ceiling_id = noone;
    
    // Setup bounding rectangle
	var x_int = x div 1;
	var y_int = y div 1;
	var xdia = x_wall_radius + 0.5;
	var ydia = y_radius + y_tile_reach + 0.5;
	
	/* AUTHOR NOTE: the size of the bounding rectangle must be coordinated with the distances used for collision checking.
	Wall collisions check for a distance of `x_wall_radius`, so this is the rectangle's width.
	Floor collisions check for a distance of `y_tile_reach + y_radius`, so this is the rectangle's height.
	The additional 0.5 pixels is there to address a quirk with GameMaker's collision functions where, with the exception of
	`collision_line` and `collision_point`, the colliding shapes must intersect by at least 0.5 pixels for a collision to be registered. */
	
    with (objStageObject) reaction(other);
    
	// Evaluate semisolid tilemap collision
    if (semisolid_tilemap != -1)
    {
   	    var valid = array_contains(tilemaps, semisolid_tilemap);
   	    if (not player_beam_collision(semisolid_tilemap))
   	    { 
            if (not valid) array_push(tilemaps, semisolid_tilemap);
   	    }
   	    else if (valid) array_pop(tilemaps);
    }
}