// Constants
enum CONFIG_HUD
{
    NONE = -1,
    CLUSTER,
    ADVENTURE,
    ADVENTURE_2,
    ADVANCE_2,
    ADVANCE_3,
    EPISODE_II
}

enum CONFIG_STATUS_BAR
{
    OFF,
    ACTIVE,
    ALL
}

enum CONFIG_FLICKER
{
    OFF,
    ORIGINAL,
    VIRTUAL_CONSOLE,
    VIRTUAL_CONSOLE_ADVANCE_3
}


global.config_database = db_create();
db_write(global.config_database, true, "lives");
db_write(global.config_database, true, "time_over");
db_write(global.config_database, CONFIG_HUD.CLUSTER, "hud");
db_write(global.config_database, CONFIG_STATUS_BAR.ALL, "status");
db_write(global.config_database, CONFIG_FLICKER.OFF, "flicker");