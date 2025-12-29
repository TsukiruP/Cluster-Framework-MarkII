// Constants
enum HUD
{
    NONE = -1,
    CLUSTER,
    ADVENTURE,
    ADVENTURE_2,
    ADVANCE_2,
    ADVANCE_3,
    EPISODE_II
}

enum FLICKER
{
    OFF,
    ORIGINAL,
    VIRTUAL_CONSOLE,
    VIRTUAL_CONSOLE_ALT
}

global.config_database = db_create();
db_write(global.config_database, true, "lives");
db_write(global.config_database, true, "time_over");
db_write(global.config_database, HUD.CLUSTER, "hud");
db_write(global.config_database, FLICKER.OFF, "flicker");