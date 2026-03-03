// Constants
#macro SAVE_DATABASE global.save_database

#macro SAVE_DEFAULT_MILES_GROUND_SKILL MILES_GROUND_SKILL.NONE
#macro SAVE_DEFAULT_MILES_FLIGHT_STYLE MILES_FLIGHT_STYLE.CLASSIC 
#macro SAVE_DEFAULT_MILES_FLIGHT_ASSIST true 

#macro SAVE_DEFAULT_AMY_HAMMER_SKILL AMY_HAMMER_SKILL.HAMMER_ATTACK
#macro SAVE_DEFAULT_AMY_HAMMER_JUMP true 
#macro SAVE_DEFAULT_AMY_SPIN false  

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

// Create
global.save_database = db_create();

// Metadata
db_write(SAVE_DATABASE, "", "name");
db_write(SAVE_DATABASE, 0, "playtime");
db_write(SAVE_DATABASE, room_get_name(rmTest), "stage");

// Config
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
db_write(SAVE_DATABASE, SAVE_DEFAULT_MILES_GROUND_SKILL, "miles", "ground_skill");
db_write(SAVE_DATABASE, SAVE_DEFAULT_MILES_FLIGHT_STYLE, "miles", "flight_style");
db_write(SAVE_DATABASE, SAVE_DEFAULT_MILES_FLIGHT_ASSIST, "miles", "flight_assist");

// Amy
db_write(SAVE_DATABASE, SAVE_DEFAULT_AMY_HAMMER_SKILL, "amy", "hammer_skill");
db_write(SAVE_DATABASE, SAVE_DEFAULT_AMY_HAMMER_JUMP, "amy", "hammer_jump");
db_write(SAVE_DATABASE, SAVE_DEFAULT_AMY_SPIN, "amy", "spin");