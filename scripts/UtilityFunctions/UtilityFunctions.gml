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

/// @function convert_time(minutes, seconds);
/// @description Returns the given time in frames.
/// @param {Real} minutes Minutes to convert.
/// @param {Real} seconds Seconds to convert.
/// @returns {Real}
function convert_time(minutes, seconds)
{
    return (minutes * 3600) + (seconds * 60);
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
/// @param {Real} [xspd] x-speed of the particle (optional, defaults to 0).
/// @param {Real} [yspd] y-speed of the particle (optional, defaults to 0).
/// @param {Real} [xaccel] x-acceleration of the particle (optional, defaults to 0).
/// @param {Real} [yaccel] y-acceleration of the particle (optional, defaults to 0).
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

/// @function draw_sprite_tiled_area(sprite, subimg, xorig, yorig, x, y, w, h, [xoff], [yoff], [hsep], [vsep])
/// @description Draws a sprite tiled to fill a region at given offset. Originally by EyeGuy and xot from GMLScripts.com.
/// @param {Asset.GMSprite} sprite Sprite to draw.
/// @param {Real} subimg Sub-image (frame) of the sprite to draw.
/// @param {Real} xorig x-coordinate of the origin offset.
/// @param {Real} yorig y-coordinate of the origin offset.
/// @param {Real} ox x-coordinate of the top left corner of the tiled area.
/// @param {Real} oy y-coordinate of the top left corner of the tiled area.
/// @param {Real} w Width of the tiled area.
/// @param {Real} h Height of the tiled area.
/// @param {Real} [xoff] Distance in pixels to offset the sprite horizontally(optional, defaults to 0).
/// @param {Real} [yoff] Distance in pixels to offset the sprite vertically (optional, defaults to 0).
/// @param {Real} [hsep] Horizontal separation between each tile (optional, defaults to 0).
/// @param {Real} [vsep] Vertical separation between each tile (optional, defaults to 0).
function draw_sprite_tiled_area(sprite, subimg, xorig, yorig, ox, oy, w, h, xoff = 0, yoff = 0, hsep = 0, vsep = 0)
{
    var sw = sprite_get_width(sprite);
    var sh = sprite_get_height(sprite);
    
    var i = ox - (xorig mod sw) - sw * ((ox mod sw) < (xorig mod sw));
    var j = oy - (yorig mod sh) - sh * ((oy mod sh) < (yorig mod sh));
    var jj = j;
    
    draw_text(0, 0, $"{i}");
    
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

/// @function string_pad(val, digits)
/// @description Returns a string of value padded with zeroes to occupy the specified dimensions. Ported from GM8.2.
/// @param {Real} val Value to pad.
/// @param {Real} digits Number of spaces to occupy.
/// @returns {String} description
function string_pad(val, digits)
{
    return string_repeat("-", val < 0) + string_replace_all(string_format(abs(val), digits, 0), " ", "0");
}