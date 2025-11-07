/// @function player_collision(obj)
/// @description Checks if the given entity's mask intersects the player's virtual mask.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @returns {Bool}
function player_collision(obj)
{
	var x_int = x div 1;
	var y_int = y div 1;
	
	return (mask_direction mod 180 != 0 ?
		collision_rectangle(x_int - y_radius, y_int - x_radius, x_int + y_radius, y_int + x_radius, obj, true, false) != noone :
		collision_rectangle(x_int - x_radius, y_int - y_radius, x_int + x_radius, y_int + y_radius, obj, true, false) != noone);
}

/// @function player_part_collision(obj, yrad)
/// @description Checks if the given entity's mask intersects a vertical portion of the player's virtual mask.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @param {Real} yrad Distance in pixels to extend the player's mask vertically.
/// @returns {Bool}
function player_part_collision(obj, yrad)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	var x1 = x_int - cosine * x_radius;
	var y1 = y_int + sine * x_radius;
	var x2 = x_int + cosine * x_radius + sine * yrad;
	var y2 = y_int - sine * x_radius + cosine * yrad;
	
	return collision_rectangle(x1, y1, x2, y2, obj, true, false) != noone;
}

/// @function player_ray_collision(obj, [xdia], [yoff])
/// @description Checks if the given entity's mask intersects a line from the player's position.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @param {Real} [xdia] Distance in pixels to extend the line horizontally on both ends (optional, default is the player's wall radius).
/// @param {Real} [yoff] Distance in pixels to offset the line vertically (optional, default is 0).
/// @returns {Bool}
function player_ray_collision(obj, xdia = x_wall_radius, yoff = 0)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	var x1 = x_int - cosine * xdia + sine * yoff;
	var y1 = y_int + sine * xdia + cosine * yoff;
	var x2 = x_int + cosine * xdia + sine * yoff;
	var y2 = y_int - sine * xdia + cosine * yoff;
	
	return collision_line(x1, y1, x2, y2, obj, true, false) != noone;
}

/// @function player_beam_collision(obj, xoff, yrad)
/// @description Checks if the given entity's mask intersects a line from the player's position.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap element to check.
/// @param {Real} xoff Distance in pixels to offset the line horizontally.
/// @param {Real} yrad Distance in pixels to extend the line downward.
/// @returns {Bool}
function player_beam_collision(obj, xoff, yrad)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	var x1 = x_int + cosine * xoff;
	var y1 = y_int - sine * xoff;
	var x2 = x_int + cosine * xoff + sine * yrad;
	var y2 = y_int - sine * xoff + cosine * yrad;
	
	return collision_line(x1, y1, x2, y2, obj, true, false) != noone;
}

/// @function player_in_hitbox(obj, objhb, pla, [plahb])
/// @description Checks if the given object's hitbox intersects the player's given hitbox.
/// @param {Id.Instance} obj Object to check.
/// @param {Real} objhb Index of the object's hitbox.
/// @param {Id.Instance} pla Player to check.
/// @param {Real} [plahb] Index of the player's hitbox. (optional, defaults to the player's virtual mask).
/// @returns {Bool}
function player_in_hitbox(obj, objhb, pla, plahb = -1)
{
    var x_int = pla.x div 1;
    var y_int = pla.y div 1;
    var sine = dsin(pla.mask_direction);
	var cosine = dcos(pla.mask_direction);
	
	var ox_int = obj.x div 1;
	var oy_int = obj.y div 1;
	var osine = dsin(obj.gravity_direction);
	var ocosine = dcos(obj.gravity_direction);
	
	var left = -pla.x_radius;
    var top = -pla.y_radius;
    var right = pla.x_radius;
    var bottom = pla.y_radius;
    
    if (plahb > -1)
    {
        left = pla.hitboxes[plahb].left;
        top = pla.hitboxes[plahb].top;
        right = pla.hitboxes[plahb].right;
        bottom = pla.hitboxes[plahb].bottom;
        
        if (pla.image_xscale == -1)
        {
            left *= -1;
            right *= -1;
        }
    }
	
	var oleft = obj.hitboxes[objhb].left;
	var otop = obj.hitboxes[objhb].top;
	var oright = obj.hitboxes[objhb].right;
	var obottom = obj.hitboxes[objhb].bottom;
	
	if (obj.image_xscale == -1)
	{
	    oleft *= -1;
	    oright *= -1;
	}
	
	var sx1 = x_int + cosine * left + sine * top;
	var sy1 = y_int - sine * right + cosine * top;
	var sx2 = x_int + cosine * right + sine * bottom;
	var sy2 = y_int - sine * left + cosine * bottom;
	
	var dx1 = ox_int + ocosine * oleft + sine * otop;
	var dy1 = oy_int - osine * oright + cosine * otop;
	var dx2 = ox_int + ocosine * oright + sine * obottom;
	var dy2 = oy_int - osine * oleft + cosine * obottom;
	
	return (rectangle_in_rectangle(sx1, sy1, sx2, sy2, dx1, dy1, dx2, dy2) != 0);
}