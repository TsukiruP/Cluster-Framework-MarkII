/// @description Render
var x_int = x div 1;
var y_int = y div 1;
var shield_behind = false;

// Shield
with (shield_stamp)
{
    if ((animation_data.ani == global.ani_shield_fire_v0 and image_index mod 2 != 0) or
        animation_data.ani == global.ani_shield_lightning_v1)
    {
        shield_behind = true;
        draw_self_floored();
    }
}

// Character sprite
image_alpha = (recovery_time > 0 ? (recovery_time mod 4 < 2) : 1);
player_draw_before();
draw_self_floored();
player_draw_after();

// Stamps
with (spin_dash_stamp) draw_self_floored();
with (shield_stamp)
{
    if (not shield_behind)
    {
        if (visible)
        {
            draw_self_floored();
        }
        else if (animation_data.ani == global.ani_shield_bubble_wave_v0)
        {
            draw_self_as(sprShieldBubbleShell, animation_data.time div 12);
        }
    }
}

// Hitboxes
draw_hitboxes(mask_direction);

// Virtual mask
var sine = dsin(mask_direction);
if (sine == 0)
{
	draw_rectangle_color(x_int - x_radius, y_int - y_radius, x_int + x_radius, y_int + y_radius, c_lime, c_lime, c_lime, c_lime, true);
	draw_line_color(x_int - x_wall_radius, y_int, x_int + x_wall_radius, y_int, c_white, c_white);
}
else
{
	draw_rectangle_color(x_int - y_radius, y_int - x_radius, x_int + y_radius, y_int + x_radius, c_lime, c_lime, c_lime, c_lime, true);
	draw_line_color(x_int, y_int - x_wall_radius, x_int, y_int + x_wall_radius, c_white, c_white);
}
draw_line_color(x_int, y_int, x_int + sine * y_radius, y_int + dcos(mask_direction) * y_radius, c_white, c_white);