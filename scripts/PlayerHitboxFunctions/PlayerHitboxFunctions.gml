/// @function player_in_hitbox(obj, ohb, phb)
/// @description Checks if the given object's hitbox intersects the player's given hitbox.
/// @param {Id.Instance} obj Object to check.
/// @param {Struct.rect} ohb Hitbox of the object.
/// @param {Struct.rect} phb Hitbox of the player.
/// @returns {Bool}
function player_in_hitbox(obj, ohb, phb)
{
    var x_int = x div 1;
    var y_int = y div 1;
    var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	var ox_int = obj.x div 1;
	var oy_int = obj.y div 1;
	var osine = dsin(obj.gravity_direction);
	var ocosine = dcos(obj.gravity_direction);
	
	var left = phb.left_radius; // Negative
	var top = phb.top_radius; // Negative
	var right = phb.right_radius;
	var bottom = phb.bottom_radius;
	
	if (image_xscale == -1)
	{
	    left *= -1;
	    right *= -1;
	}
	
	var oleft = ohb.left_radius;
	var otop = ohb.top_radius;
	var oright = ohb.right_radius;
	var obottom = ohb.bottom_radius;
	
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

/// @function player_radii_in_hitbox(obj, ohb)
/// @description Checks if the given object's hitbox intersects the player's virtual mask.
/// @param {Id.Instance} obj Object to check.
/// @param {Struct.rect} ohb Hitbox of the object.
/// @returns {Bool}
function player_radii_in_hitbox(obj, ohb)
{
    var x_int = x div 1;
    var y_int = y div 1;
    var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	
	var ox_int = obj.x div 1;
	var oy_int = obj.y div 1;
	var osine = dsin(obj.gravity_direction);
	var ocosine = dcos(obj.gravity_direction);
	
	var left = -x_radius; // Negative
	var top = -y_radius; // Negative
	var right = x_radius;
	var bottom = y_radius;
	
	if (image_xscale == -1)
	{
	    left *= -1;
	    right *= -1;
	}
	
	var oleft = ohb.left_radius;
	var otop = ohb.top_radius;
	var oright = ohb.right_radius;
	var obottom = ohb.bottom_radius;
	
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