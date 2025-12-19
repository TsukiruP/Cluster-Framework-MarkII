// Constants
enum HUD
{
    NONE = -1,
    CLUSTER,
    ADVANCE_2,
    ADVANCE_3,
    ADVENTURE,
    ADVENTURE_2
}

global.config_database = db_create();
db_write(global.config_database, true, "time_over");
db_write(global.config_database, true, "shield_flicker");
db_write(global.config_database, HUD.ADVENTURE, "hud");