/// @description Config
lives_option = new dev_option_bool("Lives");
with (lives_option)
{
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_LIVES, "lives"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "lives"); };
}

time_over_option = new dev_option_bool("Time Over");
with (time_over_option)
{
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_TIME_OVER, "time_over"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "time_over"); };
}

hud_option = new dev_option_int("HUD");
with (hud_option)
{
    clampinv = true;
    minimum = CONFIG_HUD.NONE;
    maximum = CONFIG_HUD.EPISODE_II;
    specifiers = ["None", "Cluster", "Adventure", "Adventure 2", "Advance 2", "Advance 3", "Episode II"];
    offset = CONFIG_HUD.NONE;
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_HUD, "hud"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "hud"); };
}

status_bar_option = new dev_option_int("Status Bar");
with (status_bar_option)
{
    clampinv = true;
    minimum = CONFIG_STATUS_BAR.OFF;
    maximum = CONFIG_STATUS_BAR.ALL;
    specifiers = ["Off", "Active", "All"];
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_STATUS_BAR, "status_bar"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "status_bar"); };
}

item_feed_option = new dev_option_bool("Item Feed");
with (item_feed_option)
{
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_TIME_OVER, "item_feed"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "item_feed"); };
}

flicker_option = new dev_option_int("Flicker");
with (flicker_option)
{
    clampinv = true;
    minimum = CONFIG_FLICKER.OFF;
    maximum = CONFIG_FLICKER.VIRTUAL_CONSOLE_ADVANCE_3;
    specifiers = ["Off", "Original", "Virtual Console", "Virtual Console (Advance 3)"];
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_FLICKER, "flicker"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "flicker"); };
}

debuffs_option = new dev_option_bool("Debuffs");
with (debuffs_option)
{
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_TIME_OVER, "debuffs"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "debuffs"); };
}

device_option = new dev_option("Device Setup");
device_option.confirm = function() { InputPartySetJoin(true); };

var config_options =
[
    lives_option,
    time_over_option,
    hud_option,
    status_bar_option,
    item_feed_option,
    flicker_option,
    debuffs_option,
    device_option
];

config_menu.options = array_concat(config_menu.options, config_options);