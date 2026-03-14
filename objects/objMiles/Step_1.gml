/// @description Update
event_inherited();
if (ctrlGame.game_paused & PAUSE_FLAG_MENU) exit;
with (tails) animation_update();