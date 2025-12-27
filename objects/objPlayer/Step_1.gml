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
with (spin_dash_dust) animation_update();

// Record
if (player_index == 0)
{
    array_push(cpu_axis_x, input_axis_x);
    array_shift(cpu_axis_x);
    
    array_push(cpu_axis_y, input_axis_y);
    array_shift(cpu_axis_y);
    
    array_push(cpu_input_jump, input_button.jump.check);
    array_shift(cpu_input_jump);
    
    array_push(cpu_input_jump_pressed, input_button.jump.pressed);
    array_shift(cpu_input_jump_pressed);
}