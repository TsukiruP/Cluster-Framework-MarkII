/// @function rect([left], [top], [right], [bottom])
/// @description Creates a new rectangle with dimensions assuming (0, 0) origin.
/// @param {Real} left Left radius of the rectangle (optional, default is 0).
/// @param {Real} top Top radius of the rectangle (optional, default is 0).
/// @param {Real} right Right radius of the rectangle (optional, default is 0).
/// @param {Real} bottom Bottom radius of the rectangle (optional, default is 0).
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
    };
}

/// @function hex_to_dec(val, [bits])
/// @description Converts the given hexadecimal value to decimal, assuming the value is signed.
/// @param {Real} val Value to convert.
/// @param {Real} [bits] Number of bits (optional, defaults to 8).
/// @returns {Real}
function hex_to_dec(val, bits = 8)
{
    var maximum = power(2, bits);
    if (val >= maximum / 2) val -= maximum;
    return val;
}

/// @function time_to_frames(minutes, seconds);
/// @description Converts the given time to frames.
/// @param {Real} minutes Minutes to convert.
/// @param {Real} seconds Seconds to convert.
/// @returns {Real}
function time_to_frames(minutes, seconds)
{
    return (minutes * 3600) + (seconds * 60);
}

/// @function modwrap(val, minimum, maximum)
/// @description Wraps the given value between the given range - maximum exclusive. Ported from GM8.2.
/// @param {Real} val Value to wrap.
/// @param {Real} minimum Minimum value.
/// @param {Real} maximum Maximum value.
/// @returns {Real}
function modwrap(val, minimum, maximum)
{
    var diff = val - minimum;
    var range = maximum - minimum;
    return diff - floor(diff / range) * range + minimum;
}

/// @function esign(val, def)
/// @description Checks if the given value is 0, returning the given default if applicable. Ported from GM8.2.
/// @param {Real} val Value to get the sign of.
/// @param {Real} def Default value to give if the value is 0.
/// @returns {Real}
function esign(val, def)
{
    if (val == 0) return def;
    return sign(val);
}

/// @function approach(a, b, step)
/// @description Find the value of a as it approaches b with the given step.
/// @param {Real} a First value.
/// @param {Real} b Second value.
/// @param {Real} step Amount to step.
/// @returns {Real}
function approach(a, b, step)
{
    if (a < b) return min(a + step, b);
    return max (a - step, b);
}

/// @function clamp_inverse(val, minimum, maximum)
/// @description Maintains the given value between the given range by overflowing or underflowing.
/// @param {Real} val Value to wrap.
/// @param {Real} minimum Minimum value.
/// @param {Real} maximum Maximum value.
/// @returns {Real}
function clamp_inverse(val, minimum, maximum)
{
    if (val < minimum) return maximum;
    else if (val > maximum) return minimum;
    return val;
}

/// @function angle_wrap(ang)
/// @description Wraps the given angle between 0 and 360 degrees exclusively.
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
/// @param {Real} amt The maximum amount to straighten by (optional, default is 2.8125).
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

/// @function pivot_pos_x(px, py, dir)
/// @description x-component of two-dimensional lengthdir of a point.
/// @param {Real} px x-coordinate of the point.
/// @param {Real} py y-coordinate of the point.
/// @param {Real} dir Direction of the point.
/// @returns {Real}
function pivot_pos_x(px, py, dir)
{
    return (dcos(dir) * px) + (dcos(dir - 90) * py);
}

/// @function pivot_pos_y(px, py, dir)
/// @description y-component of two-dimensional lengthdir of a point.
/// @param {Real} px x-coordinate of the point.
/// @param {Real} py y-coordinate of the point.
/// @param {Real} dir Direction of the point.
/// @returns {Real}
function pivot_pos_y(px, py, dir)
{
    return (dsin(dir) * -px) + (dsin(dir - 90) * -py);
}

/// @function instance_in_view([obj], [padding])
/// @description Checks if the given instance is visible within the game view.
/// @param {Asset.GMObject|Id.Instance} [obj] Object or instance to check (optional, default is the calling instance).
/// @param {Real} [padding] Distance in pixels to extend the size of the view when checking (optional, default is the CAMERA_PADDING macro).
/// @returns {Bool}
function instance_in_view(obj = id, padding = CAMERA_PADDING)
{
    var left = camera_get_view_x(CAMERA_ID);
    var top = camera_get_view_y(CAMERA_ID);
    var right = left + CAMERA_WIDTH;
    var bottom = top + CAMERA_HEIGHT;
    
    with (obj) return point_in_rectangle(x, y, left - padding, top - padding, right + padding, bottom + padding);
}

/// @function particle_create(x, y, ani, [rot], [life], [xspd], [yspd], [xaccel], [yaccel])
/// @description Creates a new particle with the given animation.
/// @param {Real} x x-coordinate of the particle.
/// @param {Real} y y-coordinate of the particle.
/// @param {Struct.animation} ani animation of the particle.
/// @param {Real} [rot] Rotation of the particle (optional, defaults to 0).
/// @param {Real} [life] Lifespan of the particle (optional, defaults to -1).
/// @param {Real} [xspd] x-speed of the particle (optional, defaults to 0).
/// @param {Real} [yspd] y-speed of the particle (optional, defaults to 0).
/// @param {Real} [xaccel] x-acceleration of the particle (optional, defaults to 0).
/// @param {Real} [yaccel] y-acceleration of the particle (optional, defaults to 0).
/// @returns {Id.Instance}
function particle_create(ox, oy, ani, rot = 0, life = -1, xspd = 0, yspd = 0, xaccel = 0, yaccel = 0)
{
    var particle = instance_create_depth(ox, oy, layer_get_depth("Stage") - DEPTH_OFFSET_PARTICLE, objParticle);
    with (particle)
    {
        animation_set(ani);
        image_angle = angle_wrap(rot);
        
        lifespan = life;
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

/// @function draw_self_as(sprite, [subimg])
/// @description Draws the instance using a different sprite. Ported from GM8.2.
/// @param {Asset.GMSprite} sprite Sprite to draw.
/// @param {Real} [subimg] Sub-image (frame) of the sprite to draw (optional, defaults to image_index).
function draw_self_as(sprite, subimg = image_index)
{
    if (sprite_exists(sprite))
    {
        draw_sprite_ext(sprite, subimg, x div 1, y div 1, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}

/// @function draw_self_floored()
/// @description Draws the instance at its floored position. Ported from GM8.2.
function draw_self_floored()
{
    if (sprite_exists(sprite_index))
    {
        draw_sprite_ext(sprite_index, image_index, x div 1, y div 1, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}

/// @function draw_sprite_tiled_area(sprite, subimg, xorig, yorig, x, y, w, h, [hsep], [vsep], [xoff], [yoff])
/// @description Draws a sprite tiled to fill a region at given offset. Originally by EyeGuy and xot from GMLScripts.com.
/// @param {Asset.GMSprite} sprite Sprite to draw.
/// @param {Real} subimg Sub-image (frame) of the sprite to draw.
/// @param {Real} xorig x-coordinate of the origin offset.
/// @param {Real} yorig y-coordinate of the origin offset.
/// @param {Real} ox x-coordinate of the top left corner of the tiled area.
/// @param {Real} oy y-coordinate of the top left corner of the tiled area.
/// @param {Real} w Width of the tiled area.
/// @param {Real} h Height of the tiled area.
/// @param {Real} [hsep] Horizontal separation between each tile (optional, defaults to 0).
/// @param {Real} [vsep] Vertical separation between each tile (optional, defaults to 0).
/// @param {Real} [xoff] Distance in pixels to offset the sprite horizontally(optional, defaults to 0).
/// @param {Real} [yoff] Distance in pixels to offset the sprite vertically (optional, defaults to 0).
function draw_sprite_tiled_area(sprite, subimg, xorig, yorig, ox, oy, w, h, hsep = 0, vsep = 0, xoff = 0, yoff = 0)
{
    var sw = sprite_get_width(sprite);
    var sh = sprite_get_height(sprite);
    
    var i = ox - (xorig mod sw) - sw * ((ox mod sw) < (xorig mod sw)) + modwrap(xoff, -sw, hsep);
    var j = oy - (yorig mod sh) - sh * ((oy mod sh) < (yorig mod sh)) + modwrap(yoff, -sh, vsep);
    var jj = j;
    
    var left, top, width, height, px, py;
    var right = ox + w;
    var bottom = oy + h;
    for (i = i; i <= right; i += sw + hsep)
    {
        for (j = j; j <= bottom; j += sh + vsep)
        {
            left = (i <= ox) ? ox - i : 0;
            px = i + left;
            
            top = (j <= oy) ? oy - j : 0;
            py = j + top;
            
            width = (right <= i + sw) ? (sw - (i + sw - right)) - left : sw - left;
            height = (bottom <= j + sh) ? (sh - (j + sh - bottom)) - top : sh - top;
            
            draw_sprite_part(sprite, subimg, left, top, width, height, px, py);
        }
        j = jj;
    }
}

/// @function draw_sprite_tiled_extra(sprite, subimg, x, y, [hrep], [vrep], [xscale], [yscale], [rot], [color], [alpha])
/// @description Efficiently tile the given sprite. Ported from GM8.2.
/// @param {Asset.GMSprite} sprite Sprite to draw.
/// @param {Real} subimg Sub-image (frame) to draw.
/// @param {Real} x x-coordinate of where to draw the sprite.
/// @param {Real} y y-coordinate of where to draw the sprite.
/// @param {Real} [hrep] Number of horizontal repetition, use 0 for infinite (optional, defaults to 0).
/// @param {Real} [vrep] Number of vertical repetition, use 0 for infinite (optional, defaults to 0).
/// @param {Real} [xscale] Horizontal scaling of the sprite, as a multiplier (optional, defaults to 1).
/// @param {Real} [yscale] Vertical scaling of the sprite, as a multiplier (optional, defaults to 1).
/// @param {Real} [rot] Rotation of the sprite (optional, defaults to 0).
/// @param {Real} [color] Color with which to blend the sprite (optional, defaults to c_white).
/// @param {Real} [alpha] Alpha of the sprite (optional, defaults to 1).
function draw_sprite_tiled_extra(sprite, subimg, ox, oy, hrep = 0, vrep = 0, xscale = 1, yscale = 1, rot = 0, color = c_white, alpha = 1)
{
    var texture = sprite_get_texture(sprite, subimg);
    var texture_width = sprite_get_width(sprite) * xscale;
    var texture_height = sprite_get_height(sprite) * yscale;
    
    // Abort if width or height is 0
    if (texture_width == 0 or texture_height == 0) exit;
    
    gpu_set_texrepeat(true);
    draw_primitive_begin_texture(pr_trianglestrip, texture);
    
    if (hrep > 0 and vrep > 0)
    {
        // Abort if xscale or yscale is 0
        if (xscale == 0 or yscale == 0) exit;
        
        var u = ox;
        var v = oy;
        draw_vertex_texture_color(u, v, 0, 0, color, alpha);
        
        u = ox + dcos(rot) * texture_width * hrep;
        v = oy - dsin(rot) * texture_width * hrep;
        draw_vertex_texture_color(u, v, hrep, 0, color, alpha);
        
        u = ox + dcos(rot - 90) * texture_height * vrep;
        v = oy - dsin(rot - 90) * texture_height * vrep;
        draw_vertex_texture_color(u, v, 0, vrep, color, alpha);
        
        u = ox + pivot_pos_x(texture_width * hrep, texture_height * vrep, dir);
        v = oy + pivot_pos_y(texture_width * hrep, texture_height * vrep, dir);
        draw_vertex_texture_color(u, v, hrep, vrep, color, alpha);
    }
    else if (hrep > 0 or vrep > 0)
    {
        // Abort if xscale or yscale is 0
        if (xscale == 0 or yscale == 0) exit;
        
        var rot_add = -rot;
        var length = texture_height * vrep;
        
        // Vertical infinity
        if (hrep > 0)
        {
            length = texture_width * hrep;
            rot +=  90;
        }
        
        if (rot < 45 or rot > 315 or (rot > 135 and rot < 225))
        {
            // Horizontal tiling
            var u = 0;
            repeat(2)
            {
                var v = oy + (ox - u) * dtan(rot);
                repeat(2)
                {
                    draw_vertex_texture_color(u, v, pivot_pos_x(u - ox, v - oy, rot_add) / texture_width, pivot_pos_y(u - ox, v - oy, rot_add) / texture_height, color, alpha);
                    v += length * (1 / cos(rot / 180 * pi));
                }
                u = room_width;
            }
        }
        else
        {
            // Vertical tiling
            var v = 0;
            repeat(2)
            {
                var u = ox + (oy - v) * dtan(90 - rot);
                repeat(2)
                {
                    draw_vertex_texture_color(u, v, pivot_pos_x(u - ox, v - oy, rot_add) / texture_width, pivot_pos_y(u - ox, v - oy, rot_add) / texture_height, color, alpha);
                    u += length * (1 / cos((90 - rot) / 180 * pi));
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
            var u = 0;
            repeat(2)
            {
                var v = 0;
                repeat(2)
                {
                    draw_vertex_texture_color(u, v, 0.5, 0.5, color, alpha);
                    v = room_height;
                }
                u = room_width;
            }
        }
        else
        {
            // Cover room mode
            var u = 0;
            repeat(2)
            {
                var v = 0;
                repeat(2)
                {
                    draw_vertex_texture_color(u, v, pivot_pos_x(u - ox, v - oy, rot) / texture_width, pivot_pos_y(u - ox, v - oy, rot) / texture_height, color, alpha);
                    v = room_height;
                }
                u = room_width;
            }
        }
    }
    
    draw_primitive_end();
}

/// @function string_pad(val, digits)
/// @description Pads the given value with zeros to occupy the specified dimensions. Ported from GM8.2.
/// @param {Real} val Value to pad.
/// @param {Real} digits Number of spaces to occupy.
/// @returns {String}
function string_pad(val, digits)
{
    return string_repeat("-", val < 0) + string_replace_all(string_format(abs(val), digits, 0), " ", "0");
}