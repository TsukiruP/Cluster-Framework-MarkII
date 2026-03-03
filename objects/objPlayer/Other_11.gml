/// @description Collision

/// @method player_intersect
/// @description Checks if the given collider's mask intersects the player's virtual mask.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement|Array} ind Object, instance, or tilemap to check, or an array containing any of these.
/// @returns {Bool}
player_intersect = function (ind)
{
	var x_int = x div 1;
	var y_int = y div 1;
	
	return mask_direction mod 180 == 0 ?
		collision_rectangle(x_int - x_radius, y_int - y_radius, x_int + x_radius, y_int + y_radius, ind, true, false) != noone :
		collision_rectangle(x_int - y_radius, y_int - x_radius, x_int + y_radius, y_int + x_radius, ind, true, false) != noone;
};

/// @method player_boxcast
/// @description Checks if the given collider's mask intersects a vertical portion of the player's virtual mask.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement|Array} ind Object, instance, or tilemap to check, or an array containing any of these.
/// @param {Real} ylen Distance to extend the player's mask vertically.
/// @returns {Bool}
player_boxcast = function (ind, ylen)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	var x1 = x_int - cosine * x_radius;
	var y1 = y_int + sine * x_radius;
	var x2 = x_int + cosine * x_radius + sine * ylen;
	var y2 = y_int - sine * x_radius + cosine * ylen;
	
	// Account for outer edge overlap bug (see: https://github.com/YoYoGames/GameMaker-Bugs/issues/14176)
	var left = min(x1, x2);
	var top = min(y1, y2);
	var right = max(x1, x2) + 0.001;
	var bottom = max(y1, y2) + 0.001;
	
	return collision_rectangle(left, top, right, bottom, ind, true, false) != noone;
};

/// @method player_linecast
/// @description Checks if the given collider's mask intersects the 'arms' of the player's virtual mask.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement|Array} ind Object, instance, or tilemap to check, or an array containing any of these.
/// @param {Real} [xrad] Distance to extend the player's mask horizontally both ways (optional, default is the player's wall radius).
/// @returns {Bool}
player_linecast = function (ind, xrad = x_wall_radius)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	var x1 = x_int - cosine * xrad;
	var y1 = y_int + sine * xrad;
	var x2 = x_int + cosine * xrad;
	var y2 = y_int - sine * xrad;
	
	return collision_line(x1, y1, x2, y2, ind, true, false) != noone;
};

/// @method player_raycast
/// @description Checks if the given collider's mask intersects a line from the player.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement|Array} ind Object, instance, or tilemap to check, or an array containing any of these.
/// @param {Real} xoff Distance to offset the line horizontally.
/// @param {Real} ylen Distance to extend the line vertically.
/// @returns {Bool}
player_raycast = function (ind, xoff, ylen)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	var x1 = x_int + cosine * xoff;
	var y1 = y_int - sine * xoff;
	var x2 = x_int + cosine * xoff + sine * ylen;
	var y2 = y_int - sine * xoff + cosine * ylen;
	
	return collision_line(x1, y1, x2, y2, ind, true, false) != noone;
};

/// @method player_calc_tile_normal
/// @description Calculates the surface normal of the tiles found within the 16x16 area relative to the given point.
/// @param {Real} x x-coordinate of the point.
/// @param {Real} y y-coordinate of the point.
/// @returns {Real}
player_calc_tile_normal = function (ox, oy)
{
	// Set up angle sensors
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	if (sine == 0)
	{
		var sensor_y = array_create(2, oy);
		var sensor_x = array_create(2, ox - ox mod 16);
		sensor_x[mask_direction == 0] += 15;
	}
	else
	{
		var sensor_x = array_create(2, ox);
		var sensor_y = array_create(2, oy - oy mod 16);
		sensor_y[mask_direction == 270] += 15;
	}
	
	// Cache tilemap id to prevent unnecessary iteration through colliders
	var ind = collision_point(ox + sine, oy + cosine, hard_colliders, true, false);
	
	// Extend / regress angle sensors
	for (var n = 0; n < 2; ++n)
	{
		repeat (y_tile_reach)
		{
			if (collision_point(sensor_x[n], sensor_y[n], ind, true, false) == noone)
			{
				sensor_x[n] += sine;
				sensor_y[n] += cosine;
			}
			else if (collision_point(sensor_x[n] - sine, sensor_y[n] - cosine, ind, true, false) != noone)
			{
				sensor_x[n] -= sine;
				sensor_y[n] -= cosine;
			}
			else break;
		}
	}
	
	return point_direction(sensor_x[0], sensor_y[0], sensor_x[1], sensor_y[1]) div 1;
};