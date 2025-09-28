/// @description Initialize
image_speed = 0;

// Boundary
bound_left = 0;
bound_top = 0;
bound_right = room_width;
bound_bottom = room_height;

on_ground = true;

// Panning
x_offset = 0;
y_offset = 0;

// Center view
camera_set_view_pos(CAMERA_ID, x - CAMERA_WIDTH * 0.5, y - CAMERA_HEIGHT * 0.5);