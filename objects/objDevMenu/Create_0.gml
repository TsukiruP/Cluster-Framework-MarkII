/// @description Initialize
image_speed = 0;

/// @function option(text, [select], [confirm], [val], [label], [offset])
/// @description Creates a new option.
/// @param {String} text Text to display.
/// @param {Function} [select] Predicate to run when the user inputs left or right. Should return true or false.
/// @param {Function} [confirm] Predicate to run when the user inputs confirm. Should return true or false.
/// @param {Function} [update] Callback to run every step.
/// @param {Array.String} [label] Labels to display based on the given value.
/// @param {Real} [offset] Amount to subtract from the value when using labels.
function option(text, select = undefined, confirm = undefined, update = function () {}, label = [], offset = 0) constructor
{
    text_string = text;
    select_function = select;
    confirm_function = confirm;
    update_function = update;
    value = undefined;
    value_labels = label;
    value_offset = offset;
}

player_option = new option("Player 1", undefined, undefined, function()
{
    value = db_read(global.save_database, CHARACTER.NONE, "character", 0);
},
["None", "Sonic", "Miles", "Knuckles", "Amy", "Cream"], CHARACTER.NONE);
home_menu[0] = player_option;