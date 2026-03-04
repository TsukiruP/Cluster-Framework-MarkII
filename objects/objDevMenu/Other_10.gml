/// @description Home
var player_options = [];
for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
    array_push(player_options, new dev_option_player(i));
}

player_0_option = new dev_option_player(0);
player_1_option = new dev_option_player(1);

boost_mode_option = new dev_option_bool("Boost Mode");
with (boost_mode_option)
{
    get = function() { return db_read(SAVE_DATABASE, true, "boost_mode"); };
    set = function(val) { db_write(SAVE_DATABASE, val, "boost_mode"); };
}

trick_actions_option = new dev_option_bool("Trick Actions");
with (trick_actions_option)
{
    get = function() { return db_read(SAVE_DATABASE, true, "trick_actions"); };
    set = function(val) { db_write(SAVE_DATABASE, val, "trick_actions"); };
}

tag_actions_option = new dev_option_bool("Tag Actions");
with (tag_actions_option)
{
    get = function() { return db_read(SAVE_DATABASE, true, "tag_actions"); };
    set = function(val) { db_write(SAVE_DATABASE, val, "tag_actions"); };
}

swap_option = new dev_option_bool("Swap");
with (swap_option)
{
    get = function() { return db_read(SAVE_DATABASE, true, "swap"); };
    set = function(val) { db_write(SAVE_DATABASE, val, "swap"); };
}

config_option = new dev_option("Config");
config_option.confirm = function() { dev_menu_goto(config_menu); }

room_option = new dev_option_array("Room");
with (room_option)
{
    elements = [rmTest, rmTestNew];
    confirm = function()
    {
        transition_create(elements[index]);
        return true;
    }
    toString = function() { return room_get_name(elements[index]); };
}

var home_options =
[
    boost_mode_option,
    trick_actions_option,
    tag_actions_option,
    swap_option,
    config_option,
    room_option
];

home_menu.options = array_concat(home_menu.options, player_options, home_options)