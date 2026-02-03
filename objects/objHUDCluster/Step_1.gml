/// @description Time
if (ctrlGame.game_paused & PAUSE_FLAG_MENU) exit;
event_inherited();

if (hud_active)
{
    if (active_time < active_duration) active_time++;
}
else
{
    if (active_time > 0) active_time--;
}