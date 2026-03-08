/// @description Draws a sprite tiled to fill a region at given offset. Originally by EyeGuy and xot from GMLScripts.com.
/// @param {Asset.GMSprite} sprite Sprite to draw.
/// @param {Real} subimg Sub-image (frame) of the sprite to draw.
/// @param {Real} xorig x-coordinate of the origin offset.
/// @param {Real} yorig y-coordinate of the origin offset.
/// @param {Real} x x-coordinate of the top left corner of the tiled area.
/// @param {Real} y y-coordinate of the top left corner of the tiled area.
/// @param {Real} w Width of the tiled area.
/// @param {Real} h Height of the tiled area.
/// @param {Real} [hsep] Horizontal separation between each tile (optional, defaults to 0).
/// @param {Real} [vsep] Vertical separation between each tile (optional, defaults to 0).
/// @param {Real} [xoff] Distance in pixels to offset the sprite horizontally (optional, defaults to 0).
/// @param {Real} [yoff] Distance in pixels to offset the sprite vertically (optional, defaults to 0).
function draw_sprite_tiled_area(_sprite, _subimg, _xorig, _yorig, _x, _y, _w, _h, _hsep = 0, _vsep = 0, _xoff = 0, _yoff = 0)
{
    var sw = sprite_get_width(_sprite);
    var sh = sprite_get_height(_sprite);
    
    var i = _x - (_xorig mod sw) - sw * ((_x mod sw) < (_xorig mod sw)) + modwrap(_xoff, -sw, _hsep);
    var j = _y - (_yorig mod sh) - sh * ((_y mod sh) < (_yorig mod sh)) + modwrap(_yoff, -sh, _vsep);
    var jj = j;
    
    var left, top, width, height, px, py;
    var right = _x + _w;
    var bottom = _y + _h;
    for (i = i; i <= right; i += sw + _hsep)
    {
        for (j = j; j <= bottom; j += sh + _vsep)
        {
            left = (i <= _x) ? _x - i : 0;
            px = i + left;
            
            top = (j <= _y) ? _y - j : 0;
            py = j + top;
            
            width = (right <= i + sw) ? (sw - (i + sw - right)) - left : sw - left;
            height = (bottom <= j + sh) ? (sh - (j + sh - bottom)) - top : sh - top;
            
            draw_sprite_part(_sprite, _subimg, left, top, width, height, px, py);
        }
        
        j = jj;
    }
}

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
function draw_sprite_tiled_extra(_sprite, _subimg, _x, _y, _hrep = 0, _vrep = 0, _xscale = 1, _yscale = 1, _rot = 0, _color = c_white, _alpha = 1)
{
    var texture = sprite_get_texture(_sprite, _subimg);
    var texture_width = sprite_get_width(_sprite) * _xscale;
    var texture_height = sprite_get_height(_sprite) * _yscale;
    
    // Abort if width or height is 0
    if (texture_width == 0 or texture_height == 0) exit;
    
    gpu_set_texrepeat(true);
    draw_primitive_begin_texture(pr_trianglestrip, texture);
    
    if (_hrep > 0 and _vrep > 0)
    {
        // Abort if _xscale or _yscale is 0
        if (_xscale == 0 or _yscale == 0) exit;
        
        var u = _x;
        var v = _y;
        draw_vertex_texture_color(u, v, 0, 0, _color, _alpha);
        
        u = _x + dcos(_rot) * texture_width * _hrep;
        v = _y - dsin(_rot) * texture_width * _hrep;
        draw_vertex_texture_color(u, v, _hrep, 0, _color, _alpha);
        
        u = _x + dcos(_rot - 90) * texture_height * _vrep;
        v = _y - dsin(_rot - 90) * texture_height * _vrep;
        draw_vertex_texture_color(u, v, 0, _vrep, _color, _alpha);
        
        u = _x + pivot_pos_x(texture_width * _hrep, texture_height * _vrep, dir);
        v = _y + pivot_pos_y(texture_width * _hrep, texture_height * _vrep, dir);
        draw_vertex_texture_color(u, v, _hrep, _vrep, _color, _alpha);
    }
    else if (_hrep > 0 or _vrep > 0)
    {
        // Abort if _xscale or _yscale is 0
        if (_xscale == 0 or _yscale == 0) exit;
        
        var rot_add = -_rot;
        var length = texture_height * _vrep;
        
        // Vertical infinity
        if (_hrep > 0)
        {
            length = texture_width * _hrep;
            _rot +=  90;
        }
        
        if (_rot < 45 or _rot > 315 or (_rot > 135 and _rot < 225))
        {
            // Horizontal tiling
            var u = 0;
            repeat(2)
            {
                var v = _y + (_x - u) * dtan(_rot);
                repeat(2)
                {
                    draw_vertex_texture_color(u, v, pivot_pos_x(u - _x, v - _y, rot_add) / texture_width, pivot_pos_y(u - _x, v - _y, rot_add) / texture_height, _color, _alpha);
                    v += length * (1 / cos(_rot / 180 * pi));
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
                var u = _x + (_y - v) * dtan(90 - _rot);
                repeat(2)
                {
                    draw_vertex_texture_color(u, v, pivot_pos_x(u - _x, v - _y, rot_add) / texture_width, pivot_pos_y(u - _x, v - _y, rot_add) / texture_height, _color, _alpha);
                    u += length * (1 / cos((90 - _rot) / 180 * pi));
                }
                
                v = room_height;
            }
        }
    }
    else
    {
        if (_xscale == 0 or _yscale == 0)
        {
            // Infinite scale mode
            var u = 0;
            repeat(2)
            {
                var v = 0;
                repeat(2)
                {
                    draw_vertex_texture_color(u, v, 0.5, 0.5, _color, _alpha);
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
                    draw_vertex_texture_color(u, v, pivot_pos_x(u - _x, v - _y, _rot) / texture_width, pivot_pos_y(u - _x, v - _y, _rot) / texture_height, _color, _alpha);
                    v = room_height;
                }
                
                u = room_width;
            }
        }
    }
    
    draw_primitive_end();
}

/// @description Resets draw color, alpha, and text alignment. Ported from GM8.2.
function draw_reset()
{
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

/// @description Draws the instance using a different sprite. Ported from GM8.2.
/// @param {Asset.GMSprite} sprite Sprite to draw.
/// @param {Real} [subimg] Sub-image (frame) of the sprite to draw (optional, defaults to image_index).
function draw_self_as(_sprite, _subimg = image_index)
{
    if (sprite_exists(_sprite))
    {
        draw_sprite_ext(_sprite, _subimg, x div 1, y div 1, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}

/// @description Draws the instance at its floored position. Ported from GM8.2.
function draw_self_floored()
{
    if (sprite_exists(sprite_index))
    {
        draw_sprite_ext(sprite_index, image_index, x div 1, y div 1, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}