/// @description Setup
image_speed = 0;
focus = noone;
on_ground = true;

// Boundary
bound_left = 0;
bound_top = 0;
bound_right = room_width;
bound_bottom = room_height;

// Scroll
x_scroll = 0;
y_scroll = 0;

// Lag
x_lag = 0;
y_lag = 0;

// Volumes
volume_lists = [noone];
volume_lists_cap = 4;
volume_lists_strength = [1];

// Constrain
constrain_x = 0;
constrain_y = 0;
constrain_speed = 1/60;

// Center view
camera_set_view_pos(CAMERA_ID, x - CAMERA_WIDTH / 2, y - CAMERA_HEIGHT / 2);