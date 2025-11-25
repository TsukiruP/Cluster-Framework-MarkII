/// @description Draw
var x_int = x div 1;
var y_int = y div 1;

// Character sprite
image_alpha = (invulnerability_time <= 0) ? 1 : ((invulnerability_time div 2) mod 2);
player_draw_before();
if (sprite_index != -1) draw_sprite_ext(sprite_index, image_index, x_int, y_int, image_xscale, 1, image_angle, c_white, image_alpha);
player_draw_after();

// Spin Dash
spin_dash_effect.draw();

// Hitboxes
draw_hitboxes(mask_direction);

// Virtual mask
if (mask_direction mod 180 != 0)
{
	draw_rectangle_color(x_int - y_radius, y_int - x_radius, x_int + y_radius, y_int + x_radius, c_lime, c_lime, c_lime, c_lime, true);
	draw_line_color(x_int, y_int - x_wall_radius, x_int, y_int + x_wall_radius, c_white, c_white);
}
else
{
	draw_rectangle_color(x_int - x_radius, y_int - y_radius, x_int + x_radius, y_int + y_radius, c_lime, c_lime, c_lime, c_lime, true);
	draw_line_color(x_int - x_wall_radius, y_int, x_int + x_wall_radius, y_int, c_white, c_white);
}
draw_line_color(x_int, y_int, x_int + dsin(mask_direction) * y_radius, y_int + dcos(mask_direction) * y_radius, c_white, c_white);