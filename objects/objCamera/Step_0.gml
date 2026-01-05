if (keyboard_check_pressed(vk_numpad0)) camera_zoom(1, 60);
if (keyboard_check_pressed(vk_numpad1)) camera_zoom(2, 60);

// Calculate zoom
if (zoom_active)
{
	zoom_amount = interpolate(zoom_start, zoom_end, zoom_time++ / zoom_duration, EASE_SMOOTHSTEP);
	if (zoom_amount == zoom_end) zoom_active = false;
    camera_resize();
}