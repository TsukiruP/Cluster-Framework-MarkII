// Constants
enum HUD
{
    NONE = -1,
    DEFAULT,
    ADVANCE_2,
    ADVANCE_3
}

global.config_database = db_create();
db_write(global.config_database, true, "time_over");
db_write(global.config_database, true, "shield_flicker");
db_write(global.config_database, HUD.ADVANCE_3, "hud");