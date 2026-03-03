/// @description Wraps the given angle between 0 and 360 degrees exclusively.
/// @param {Real} ang Angle to wrap.
/// @returns {Real}
function angle_wrap(ang)
{
	return (ang mod 360 + 360) mod 360;
}

/// @description Checks if the given instance is visible within the game view.
/// @param {Asset.GMObject|Id.Instance} [ind] Object or instance to check (optional, default is the calling instance).
/// @param {Real} [padding] Distance to extend the size of the view when checking (optional, default is the CAMERA_PADDING macro).
/// @returns {Bool}
function instance_in_view(ind = id, padding = CAMERA_PADDING)
{
	var left = camera_get_view_x(CAMERA_ID);
	var top = camera_get_view_y(CAMERA_ID);
	var right = left + CAMERA_WIDTH;
	var bottom = top + CAMERA_HEIGHT;
	
	with (ind) return point_in_rectangle(x, y, left - padding, top - padding, right + padding, bottom + padding);
}