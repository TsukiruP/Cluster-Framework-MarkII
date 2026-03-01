/// @function dev_menu(options)
/// @description Creates a new menu.
/// @param {Array} options Options to display.
function dev_menu(_options = []) constructor
{
    options = _options;
    cursor = 0;
}

/// @function dev_menu_goto(menu)
/// @description Sets the given menu as the current menu, adding to the dev menu's history.
/// @param {Struct.dev_menu} menu Menu to go to.
function dev_menu_goto(menu)
{
    array_push(history, menu_index);
    menu_index = menu;
}

/// @function dev_option(label)
/// @description Creates a new option.
/// @param {String} label Label to display.
function dev_option(_label) constructor
{
    label = _label;
    confirm = function() {};
}

/// @function dev_option_value(label)
/// @description Creates a new value option.
/// @param {String} label Label to display.
function dev_option_value(_label) : dev_option(_label) constructor
{
    get = function() {};
    set = function(val) {};
    update = function() {};
    toString = function() {};
}

/// @function dev_option_bool(label)
/// @description Creates a new boolean option.
/// @param {String} label Label to display.
function dev_option_bool(_label) : dev_option_value(_label) constructor
{
    get = function() { return false; };
    update = function() { set(not get()); };
    toString = function() { return (get() ? "True" : "False")};
}

/// @function dev_option_real(label)
/// @description Creates a new real number option.
/// @param {String} label Label to display.
function dev_option_real(_label) : dev_option_value(_label) constructor
{
    increment = 1;
    clampinv = false;
    minimum = 0;
    maximum = 0;
    get = function() { return 0; };
    update = function(dir)
    {
        var value = get() + dir * increment;
        if (clampinv) value = clamp_inverse(value, minimum, maximum);
        else value = clamp(value, minimum, maximum);
        set(value);
        
    };
    toString =  function() { return string(get()); };
}

/// @function dev_option_int(label)
/// @description Creates a new integer option.
/// @param {String} label Label to display.
function dev_option_int(_label) : dev_option_real(_label) constructor
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

/// @function dev_option_array(label)
/// @description Creates a new array option.
/// @param {String} label Label to display.
function dev_option_array(_label) : dev_option_value(_label) constructor
{
    elements = [];
    index = 0;
    get = function() { return index; };
    set = function(val) { index = clamp_inverse(index + val, 0, array_length(elements) - 1); };
    update = function(dir) { set(dir); };
    toString = function() { return $"{elements[index]}"; };
}

/// @function dev_option_player(player)
/// @description Creates a new player option.
/// @param {Real} player Player to display.
function dev_option_player(_player) : dev_option_int($"Player {_player}") constructor
{
    player = _player;
    clampinv = true;
    minimum = (player == 0 ? CHARACTER.SONIC : CHARACTER.NONE);
    maximum = CHARACTER.CREAM;
    specifiers = ["None", "Sonic", "Miles", "Knuckles", "Amy", "Cream"];
    offset = CHARACTER.NONE;
    get = function() { return db_read(SAVE_DATABASE, CHARACTER.NONE, "character", player); };
    set = function(val) { db_write(SAVE_DATABASE, val, "character", player); };
}