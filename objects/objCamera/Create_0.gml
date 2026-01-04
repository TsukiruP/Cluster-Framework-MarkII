/// @description Setup
image_speed = 0;
zoom_amount = 1;
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
volume_x = 0;
volume_y = 0;
volume_speed = 0.05;

volume_lists = [noone];
volume_lists_cap = 4;
volume_lists_strength = [1];

// Center view
camera_set_view_pos(CAMERA_ID, x - CAMERA_WIDTH / 2, y - CAMERA_HEIGHT / 2);

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

/// @method zoom(z)
/// @description Zooms the camera.
/// @param {Real} z Amount to zoom.
zoom = function(oz)
{
    zoom_amount = oz div 1;
    var new_width = CAMERA_WIDTH * zoom_amount;
    var new_height = CAMERA_HEIGHT * zoom_amount;
    camera_set_view_size(CAMERA_ID, new_width, new_height);
}