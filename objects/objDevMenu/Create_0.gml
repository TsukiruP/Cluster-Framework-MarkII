/// @description Setup
image_speed = 0;
history = [];

#region Config

lives_option = new dev_option_bool("Lives");
lives_option.get = function() { return db_read(global.config_database, true, "lives"); };
lives_option.set = function(val) { db_write(global.config_database, val, "lives"); };

time_over_option = new dev_option_bool("Time Over");
time_over_option.get = function() { return db_read(global.config_database, true, "time_over"); };
time_over_option.set = function(val) { db_write(global.config_database, val, "time_over"); };

hud_option = new dev_option_int("HUD");
hud_option.get = function() { return db_read(global.config_database, HUD.CLUSTER, "hud"); };
hud_option.set = function(val) { db_write(global.config_database, val, "hud"); };
hud_option.clampinv = true;
hud_option.minimum = HUD.NONE;
hud_option.maximum = HUD.EPISODE_II;
hud_option.specifiers = ["None", "Cluster", "Adventure", "Adventure 2", "Advance 2", "Advance 3", "Episode II"];
hud_option.offset = HUD.NONE;

flicker_option = new dev_option_int("Flicker");
flicker_option.get = function() { return db_read(global.config_database, FLICKER.OFF, "flicker"); };
flicker_option.set = function(val) { db_write(global.config_database, val, "flicker"); };
flicker_option.clampinv = true;
flicker_option.minimum = FLICKER.OFF;
flicker_option.maximum = FLICKER.VIRTUAL_CONSOLE_ADVANCE_3;
flicker_option.specifiers = ["Off", "Original", "Virtual Console", "Virtual Console (Advance 3)"];

device_option = new dev_option("Device Setup");
device_option.confirm = function() { InputPartySetJoin(true); };

config_menu = new dev_menu([lives_option, time_over_option, hud_option, flicker_option, device_option]);

#endregion

#region Home

player_0_option = new dev_option_player(0);
player_1_option = new dev_option_player(1);

boost_option = new dev_option_bool("Boost");
boost_option.get = function() { return db_read(global.save_database, true, "boost"); };
boost_option.set = function(val) { db_write(global.save_database, val, "boost"); };

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

current_menu = home_menu;