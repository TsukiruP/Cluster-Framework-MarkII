/// @function rect([left], [top], [right], [bottom])
/// @description Creates a rectangle with arguments assuming (0, 0) origin.
/// @param {Real} left Left radius of the rectangle.
/// @param {Real} top Top radius of the rectangle.
/// @param {Real} right Right radius of the rectangle.
/// @param {Real} bottom Bottom radius of the rectangle.
function rect(_left = 0, _top = 0, _right = 0, _bottom = 0) constructor
{
	left = _left;
	top = _top;
	right = _right;
	bottom = _bottom;
    static set_size = function(_left = 0, _top = 0, _right = 0, _bottom = 0)
    {
        left = _left;
        top = _top;
        right = _right;
        bottom = _bottom;
    }
}

/// @function hitbox(col, [left], [top], [right], [bottom])
/// @description Creates a hitbox.
/// @param {Constant.Colour} col Color of the hitbox.
/// @param {Real} left Left radius of the hitbox.
/// @param {Real} top Top radius of the hitbox.
/// @param {Real} right Right radius of the hitbox.
/// @param {Real} bottom Bottom radius of the hitbox.
function hitbox(col, _left = 0, _top = 0, _right = 0, _bottom = 0) : rect(_left, _top, _right, _bottom) constructor
{
	color = col;
}

/// @function esign(val, def)
/// @description Returns the sign of the value, or the default if the value is 0. Ported from GM8.2.
/// @param {Real} val Value to get the sign of.
/// @param {Real} def Default value to give if the value is 0.
/// @returns {Real}
function esign(val, def)
{
	if (val == 0) return def;
	else return sign(val);
}

/// @function wrap(val, minimum, maximum)
/// @description Wraps the given value between the minimum and maximum inclusively.
/// @param {Real} val Value to wrap.
/// @param {Real} maximum Maximum value.
/// @param {Real} minimum Minimum value.
/// @returns {Real}
function wrap(val, minimum, maximum)
{
    if (val < minimum) return maximum;
    else if (val > maximum) return minimum;
    else return val;
}

/// @function angle_wrap(ang)
/// @description Wraps the given angle between 0 and 359 degrees inclusively.
/// @param {Real} ang Angle to wrap.
/// @returns {Real}
function angle_wrap(ang)
{
	return (ang mod 360 + 360) mod 360;
}

/// @function rotate_towards(dest, src, [amt])
/// @description Rotates the source angle to the destination angle.
/// @param {Real} dest Destination angle.
/// @param {Real} src Source angle.
/// @param {Real} amt The maximum amount to straighten by.
/// @returns {Real}
function rotate_towards(dest, src, amt = 2.8125)
{
	if (src != dest)
	{
		var diff = angle_difference(dest, src);
		return src + min(amt, abs(diff)) * sign(diff);
	}
    return src;
}

/// @function instance_in_view([obj], [padding])
/// @description Checks if the given instance is visible within the game view.
/// @param {Asset.GMObject|Id.Instance} [obj] Object or instance to check (optional, default is the calling instance).
/// @param {Real} [padding] Distance in pixels to extend the size of the view when checking (optional, default is the CAMERA_PADDING macro).
/// @returns {Bool}
function instance_in_view(obj = id, padding = CAMERA_PADDING)
{
	var left = global.main_camera.get_x();
	var top = global.main_camera.get_y();
	var right = left + CAMERA_WIDTH;
	var bottom = top + CAMERA_HEIGHT;
	
	with (obj) return point_in_rectangle(x, y, left - padding, top - padding, right + padding, bottom + padding);
}

/// @function collision_player(hb, pla, [plahb])
/// @description Checks if the given player is intersecting the given hitbox.
/// @param {Real} hb Hitbox to check.
/// @param {Id.Instance} pla Player to check.
/// @param {Real} plahb Player hitbox to check (optional, defaults to virtual mask).
/// @returns {Real}
function collision_player(hb, pla, plahb = -1)
{
    var x_int = x div 1;
    var y_int = y div 1;
    var sine = dsin(gravity_direction);
    var cosine = dcos(gravity_direction);
    
    var left = hitboxes[hb].left;
    var top = hitboxes[hb].top;
    var right = hitboxes[hb].right;
    var bottom = hitboxes[hb].bottom;
    
    // Abort if hitbox is empty
    if (left == 0 and top == 0 and right == 0 and bottom == 0) return 0;
    
    if (image_xscale == -1)
    {
    	left *= -1;
    	right *= -1;
    }
    
    if (image_yscale == -1)
    {
        top *= -1;
        bottom *= -1;
    }
    
    var px_int = pla.x div 1;
    var py_int = pla.y div 1;
    var psine = dsin(pla.mask_direction);
    var pcosine = dcos(pla.mask_direction);
    
    var pleft = -pla.x_radius;
    var ptop = -pla.y_radius;
    var pright = pla.y_radius;
    var pbottom = pla.y_radius;
    
    if (plahb > -1)
    {
    	pleft = pla.hitboxes[plahb].left;
    	ptop = pla.hitboxes[plahb].top;
    	pright = pla.hitboxes[plahb].right;
    	pbottom = pla.hitboxes[plahb].bottom;
    	
    	if (pla.image_xscale == -1)
    	{
    		pleft *= -1;
    		pright *= -1;
    	}
    	
        if (pla.image_yscale == -1)
    	{
    		ptop *= -1;
    		pbottom *= -1;
    	}
    }
	
    // Abort if hitbox is empty
    if (pleft == 0 and ptop == 0 and pright == 0 and pbottom == 0) return 0;
    
	var sx1 = px_int + pcosine * pleft + psine * ptop;
	var sy1 = py_int - psine * pright + pcosine * ptop;
	var sx2 = px_int + pcosine * pright + psine * pbottom;
	var sy2 = py_int - psine * pleft + pcosine * pbottom;
	
	var dx1 = x_int + cosine * left + sine * top;
	var dy1 = y_int - sine * right + cosine * top;
	var dx2 = x_int + cosine * right + sine * bottom;
	var dy2 = y_int - sine * left + cosine * bottom;
	
	return rectangle_in_rectangle(sx1, sy1, sx2, sy2, dx1, dy1, dx2, dy2);
}

/// @function particle_create(x, y, ani, [xspd], [yspd], [xaccel], [yaccel])
/// @description Creates a particle with the given animation.
/// @param {Real} x x-coordinate of the particle.
/// @param {Real} y y-coordinate of the particle.
/// @param {Struct.animation} ani animation of the particle.
/// @param {Real} [xspd] x-speed of the particle.
/// @param {Real} [yspd] y-speed of the effect.
/// @param {Real} [xaccel] x-acceleration of the particle.
/// @param {Real} [yaccel] y-acceleration of the particle.
/// @returns {Id.Instance}
function particle_create(ox, oy, ani, xspd = 0, yspd = 0, xaccel = 0, yaccel = 0)
{
    var particle = instance_create_depth(ox, oy, layer_get_depth("StageObjects") - DEPTH_OFFSET_PARTICLE, objParticle);
    with (particle)
    {
        animation_set(ani);
        x_speed = xspd;
        y_speed = yspd;
        x_acceleration = xaccel;
        y_acceleration = yaccel;
    }
    return particle;
}

/// @function draw_hitboxes([ang])
/// @description Draws all hitboxes.
/// @param {Real} [ang] Angle to draw the hitboxes. (optional, default is gravity_direction).
function draw_hitboxes(ang = gravity_direction)
{
	var x_int = x div 1;
	var y_int = y div 1;
	
	for (var i = 0; i < array_length(hitboxes); i++)
	{
		var left = hitboxes[i].left;
		var top = hitboxes[i].top;
		var right = hitboxes[i].right;
		var bottom = hitboxes[i].bottom;
		
		if (not (left == 0 and top == 0 and right == 0 and bottom == 0))
		{
			var sine = dsin(ang);
        	var cosine = dcos(ang);
        	var color = hitboxes[i].color;
        	
			if (image_xscale == -1)
			{
				left *= -1;
				right *= -1;
			}
			
            if (image_yscale == -1)
            {
                top *= -1;
                bottom *= -1;
            }
			
			var x1 = x_int + cosine * left + sine * top;
	        var y1 = y_int - sine * right + cosine * top;
	        var x2 = x_int + cosine * right + sine * bottom;
	        var y2 = y_int - sine * left + cosine * bottom;
	        
	        draw_rectangle_color(x1, y1, x2, y2, color, color, color, color, true);
		}
	}
}

/// @function draw_reset()
/// @description Resets draw color, alpha, and text alignment. Ported from GM8.2.
function draw_reset()
{
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}