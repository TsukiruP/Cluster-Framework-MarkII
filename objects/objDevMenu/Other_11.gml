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
    set = function(_val) { db_write(SAVE_DATABASE, _val, "miles", "ground_skill"); };
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
    set = function(_val) { db_write(SAVE_DATABASE, _val, "amy", "hammer_skill"); };
}

amy_hammer_whirl_option = new dev_option_bool("Hammer Whirl");
with (amy_hammer_whirl_option)
{
    get = function() { return db_read(SAVE_DATABASE, AMY_DEFAULT_HAMMER_WHIRL, "amy", "hammer_whirl"); };
    set = function(_val) { db_write(SAVE_DATABASE, _val, "amy", "hammer_whirl"); };
}

amy_hammer_jump_option = new dev_option_bool("Hammer Jump");
with (amy_hammer_jump_option)
{
    get = function() { return db_read(SAVE_DATABASE, AMY_DEFAULT_HAMMER_JUMP, "amy", "hammer_jump"); };
    set = function(_val) { db_write(SAVE_DATABASE, _val, "amy", "hammer_jump"); };
}

amy_spin_option = new dev_option_bool("Spin");
with (amy_spin_option)
{
    get = function() { return db_read(SAVE_DATABASE, AMY_DEFAULT_SPIN, "amy", "spin"); };
    set = function(_val) { db_write(SAVE_DATABASE, _val, "amy", "spin"); };
}

amy_spin_alt_option = new dev_option_int("Hammer Skill");
with (amy_spin_alt_option)
{
    clampinv = true;
    minimum = AMY_SPIN_ALT.LEAP;
    maximum = AMY_SPIN_ALT.DASH;
    specifiers = ["Leap", "Amy Dash"];
    get = function() { return db_read(SAVE_DATABASE, AMY_DEFAULT_SPIN_ALT, "amy", "spin_alt"); };
    set = function(_val) { db_write(SAVE_DATABASE, _val, "amy", "spin_alt"); };
}

var amy_options =
[
    amy_hammer_skill_option,
    amy_hammer_whirl_option,
    amy_hammer_jump_option,
    amy_spin_option,
    amy_spin_alt_option
];

amy_menu.options = array_concat(amy_menu.options, amy_options);