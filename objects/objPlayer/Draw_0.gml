/// @description Draw
var x_int = x div 1;
var y_int = y div 1;

// Character sprite
player_draw_before();
if (sprite_index != -1) draw_sprite_ext(sprite_index, image_index, x_int, y_int, image_xscale, 1, image_angle, c_white, image_alpha);
player_draw_after();

// Spin Dash
with (spin_dash_effect) draw();

// Hurtbox
var left = hurtbox.left_radius;
var top = hurtbox.top_radius;
var right = hurtbox.right_radius;
var bottom = hurtbox.bottom_radius;
var sine = dsin(mask_direction);
var cosine = dcos(mask_direction);

if (image_xscale == -1)
{
	left *= -1;
	right *= -1;
}

var sx1 = x_int + cosine * left + sine * top;
var sy1 = y_int - sine * right + cosine * top;
var sx2 = x_int + cosine * right + sine * bottom;
var sy2 = y_int - sine * left + cosine * bottom;

draw_rectangle_color(sx1, sy1, sx2, sy2, c_maroon, c_maroon, c_maroon, c_maroon, true);

// Virtual mask
/*
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