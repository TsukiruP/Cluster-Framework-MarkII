/// @description Time
if (ctrlGame.game_paused) exit;

if (time_enabled and ++stage_time == time_limit)
{
	time_over = true;
	time_enabled = false;
	if (db_read(global.config_database, CONFIG_DEFAULT_TIME_OVER, "time_over"))
    {
        with (objPlayer) player_damage(id);
    }
}