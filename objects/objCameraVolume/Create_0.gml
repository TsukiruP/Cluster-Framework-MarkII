/// @description Setup
left = true;
top = true;
right = true;
bottom = true;

image_angle = angle_wrap(image_angle);
if (image_angle mod 90 != 0)
{
    show_error($"{object_get_name(object_index)}.image_angle must be a multiple of 90 degees, got {image_angle}", true);
}