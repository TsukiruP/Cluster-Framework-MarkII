/// @description Update
if (ctrlGame.game_paused) exit;

if (control_lock_time > 0 and on_ground)
{
	--control_lock_time;
}

if (invulnerability_time > 0)
{
    --invulnerability_time;
}

animation_update();
with (spin_dash_effect) animation_update();

// Record
if (player_index == 0)
{
	cpu_record_input(CPU_INPUT.X);
	cpu_record_input(CPU_INPUT.Y);
	cpu_record_input(CPU_INPUT.JUMP);
	cpu_record_input(CPU_INPUT.JUMP_PRESSED);
}