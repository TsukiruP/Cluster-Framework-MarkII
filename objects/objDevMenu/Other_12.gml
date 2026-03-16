/// @description Config
visual_goto_option = new dev_option("Visuals");
visual_goto_option.confirm = function() { dev_menu_goto(visuals_menu); };

gameplay_goto_option = new dev_option("Gameplay");
gameplay_goto_option.confirm = function() { dev_menu_goto(gameplay_menu); };

controls_goto_option = new dev_option("Controls");
controls_goto_option.confirm = function() { dev_menu_goto(controls_menu); };

var config_options =
[
    visual_goto_option,
    gameplay_goto_option,
    controls_goto_option
];

config_menu.options = array_concat(config_menu.options, config_options);

// Visuals
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

var visual_options =
[
    hud_option,
    status_bar_option,
    item_feed_option,
    flicker_option
];

visuals_menu.options = array_concat(visuals_menu.options, visual_options);

// Gameplay
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

debuffs_option = new dev_option_bool("Debuffs");
with (debuffs_option)
{
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_TIME_OVER, "debuffs"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "debuffs"); };
}

boost_mode_option = new dev_option_bool("Boost Mode");
with (boost_mode_option)
{
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_BOOST_MODE, "boost_mode"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "boost_mode"); };
}

trick_actions_option = new dev_option_bool("Trick Actions");
with (trick_actions_option)
{
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_TRICK_ACTIONS, "trick_actions"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "trick_actions"); };
}

tag_actions_option = new dev_option_bool("Tag Actions");
with (tag_actions_option)
{
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_TAG_ACTIONS, "tag_actions"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "tag_actions"); };
}

swap_option = new dev_option_bool("Swap");
with (swap_option)
{
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_SWAP, "swap"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "swap"); };
}

var gameplay_options =
[
    lives_option,
    time_over_option,
    debuffs_option,
    boost_mode_option,
    trick_actions_option,
    tag_actions_option,
    swap_option
];

gameplay_menu.options = array_concat(gameplay_menu.options, gameplay_options);

// Controls
device_option = new dev_option("Device Setup");
device_option.confirm = function() { InputPartySetJoin(true); };

flight_style_option = new dev_option_int("Flight Style");
with (flight_style_option)
{
    clampinv = true;
    minimum = CONFIG_FLIGHT_STYLE.CLASSIC;
    maximum = CONFIG_FLIGHT_STYLE.ADVENTURE;
    specifiers = ["Classic", "Adventure"];
    get = function() { return db_read(CONFIG_DATABASE, CONFIG_DEFAULT_FLIGHT_STYLE, "flight_style"); };
    set = function(_val) { db_write(CONFIG_DATABASE, _val, "flight_style"); };
}

var control_options =
[
    device_option,
    flight_style_option
];

controls_menu.options = array_concat(controls_menu.options, control_options);