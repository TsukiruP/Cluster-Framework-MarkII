/// @description Home
var player_options = [];
for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
    array_push(player_options, new dev_option_player(i));
}

player_0_option = new dev_option_player(0);
player_1_option = new dev_option_player(1);

config_goto_option = new dev_option("Config");
config_goto_option.confirm = function() { dev_menu_goto(config_menu); };

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
    config_goto_option,
    room_option
];

home_menu.options = array_concat(home_menu.options, player_options, home_options);
menu_index = home_menu;