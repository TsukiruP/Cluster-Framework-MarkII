/// @description Setup
image_speed = 0;

history = [];

#region Constructor Hell

/// @function menu(options)
/// @description Creates a menu.
/// @param {Array} options Options to display.
function menu(_options = []) constructor
{
    options = _options;
    cursor = 0;
}

/// @function option(label)
/// @description Creates a basic menu option.
/// @param {String} label Label to display.
function option (_label) constructor
{
    label = _label;
    confirm = function() {};
}

/// @function option_goto(label)
/// @description Creates a menu with a 
/// @param {String} label Label to display.
function option_goto(_label) : option(_label) constructor 
{
    option_next = undefined;
    confirm = function() { array_push(objDevMenu.history, objDevMenu.current_menu); objDevMenu.current_menu = option_next; };
}

/// @function option_value(label)
/// @description Creates a menu option with a value.
/// @param {String} label Label to display.
function option_value(_label) : option(_label) constructor 
{
    get = function() {};
    set = function() {};
    update = function() {};
    toString = function() {};
}

/// @function option_bool(label)
/// @description Creates a menu option with a boolean.
/// @param {String} label Label to display.
function option_bool(_label) : option_value(_label) constructor
{
    get = function() { return false; };
    set = function(val) {};
    update = function() { set(not get()); };
    toString = function() { return (get() ? "True" : "False")};
}

/// @function option_real(label)
/// @description Creates a menu option with a real number.
/// @param {String} label Label to display.
function option_real(_label) : option_value(_label) constructor
{
    increment = 1;
    can_wrap = false;
    minimum = 0;
    maximum = 0;
    get = function() { return 0; };
    update = function(dir)
    {
        var value = get() + dir * increment;
        if (can_wrap) value = wrap(value, minimum, maximum);
        else value = clamp (value, minimum, maximum);
        set(value);
        
    };
    toString =  function() { return string(get()); };
}

/// @function option_int(label)
/// @description Creates a menu with an integer number.
/// @param {String} label Label to display.
function option_int(_label) : option_real(_label) constructor
{
    specifiers = [];
    offset = 0;
    toString = function()
    {
        if (array_length(specifiers) > 0)
        {
            var index = get() - offset;
            return specifiers[index];
        }
        else
        {
            return string(get());
        }
    };
}

/// @function option_player(player)
/// @description Creates a menu with player data.
/// @param {Real} player Player to display.
function option_player(_player) : option_int($"Player {_player}") constructor 
{
    player = _player;
    can_wrap = true;
    minimum = (player == 0 ? CHARACTER.SONIC : CHARACTER.NONE);
    maximum = CHARACTER.CREAM;
    specifiers = ["None", "Sonic", "Miles", "Knuckles", "Amy", "Cream"];
    offset = CHARACTER.NONE;
    get = function() { return db_read(global.save_database, CHARACTER.NONE, "character", player); };
    set = function(val) { db_write(global.save_database, val, "character", player); };
}

#endregion

#region Config

lives_option = new option_bool("Lives");
lives_option.get = function() { return db_read(global.config_database, true, "lives"); };
lives_option.set = function(val) { db_write(global.config_database, val, "lives"); };

time_over_option = new option_bool("Time Over");
time_over_option.get = function() { return db_read(global.config_database, true, "time_over"); };
time_over_option.set = function(val) { db_write(global.config_database, val, "time_over"); };

hud_option = new option_int("HUD");
hud_option.get = function() { return db_read(global.config_database, HUD.CLUSTER, "hud"); };
hud_option.set = function(val) { db_write(global.config_database, val, "hud"); };
hud_option.can_wrap = true;
hud_option.minimum = HUD.NONE;
hud_option.maximum = HUD.EPISODE_II;
hud_option.specifiers = ["None", "Cluster", "Adventure", "Adventure 2", "Advance 2", "Advance 3", "Episode II"];
hud_option.offset = HUD.NONE;

device_option = new option("Device Setup");
device_option.confirm = function() { InputPartySetJoin(true); };

config_menu = new menu([lives_option, time_over_option, hud_option, device_option]);

#endregion

#region Home

player_0_option = new option_player(0);
player_1_option = new option_player(1);

boost_option = new option_bool("Boost");
boost_option.get = function() { return db_read(global.save_database, true, "boost"); };
boost_option.set = function(val) { db_write(global.save_database, val, "boost"); };

config_option = new option_goto("Config");
config_option.option_next = config_menu;

test_option = new option("Test Room");
test_option.confirm = function()
{
    room_goto(rmTestNew);
    return true;
};

home_menu = new menu([player_0_option, player_1_option, boost_option, config_option, test_option]);

#endregion

current_menu = home_menu;