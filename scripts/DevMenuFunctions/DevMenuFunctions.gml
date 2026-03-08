/// @description Creates a new menu.
/// @param {Array} options Options to display.
function dev_menu(_options = []) constructor
{
    options = _options;
    cursor = 0;
}

/// @description Adds the current menu to the history before going to the given menu.
/// @param {Struct.dev_menu} menu Menu to go to.
function dev_menu_goto(_menu)
{
    array_push(menu_history, menu_index);
    menu_index = _menu;
}

/// @description Goes to a character menu.
/// @param {Real} index Character to get the menu of.
function dev_menu_goto_character(_index)
{
    if (_index != CHARACTER.NONE)
    {
        with (objDevMenu)
        {
            var character_menus = [sonic_menu, miles_menu, knuckles_menu, amy_menu, cream_menu];
            dev_menu_goto(character_menus[_index]);
        }
    }
}

/// @description Creates a new option.
/// @param {String} label Label to display.
function dev_option(_label) constructor
{
    label = _label;
    confirm = function() {};
}

/// @description Creates a new value option.
/// @param {String} label Label to display.
function dev_option_value(_label) : dev_option(_label) constructor
{
    get = function() {};
    set = function(_val) {};
    update = function() {};
    toString = function() {};
}

/// @description Creates a new boolean option.
/// @param {String} label Label to display.
function dev_option_bool(_label) : dev_option_value(_label) constructor
{
    get = function() { return false; };
    update = function() { set(not get()); };
    toString = function() { return (get() ? "True" : "False")};
}

/// @description Creates a new real number option.
/// @param {String} label Label to display.
function dev_option_real(_label) : dev_option_value(_label) constructor
{
    increment = 1;
    clampinv = false;
    minimum = 0;
    maximum = 0;
    get = function() { return 0; };
    update = function(_dir)
    {
        var value = get() + _dir * increment;
        if (clampinv) value = clamp_inverse(value, minimum, maximum);
        else value = clamp(value, minimum, maximum);
        set(value);
        
    };
    toString =  function() { return string(get()); };
}

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

/// @description Creates a new array option.
/// @param {String} label Label to display.
function dev_option_array(_label) : dev_option_value(_label) constructor
{
    elements = [];
    index = 0;
    get = function() { return index; };
    set = function(_val) { index = clamp_inverse(index + _val, 0, array_length(elements) - 1); };
    update = function(_dir) { set(_dir); };
    toString = function() { return $"{elements[index]}"; };
}

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
    confirm = function() { dev_menu_goto_character(get()); };
    get = function() { return db_read(SAVE_DATABASE, CHARACTER.NONE, "character", player); };
    set = function(_val) { db_write(SAVE_DATABASE, _val, "character", player); };
}