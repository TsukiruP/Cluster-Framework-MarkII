/// @description Count
if (control_lock_time > 0 and on_ground)
{
	--control_lock_time;
}

animation_update();
with (spin_dash_effect) animation_update();