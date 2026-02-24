/// @description Initialize
image_speed = 0;
on_ground = true;

// Boundary
bound_left = 0;
bound_top = 0;
bound_right = room_width;
bound_bottom = room_height;

// Lag
x_lag_time = 0;
y_lag_time = 0;

// Offset
x_offset = 0;
y_offset = 0;

// Zoom
zoom_active = false;
zoom_duration = 0;
zoom_time = 0;
zoom_amount = 1;
zoom_start = 0;
zoom_end = 0;

// Shake
shake_x_offset = 0;
shake_y_offset = 0;
shake_active = false;
shake_magnitude = 0;
shake_duration = 0;
shake_time = 0;

// Volumes
volume_x_offset = 0;
volume_y_offset = 0;
volume_speed = 0.05;

volume_lists = [noone];
volume_lists_cap = 4;
volume_lists_strength = [1];

// Center view
camera_set_view_pos(CAMERA_ID, x - CAMERA_WIDTH / 2, y - CAMERA_HEIGHT / 2);

// Misc.
/// @method camera_resize()
/// @description Resizes the camera, accounting for zoom.
camera_resize = function()
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

/// @method camera_zoom(zoom, [duration])
/// @description Zooms the camera over the given duration.
/// @param {Real} zoom Amount to zoom.
/// @param {Real} [duration] Duration to zoom (optional, defaults to 0).
camera_zoom = function(zoom, duration = 0)
{
    if (duration == 0)
    {
        zoom_amount = zoom;
        camera_resize();
    }
    else
    {
        zoom_active = true;
        zoom_duration = duration;
        zoom_time = 0;
        zoom_start = zoom_amount;
        zoom_end = zoom;
    }
};

/// @method camera_shake(magnitude, duration)
/// @description Shakes the camera over the given duration
/// @param {Real} magnitude Intensity of the shake.
/// @param {Real} duration Duration to shake.
camera_shake = function(magnitude, duration)
{
    shake_active = true;
    shake_magnitude = magnitude;
    shake_duration = duration;
    shake_time = 0;
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