/// @description Render
var vx = camera_get_view_x(CAMERA_ID) + CAMERA_WIDTH / 2;
var vy = camera_get_view_y(CAMERA_ID) + CAMERA_HEIGHT / 2;
draw_rectangle(vx div 1 - 8, vy div 1 - 32, vx div 1 + 8, vy div 1 + 32, true);