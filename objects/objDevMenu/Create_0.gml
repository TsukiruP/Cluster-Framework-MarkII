/// @description Initialize
image_speed = 0;

#region Constructor Hell

/// @function menu(options)
/// @description Creates a menu.
/// @param {Array} options Options to display.
function menu(options = []) constructor
{
    items = options;
    cursor = 0;
}

/// @function option(label)
/// @description Creates a basic menu option.
/// @param {String} label Label to display.
function option (label) constructor
{
    text = label;
    confirm = function () {};
}

/// @function option_value(label)
/// @description Creates a menu option with a value.
/// @param {String} label Label to display.
function option_value(label) : option(label) constructor 
{
    get = function () {};
    set = function () {};
    update = function () {};
    toString = function () {};
}

/// @function option_bool(label)
/// @description Creates a menu option with a boolean.
/// @param {String} label Label to display.
function option_bool(label) : option_value(label) constructor
{
    get = function () { return false; };
    set = function (val) {};
    update = function () { set(!get()); };
    toString = function () { return (get() ? "True" : "False")};
}

/// @function option_real(label)
/// @description Creates a menu option with a real number.
/// @param {String} label Label to display.
function option_real(label) : option_value(label) constructor
{
    increment = 1;
    can_wrap = false;
    minimum = 0;
    maximum = 0;
    get = function () { return 0; };
    update = function (dir)
    {
        var value = get() + dir * increment;
        if (can_wrap) value = wrap(value, minimum, maximum);
        else value = clamp (value, minimum, maximum);
        set(value);
        
    };
    toString =  function () { return string(get()); };
}

/// @function option_int(label)
/// @description Creates a menu with an integer number.
/// @param {String} label Label to display.
function option_int(label) : option_real(label) constructor
{
    specifiers = [];
    offset = 0;
    toString = function ()
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
function option_player(player = 0) : option_int("Player " + string(player)) constructor 
{
    player_index = player;
    can_wrap = true;
    minimum = (player_index == 0 ? CHARACTER.SONIC : CHARACTER.NONE);
    maximum = CHARACTER.CREAM;
    specifiers = ["None", "Sonic", "Miles", "Knuckles", "Amy", "Cream"];
    offset = CHARACTER.NONE;
    get = function () { return db_read(global.save_database, CHARACTER.NONE, "character", player_index); };
    set = function (val) { db_write(global.save_database, val, "character", player_index); };
}

#endregion

player_0_option = new option_player();
player_1_option = new option_player(1);

boost_option = new option_bool("Boost");
boost_option.get = function () { return db_read(global.save_database, true, "boost"); };
boost_option.set = function (val) { db_write(global.save_database, val, "boost"); };

join_option = new option("Controller Setup");
join_option.confirm = function () { InputPartySetJoin(true); }

test_option = new option("Test Room");
test_option.confirm = function ()
{
    room_goto(rmTest);
    return true;
};


character_menu = new menu([player_0_option, player_1_option, boost_option, join_option, test_option]);
current_menu = character_menu;