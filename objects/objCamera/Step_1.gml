/// @description Time
if (ctrlGame.game_paused & PAUSE_FLAG_MENU) exit;

if (x_lag_time > 0) x_lag_time--;
if (y_lag_time > 0) y_lag_time--;