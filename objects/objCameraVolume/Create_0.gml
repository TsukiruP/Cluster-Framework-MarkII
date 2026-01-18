/// @description Initialize
image_speed = 0;
image_angle = angle_wrap(image_angle);
included_volumes = [];
left = true;
top = true;
right = true;
bottom = true;

if (image_angle mod 90 != 0)
{
    show_error($"{object_get_name(object_index)}.image_angle must be a multiple of 90 degees, got {image_angle}", true);
}

if (instance_exists(included_volume1)) array_push(included_volumes, included_volume1);
if (instance_exists(included_volume2)) array_push(included_volumes, included_volume2);
if (instance_exists(included_volume3)) array_push(included_volumes, included_volume3);
if (instance_exists(included_volume4)) array_push(included_volumes, included_volume4);