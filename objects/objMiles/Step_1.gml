/// @description Update
if (ctrlGame.game_paused & PAUSE_FLAG_MENU) exit;

// Inherit the parent event
event_inherited();

with (tails) animation_update();