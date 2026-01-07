/// @description Render
var sink_x = (sink_left - sink_right) >> sink_shift;
var sink_y = (sink_top - sink_bottom) >> sink_shift;
draw_sprite_ext(sprite_index, image_index, x div 1 + sink_x, y div 1 + sink_y, 1, 1, image_angle, c_white, 1);