// Constants
#macro SAVE_DATABASE global.save_database

#macro MILES_DEFAULT_GROUND_SKILL MILES_GROUND_SKILL.NONE
#macro MILES_DEFAULT_FLIGHT_ASSIST true

#macro AMY_DEFAULT_HAMMER_SKILL AMY_HAMMER_SKILL.HAMMER_ATTACK
#macro AMY_DEFAULT_HAMMER_WHIRL true
#macro AMY_DEFAULT_HAMMER_JUMP true
#macro AMY_DEFAULT_SPIN false
#macro AMY_DEFAULT_SPIN_ALT AMY_SPIN_ALT.LEAP

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

enum AMY_HAMMER_SKILL
{
    HAMMER_ATTACK,
    DOUBLE_HAMMER_ATTACK,
    BIG_HAMMER_ATTACK
}

enum AMY_SPIN_ALT
{
    LEAP,
    DASH
}

// Create
global.save_database = db_create();

// Metadata
db_write(SAVE_DATABASE, "", "name");
db_write(SAVE_DATABASE, 0, "playtime");
db_write(SAVE_DATABASE, room_get_name(rmTest), "stage");

// Characters
for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
    db_write(SAVE_DATABASE, CHARACTER.NONE, "character", i);
}

db_write(SAVE_DATABASE, CHARACTER.SONIC, "character", 0);

// Miles
db_write(SAVE_DATABASE, MILES_DEFAULT_GROUND_SKILL, "miles", "ground_skill");

// Amy
db_write(SAVE_DATABASE, AMY_DEFAULT_HAMMER_SKILL, "amy", "hammer_skill");
db_write(SAVE_DATABASE, AMY_DEFAULT_HAMMER_WHIRL, "amy", "hammer_whirl");
db_write(SAVE_DATABASE, AMY_DEFAULT_HAMMER_JUMP, "amy", "hammer_jump");
db_write(SAVE_DATABASE, AMY_DEFAULT_SPIN, "amy", "spin");
db_write(SAVE_DATABASE, AMY_DEFAULT_SPIN_ALT, "amy", "spin_alt");