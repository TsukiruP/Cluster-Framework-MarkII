// Constants
#macro SAVE_DATABASE global.save_database

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

global.save_database = db_create();
db_write(SAVE_DATABASE, "", "name");
db_write(SAVE_DATABASE, 0, "playtime");
db_write(SAVE_DATABASE, room_get_name(rmTest), "stage");
db_write(SAVE_DATABASE, true, "boost_mode");
db_write(SAVE_DATABASE, true, "trick_actions");
db_write(SAVE_DATABASE, true, "tag_actions");
db_write(SAVE_DATABASE, true, "swap");

// Characters
for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
    db_write(SAVE_DATABASE, CHARACTER.NONE, "character", i);
}

db_write(SAVE_DATABASE, CHARACTER.SONIC, "character", 0);

// Miles
db_write(SAVE_DATABASE, MILES_GROUND_SKILL.NONE, "miles", "ground_skill");
db_write(SAVE_DATABASE, MILES_FLIGHT_STYLE.ADVENTURE, "miles", "flight_style");