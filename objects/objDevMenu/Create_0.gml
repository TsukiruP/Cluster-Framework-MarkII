/// @description Initialize
image_speed = 0;
history = [];

#region Config

lives_option = new dev_option_bool("Lives");
with (lives_option)
{
    get = function() { return db_read(DATABASE_CONFIG, CONFIG_DEFAULT_LIVES, "lives"); };
    set = function(val) { db_write(DATABASE_CONFIG, val, "lives"); };
}

time_over_option = new dev_option_bool("Time Over");
with (time_over_option)
{
    get = function() { return db_read(DATABASE_CONFIG, CONFIG_DEFAULT_TIME_OVER, "time_over"); };
    set = function(val) { db_write(DATABASE_CONFIG, val, "time_over"); };
}

hud_option = new dev_option_int("HUD");
with (hud_option)
{
    clampinv = true;
    minimum = CONFIG_HUD.NONE;
    maximum = CONFIG_HUD.EPISODE_II;
    specifiers = ["None", "Cluster", "Adventure", "Adventure 2", "Advance 2", "Advance 3", "Episode II"];
    offset = CONFIG_HUD.NONE;
    get = function() { return db_read(DATABASE_CONFIG, CONFIG_DEFAULT_HUD, "hud"); };
    set = function(val) { db_write(DATABASE_CONFIG, val, "hud"); };
}

status_bar_option = new dev_option_int("Status Bar");
with (status_bar_option)
{
    clampinv = true;
    minimum = CONFIG_STATUS_BAR.OFF;
    maximum = CONFIG_STATUS_BAR.ALL;
    specifiers = ["Off", "Active", "All"];
    get = function() { return db_read(DATABASE_CONFIG, CONFIG_DEFAULT_STATUS_BAR, "status_bar"); };
    set = function(val) { db_write(DATABASE_CONFIG, val, "status_bar"); };
}

item_feed_option = new dev_option_bool("Item Feed");
with (item_feed_option)
{
    get = function() { return db_read(DATABASE_CONFIG, CONFIG_DEFAULT_TIME_OVER, "item_feed"); };
    set = function(val) { db_write(DATABASE_CONFIG, val, "item_feed"); };
}

flicker_option = new dev_option_int("Flicker");
with (flicker_option)
{
    clampinv = true;
    minimum = CONFIG_FLICKER.OFF;
    maximum = CONFIG_FLICKER.VIRTUAL_CONSOLE_ADVANCE_3;
    specifiers = ["Off", "Original", "Virtual Console", "Virtual Console (Advance 3)"];
    get = function() { return db_read(DATABASE_CONFIG, CONFIG_DEFAULT_FLICKER, "flicker"); };
    set = function(val) { db_write(DATABASE_CONFIG, val, "flicker"); };
}

debuffs_option = new dev_option_bool("Debuffs");
with (debuffs_option)
{
    get = function() { return db_read(DATABASE_CONFIG, CONFIG_DEFAULT_TIME_OVER, "debuffs"); };
    set = function(val) { db_write(DATABASE_CONFIG, val, "debuffs"); };
}

device_option = new dev_option("Device Setup");
device_option.confirm = function() { InputPartySetJoin(true); };

config_menu = new dev_menu([lives_option, time_over_option, hud_option, status_bar_option, item_feed_option, flicker_option, debuffs_option, device_option]);

#endregion

#region Home

player_options = [];
for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
    array_push(player_options, new dev_option_player(i));
}

player_0_option = new dev_option_player(0);
player_1_option = new dev_option_player(1);

boost_mode_option = new dev_option_bool("Boost Mode");
with (boost_mode_option)
{
    get = function() { return db_read(DATABASE_SAVE, true, "boost_mode"); };
    set = function(val) { db_write(DATABASE_SAVE, val, "boost_mode"); };
}

trick_actions_option = new dev_option_bool("Trick Actions");
with (trick_actions_option)
{
    get = function() { return db_read(DATABASE_SAVE, true, "trick_actions"); };
    set = function(val) { db_write(DATABASE_SAVE, val, "trick_actions"); };
}

tag_actions_option = new dev_option_bool("Tag Actions");
with (tag_actions_option)
{
    get = function() { return db_read(DATABASE_SAVE, true, "tag_actions"); };
    set = function(val) { db_write(DATABASE_SAVE, val, "tag_actions"); };
}

swap_option = new dev_option_bool("Swap");
with (swap_option)
{
    get = function() { return db_read(DATABASE_SAVE, true, "swap"); };
    set = function(val) { db_write(DATABASE_SAVE, val, "swap"); };
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

home_menu = new dev_menu(array_concat(player_options,
    [boost_mode_option, trick_actions_option,
    tag_actions_option, swap_option,
    config_option, room_option]));

#endregion

menu_index = home_menu;