/// @function rect(left, top, right, bottom)
/// @description Creates a rectangle with arguments assuming (0, 0) origin.
/// @param {Real} left Left side of the rectangle.
/// @param {Real} top Top side of the rectangle.
/// @param {Real} right Right side of the rectangle.
/// @param {Real} bottom Bottom side of the rectangle.
function rect(left, top, right, bottom) constructor
{
	left_radius = left;
	top_radius = top;
	right_radius = right;
	bottom_radius = bottom;
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
    var particle = instance_create_depth(ox, oy, DEPTH_PARTICLE, objParticle);
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

/// @function draw_reset()
/// @description Resets draw color, alpha, and text alignment. Ported from GM8.2.
function draw_reset()
{
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}