/// @description Count
if (control_lock_time > 0 and on_ground)
{
	--control_lock_time;
}

animation_update();
with (spin_dash_effect) animation_update();

// Record
if (player_index == 0)
{
	player_record_cpu_input(CPU_INPUT.X);
	player_record_cpu_input(CPU_INPUT.Y);
	player_record_cpu_input(CPU_INPUT.JUMP);
	player_record_cpu_input(CPU_INPUT.JUMP_PRESSED);
}