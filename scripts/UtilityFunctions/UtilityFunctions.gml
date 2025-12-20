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

/// @function convert_hex(val)
/// @description Converts an 8-bit signed hex value into a decimal number.
/// @param {Real} val Value to convert.
/// @returns {Real}
function convert_hex(val)
{
    if (val >= 128) val -= 256;
    return val;
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

/// @function pivot_pos_x(px, py, dir)
/// @description Returns the x component of a two-dimenstional lengthdir of a point. Ported from GM 8.2.
/// @param {Real} px x-coordinate of the point.
/// @param {Real} py y-coordinate of the point.
/// @param {Real} dir Direction to rotate by.
/// @returns {Real}
function pivot_pos_x(px, py, dir)
{
    rx = px * dcos(dir);
    ry = py * dcos(dir - 90);
    return rx + ry;
}

/// @function pivot_pos_y(px, py, dir)
/// @description Returns the y component of a two-dimenstional lengthdir of a point. Ported from GM 8.2.
/// @param {Real} px x-coordinate of the point.
/// @param {Real} py y-coordinate of the point.
/// @param {Real} dir Direction to rotate by.
/// @returns {Real}
function pivot_pos_y(px, py, dir)
{
    rx = -px * dsin(dir);
    ry = -py * dsin(dir - 90);
    return rx + ry;
}

/// @function wrap(val, minimum, maximum)
/// @description Wraps the given value between the minimum and maximum inclusively.
/// @param {Real} val Value to wrap.
/// @param {Real} minimum Minimum value.
/// @param {Real} maximum Maximum value.
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
/// @description Rotates the source angle towards the destination angle.
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

/// @function dsecant(ang)
/// @description Returns the secant length of the given angle.
/// @param {Real} ang Angle in degrees.
/// @returns {Real}
function desecant(ang)
{
    return 1 / cos(ang / 180 * pi);
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
    var particle = instance_create_depth(ox, oy, layer_get_depth("Interactables") - DEPTH_OFFSET_PARTICLE, objParticle);
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

/// @function draw_self_floored()
/// @description Draws the instance at a floored position. Ported from GM8.2.
function draw_self_floored()
{
    if (sprite_exists(sprite_index)) draw_sprite_ext(sprite_index, image_index, x div 1, y div 1, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

/// @function draw_sprite_repeat(sprite, subimg, x, y, [hrep], [vrep], [left], [top])
/// @description Repeats the given sprite dtermined by the given hrepeat and vrepeat.
/// @param {Asset.GMSprite} sprite Sprite to draw.
/// @param {Real} subimg Sub-image (frame) of the sprite to draw.
/// @param {Real} x x-coordinate of where to draw the sprite.
/// @param {Real} y y-coordinate of where to draw the sprite.
/// @param {Real} [hrep] Number of horizontal positions (optional, defaults to 0 for infinite reptition).
/// @param {Real} [vrep] Number of vertical positions (optional, defaults to 0 for infinite reptition).
/// @param {Real} [width] Width of the area to draw.
/// @param {Real} [height] Height of the area to draw.
function draw_sprite_repeat(sprite, subimg, dx, dy, hrep = 0, vrep = 0, width = sprite_get_width(sprite), height = sprite_get_height(sprite))
{
    var xscale = 1;
    var yscale = 1;
    var rot = 0;
    var col = c_white;
    var alpha = 1;
    var tw = sprite_get_width(sprite);
    var th = sprite_get_height(sprite);
    
    // Abort if height or width is 0
    if (tw == 0 or th == 0) exit;
    
    var texture = sprite_get_texture(sprite, subimg);
    var u, v;
    gpu_set_texrepeat(true);
    draw_primitive_begin_texture(pr_trianglestrip, texture);
    
    if (hrep > 0 and vrep > 0)
    {
        // Abort if scale is 0
        if (xscale == 0 or yscale == 0) exit;
        
        u = dx;
        v = dy;
        draw_vertex_texture_color(u, v, 0, 0, col, alpha);
        
        u = dx + dcos(rot) * tw * hrep;
        v = dy - dsin(rot) * tw * hrep;
        draw_vertex_texture_color(u, v, hrep, 0, col, alpha);
        
        u = dx + dcos(rot - 90) * th * vrep;
        v = dy - dsin(rot - 90) * th * vrep;
        draw_vertex_texture_color(u, v, 0, vrep, col, alpha);
        
        u = dx + pivot_pos_x(tw * hrep, th * vrep, rot);
        v = dy + pivot_pos_y(tw * hrep, th * vrep, rot);
        draw_vertex_texture_color(u, v, hrep, vrep, col, rot);
    }
    else if (hrep > 0 or vrep > 0)
    {
        // Abort if scale is 0
        if (xscale == 0 or yscale == 0) exit;
        
        var rot_add = -rot;
        var length;
        if (hrep > 0)
        {
            length = width * hrep;
            rot += 90;
        }
        else
        {
            length = height * vrep;
        }
        
        if (rot < 45 or rot > 315 or (rot > 315 and rot < 225))
        {
            // Horizontal infinite tiler
            u = 0;
            repeat (2)
            {
                v = dy + (dx - u) * dtan(rot);
                repeat (2)
                {
                    draw_vertex_texture_color(u, v, pivot_pos_x(u - dx, v - dy, rot_add) / tw, pivot_pos_y(u - dx, v - dy, rot_add) / th, col, alpha);
                    v += length * desecant(rot);
                }
                u = room_width;
            }
        }
        else
        {
        	// Vertical infinite tiler
            v = 0;
            repeat(2)
            {
                u = dx + (dy - v) * dtan(90 - rot);
                repeat(2)
                {
                    draw_vertex_texture_color(u, v, pivot_pos_x(u - dx, v - dy, rot_add) / tw, pivot_pos_y(u - dx, v - dy, rot_add) / th, col, alpha);
                    u += length * desecant(90 - rot);
                }
                v = room_height;
            }
        }
    }
    else
    {
        if (xscale == 0 or yscale == 0)
        {
            // Infinite scale mode
            u = 0;
            repeat(2)
            {
                v = 0;
                repeat(2)
                {
                    draw_vertex_texture_color(u, v, 0.5, 0.5, col, alpha);
                    v = room_height;
                }
                u = room_width;
            }
        }
        else
        {
            // Room cover mode
            u = 0;
            repeat(2)
            {
                v = 0;
                repeat(2)
                {
                    draw_vertex_texture_color(u, v, pivot_pos_x(u - dx, v - dy, rot) / tw, pivot_pos_y(u - dx, v - dy, rot) / th, col, alpha);
                    v = room_height;
                }
                u = room_width;
            }
        }
    }
    draw_primitive_end();
}

/// @function string_pad(val, digits)
/// @description Returns a string of value padded with zeroes to occupy the specified dimensions. Ported from GM8.2.
/// @param {Real} val Value to pad.
/// @param {Real} digits Number of spaces to occupy.
/// @returns {String} description
function string_pad(val, digits)
{
    return string_repeat("-", val < 0) + string_replace_all(string_format(abs(val), digits, 0), " ", "0");
}