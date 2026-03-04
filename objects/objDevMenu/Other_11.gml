/// @description Character

// Miles
miles_ground_skill_option = new dev_option_int("Ground Skill");
with (miles_ground_skill_option)
{
    clampinv = true;
    minimum = MILES_GROUND_SKILL.NONE;
    maximum = MILES_GROUND_SKILL.HAMMER_ATTACK;
    specifiers = ["None", "Tail Attack", "Tornado", "Hammer Attack"];
    get = function() { return db_read(SAVE_DATABASE, AMY_DEFAULT_HAMMER_SKILL, "miles", "ground_skill"); };
    set = function(val) { db_write(SAVE_DATABASE, val, "miles", "ground_skill"); };
}

var miles_options =
[
    miles_ground_skill_option
];

miles_menu.options = array_concat(miles_menu.options, miles_options);

// Amy
amy_hammer_skill_option = new dev_option_int("Hammer Skill");
with (amy_hammer_skill_option)
{
    clampinv = true;
    minimum = AMY_HAMMER_SKILL.HAMMER_ATTACK;
    maximum = AMY_HAMMER_SKILL.BIG_HAMMER_ATTACK;
    specifiers = ["Hammer Attack", "Double Hammer Attack", "Big Hammer Attack"];
    get = function() { return db_read(SAVE_DATABASE, AMY_DEFAULT_HAMMER_SKILL, "amy", "hammer_skill"); };
    set = function(val) { db_write(SAVE_DATABASE, val, "amy", "hammer_skill"); };
}

var amy_options =
[
    amy_hammer_skill_option
];

amy_menu.options = array_concat(amy_menu.options, amy_options);