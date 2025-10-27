/// @description Scale
if (++scale == 4)
{
	scale = 0;
	stanncam_set_borderless();
}
else
{
	if (scale == 1) stanncam_set_windowed()
    stanncam_set_resolution(CAMERA_WIDTH * scale, CAMERA_HEIGHT * scale);
	alarm[0] = 1;
}