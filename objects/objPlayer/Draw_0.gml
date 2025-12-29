/// @description Render
var x_int = x div 1;
var y_int = y div 1;

// Character sprite
image_alpha = (invulnerability_time <= 0) ? 1 : ((invulnerability_time div 2) mod 2);
player_draw_before();
draw_self_floored();
player_draw_after();

// Accessories
with (spin_dash_accessory) draw_self_floored();
with (shield_accessory)
{
    if (visible) draw_self_floored();
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