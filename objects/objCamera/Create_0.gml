/// @description Initialize
image_speed = 0;
state = CAMERA_STATE.FOLLOW;
on_ground = false;

// Focus
focus = ctrlStage.stage_players[0];
on_ground = false;
look_time = 0;

// Boundary
bound_left = 0;
bound_top = 0;
bound_right = room_width;
bound_bottom = room_height;

// Target
target_left = bound_left;
target_top = bound_top;
target_right = bound_right;
target_bottom = bound_bottom;

// Lag
x_lag_time = 0;
y_lag_time = 0;

// Offset
x_offset = 0;
y_offset = 0;
ground_offset = 0;
roll_offset = 0;

// Zoom
zoom_active = false;
zoom_time = 0;
zoom_duration = 0;
zoom_amount = 1;
zoom_start = 0;
zoom_end = 0;

// Shake
shake_x_offset = 0;
shake_y_offset = 0;
shake_active = false;
shake_magnitude = 0;
shake_time = 0;
shake_duration = 0;

// Volumes
volume_x_offset = 0;
volume_y_offset = 0;
volume_speed = 0.05;

volume_lists = [noone];
volume_lists_cap = 4;
volume_lists_strength = [1];

// Center view
var ox = clamp(x - CAMERA_WIDTH / 2, bound_left, bound_right - CAMERA_WIDTH);
var oy = clamp(y - CAMERA_HEIGHT / 2, bound_top, bound_bottom - CAMERA_HEIGHT);
camera_set_view_pos(CAMERA_ID, ox, oy);

// Misc.
/// @method resize_view()
/// @description Resizes the camera, accounting for zoom.
resize_view = function()
{
	var view_width = camera_get_view_width(CAMERA_ID);
    var view_height = camera_get_view_height(CAMERA_ID);
    
    var new_width = CAMERA_WIDTH * zoom_amount;
    var new_height = CAMERA_HEIGHT * zoom_amount;
    camera_set_view_size(CAMERA_ID, new_width, new_height);
    
    var x_shift = camera_get_view_x(CAMERA_ID) - (new_width - view_width) / 2;
    var y_shift = camera_get_view_y(CAMERA_ID) - (new_height - view_height) / 2;
    camera_set_view_pos(CAMERA_ID, x_shift, y_shift);
};

/// @method view_to_room_x(x)
/// @description Camera view to room position.
/// @param {Real} x
/// @returns {Real}
view_to_room_x = function(ox)
{
    var zoom_offset = (CAMERA_WIDTH * (1 - zoom_amount)) / 2;
    ox *= zoom_amount;
    ox += zoom_offset + (x - CAMERA_WIDTH / 2) - 1;
    return ox;
};

/// @method view_to_room_y(y)
/// @description Camera view to room position.
/// @param {Real} y
/// @returns {Real}
view_to_room_y = function(oy)
{
    var zoom_offset = (CAMERA_HEIGHT * (1 - zoom_amount)) / 2;
    oy *= zoom_amount;
    oy += zoom_offset + (y - CAMERA_HEIGHT / 2) - 1;
    return oy;
};