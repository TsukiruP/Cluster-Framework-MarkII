/// @description Initialize
image_speed = 0;

// Boundary
bound_left = 0;
bound_top = 0;
bound_right = room_width;
bound_bottom = room_height;

// Timing
stage_time = 0;
time_limit = 36000;
time_over = false;
time_enabled = true;

alarm[0] = 5;

// Identify stage
switch (room)
{
	case rmTest:
	{
		name = "DEMONSTRATION";
		act = 1;
		break;
	}
}

// Create UI elements
instance_create_layer(0, 0, "Display", objHUD);