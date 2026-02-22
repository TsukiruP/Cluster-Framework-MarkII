/// @description Animate
if (ctrlGame.game_paused) exit;
if (animation_data.variant == 1 and animation_is_finished()) animation_data.variant = 0;
animation_set(ani_spring);