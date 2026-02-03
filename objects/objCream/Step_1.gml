/// @description Update
if (ctrlGame.game_paused & PAUSE_FLAG_MENU) exit;
event_inherited();

with (ears) animation_update();