/// @description Behave
if (not InputPartyGetJoin())
{
    var input_axis_y = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
    menu_index.cursor += input_axis_y;
    menu_index.cursor = clamp_inverse(menu_index.cursor, 0, array_length(menu_index.options) - 1);
    
    var option_index = menu_index.options[menu_index.cursor];

    // Update
    if (is_instanceof(option_index, dev_option_value))
    {
        var input_axis_x = InputOpposingRepeat(INPUT_VERB.LEFT, INPUT_VERB.RIGHT);
        if (input_axis_x != 0) option_index.update(input_axis_x);
    }
    
    // Confirm
    if (InputPressed(INPUT_VERB.CONFIRM))
    {
        var confirm = option_index.confirm();
        // TODO: Play a sound depending on the return value of confirm
        // undefined obviously doesn't play anything.
    }
    
    // Cancel
    if (array_length(history) > 0 and InputPressed(INPUT_VERB.CANCEL))
    {
        menu_index = array_pop(history);
    }
}
else 
{
	// Exit
    if (InputPartyGetReady())
    {
        if (InputLong(INPUT_VERB.CONFIRM)) InputPartySetJoin(false);
    }
}