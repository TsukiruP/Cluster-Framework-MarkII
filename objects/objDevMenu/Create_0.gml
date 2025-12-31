/// @description Setup
image_speed = 0;
history = [];

#region Config

lives_option = new dev_option_bool("Lives");
with (lives_option)
{
    get = function() { return db_read(global.config_database, true, "lives"); };
    set = function(val) { db_write(global.config_database, val, "lives"); };
}

time_over_option = new dev_option_bool("Time Over");
with (time_over_option)
{
    get = function() { return db_read(global.config_database, true, "time_over"); };
    set = function(val) { db_write(global.config_database, val, "time_over"); };
}

hud_option = new dev_option_int("HUD");
with (hud_option)
{
    clampinv = true;
    minimum = HUD.NONE;
    maximum = HUD.EPISODE_II;
    specifiers = ["None", "Cluster", "Adventure", "Adventure 2", "Advance 2", "Advance 3", "Episode II"];
    offset = HUD.NONE;
    get = function() { return db_read(global.config_database, HUD.CLUSTER, "hud"); };
    set = function(val) { db_write(global.config_database, val, "hud"); };
}

flicker_option = new dev_option_int("Flicker");
with (flicker_option)
{
    clampinv = true;
    minimum = FLICKER.OFF;
    maximum = FLICKER.VIRTUAL_CONSOLE_ADVANCE_3;
    specifiers = ["Off", "Original", "Virtual Console", "Virtual Console (Advance 3)"];
    get = function() { return db_read(global.config_database, FLICKER.OFF, "flicker"); };
    set = function(val) { db_write(global.config_database, val, "flicker"); };
}

device_option = new dev_option("Device Setup");
device_option.confirm = function() { InputPartySetJoin(true); };

config_menu = new dev_menu([lives_option, time_over_option, hud_option, flicker_option, device_option]);

#endregion

#region Home

player_0_option = new dev_option_player(0);
player_1_option = new dev_option_player(1);

boost_option = new dev_option_bool("Boost");
with (boost_option)
{
    get = function() { return db_read(global.save_database, true, "boost"); };
    set = function(val) { db_write(global.save_database, val, "boost"); };
}

config_option = new dev_option("Config");
config_option.confirm = function() { dev_menu_goto(config_menu); }

test_option = new dev_option("Test Room");
test_option.confirm = function()
{
    room_goto(rmTestNew);
    return true;
};

home_menu = new dev_menu([player_0_option, player_1_option, boost_option, config_option, test_option]);

#endregion

menu_index = home_menu;