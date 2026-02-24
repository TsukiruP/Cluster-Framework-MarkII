/// @function camera_set_look_time(time, [force])
/// @description Sets the camera's look time.
/// @param {Real} time Time to set.
/// @param {Bool} [force] Set time even if not the camera's focus (optional, defaults to false).
function camera_set_look_time(time, force = false)
{
    with (objCamera)
    {
        if (force or focus == other.id) look_time = time;
    }
}

/// @function camera_set_x_lag_time(time, [force])
/// @description Sets the camera's horizontal lag time.
/// @param {Real} time Time to set.
/// @param {Bool} [force] Set time even if not the camera's focus (optional, defaults to false).
function camera_set_x_lag_time(time, force = false)
{
    with (objCamera)
    {
        if (force or focus == other.id) x_lag_time = time;
    }
}

/// @function camera_set_y_lag_time(time, [force])
/// @description Sets the camera's vertical lag time.
/// @param {Real} time Time to set.
/// @param {Bool} [force] Set time even if not the camera's focus (optional, defaults to false).
function camera_set_y_lag_time(time, force = false)
{
    with (objCamera)
    {
        if (force or focus == other.id) y_lag_time = time;
    }
}

/// @function camera_set_zoom(zoom, [duration])
/// @description Zooms the camera over the given duration.
/// @param {Real} zoom Amount to zoom.
/// @param {Real} [duration] Duration to zoom (optional, defaults to 0).
function camera_set_zoom (zoom, duration = 0)
{
    with (objCamera)
    {
        if (duration == 0)
        {
            zoom_amount = zoom;
            resize_view();
        }
        else
        {
            zoom_active = true;
            zoom_duration = duration;
            zoom_time = 0;
            zoom_start = zoom_amount;
            zoom_end = zoom;
        }
    }
};

/// @function camera_set_shake(magnitude, duration)
/// @description Shakes the camera over the given duration.
/// @param {Real} magnitude Intensity of the shake.
/// @param {Real} duration Duration to shake.
function camera_set_shake(magnitude, duration)
{
    with (objCamera)
    {
        shake_active = true;
        shake_magnitude = magnitude;
        shake_duration = duration;
        shake_time = 0;
    }
};