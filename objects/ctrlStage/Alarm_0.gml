/// @description Cull
instance_deactivate_object(objStageObject);

// Activate instances inside the view
var vx = global.main_camera.get_x();
var vy = global.main_camera.get_y();
instance_activate_region(vx - CAMERA_PADDING, vy - CAMERA_PADDING, CAMERA_WIDTH + CAMERA_PADDING * 2, CAMERA_HEIGHT + CAMERA_PADDING * 2, true);

// Activate instances around the player
with (objPlayer)
{
	if (not instance_in_view())
	{
		instance_activate_region(x - CAMERA_PADDING, y - CAMERA_PADDING, CAMERA_PADDING * 2, CAMERA_PADDING * 2, true);
	}
}

// Repeat
alarm[0] = 5;