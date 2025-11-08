/// @description Initialize
image_speed = 0;

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
function option_player(_player = 0) : option_int("Player " + string(_player)) constructor 
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

player_0_option = new option_player();
player_1_option = new option_player(1);

boost_option = new option_bool("Boost");
boost_option.get = function() { return db_read(global.save_database, true, "boost"); };
boost_option.set = function(val) { db_write(global.save_database, val, "boost"); };

device_option = new option("Device Setup");
device_option.confirm = function() { InputPartySetJoin(true); }

test_option = new option("Test Room");
test_option.confirm = function()
{
    room_goto(rmTestNew);
    return true;
};


character_menu = new menu([player_0_option, player_1_option, boost_option, device_option, test_option]);
current_menu = character_menu;