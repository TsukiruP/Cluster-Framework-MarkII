// Constants
#macro DATABASE_CONFIG global.config_database
#macro DATABASE_SAVE global.save_database

#macro CONFIG_DEFAULT_LIVES true
#macro CONFIG_DEFAULT_TIME_OVER true
#macro CONFIG_DEFAULT_HUD CONFIG_HUD.CLUSTER
#macro CONFIG_DEFAULT_STATUS_BAR CONFIG_STATUS_BAR.ALL
#macro CONFIG_DEFAULT_ITEM_FEED true 
#macro CONFIG_DEFAULT_FLICKER CONFIG_FLICKER.OFF
#macro CONFIG_DEFAULT_DEBUFFS true

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

enum MILES_GROUND_SKILL
{
    NONE,
    TAIL_SWIPE,
    TORNADO_ATTACK,
    HAMMER_ATTACK
}

enum MILES_FLIGHT_STYLE
{
    CLASSIC,
    ADVENTURE
}

// Config
global.config_database = db_create();
db_write(DATABASE_CONFIG, CONFIG_DEFAULT_LIVES, "lives");
db_write(DATABASE_CONFIG, CONFIG_DEFAULT_TIME_OVER, "time_over");
db_write(DATABASE_CONFIG, CONFIG_DEFAULT_HUD, "hud");
db_write(DATABASE_CONFIG, CONFIG_DEFAULT_STATUS_BAR, "status_bar");
db_write(DATABASE_CONFIG, CONFIG_DEFAULT_ITEM_FEED, "item_feed");
db_write(DATABASE_CONFIG, CONFIG_DEFAULT_FLICKER, "flicker");
db_write(DATABASE_CONFIG, CONFIG_DEFAULT_DEBUFFS, "debuffs");

// Save
global.save_database = db_create();
db_write(DATABASE_SAVE, "", "name");
db_write(DATABASE_SAVE, 0, "playtime");
db_write(DATABASE_SAVE, room_get_name(rmTest), "stage");
db_write(DATABASE_SAVE, true, "boost_mode");
db_write(DATABASE_SAVE, true, "trick_actions");
db_write(DATABASE_SAVE, true, "tag_actions");
db_write(DATABASE_SAVE, true, "swap");

for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
    db_write(DATABASE_SAVE, CHARACTER.NONE, "character", i);
}

db_write(DATABASE_SAVE, CHARACTER.SONIC, "character", 0);

db_write(DATABASE_SAVE, MILES_GROUND_SKILL.NONE, "miles", "ground_skill");
db_write(DATABASE_SAVE, MILES_FLIGHT_STYLE.ADVENTURE, "miles", "flight_style");