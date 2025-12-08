/// @description Animate
if (crumble or is_crumbled)
{
    if (crumble_time < 64) crumble_time++;
    if (crumble_time > 48) is_crumbled = true;
}
else if (crumble_time > 0)
{
	crumble_time--;
}

var crumble_index = (crumble_time >> 2) - 4;
if (crumble_index >= image_number)
{
    reset = true;
}
else
{
	image_index = max(0, crumble_index);
}

if (reset & not instance_in_view(self, 128))
{
    is_crumbled = false;
    crumble_time = 0;
    reset = false;
}