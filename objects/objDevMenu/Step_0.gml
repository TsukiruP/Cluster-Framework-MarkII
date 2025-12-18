/// @description Behave
if (not InputPartyGetJoin())
{
    var input_axis_y = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
    current_menu.cursor += input_axis_y;
    current_menu.cursor = wrap(current_menu.cursor, 0, array_length(current_menu.options) - 1);
    
    var item = current_menu.options[current_menu.cursor];

    // Update
    if (is_instanceof(item, option_value))
    {
        var input_axis_x = InputOpposingRepeat(INPUT_VERB.LEFT, INPUT_VERB.RIGHT);
        if (input_axis_x != 0) item.update(input_axis_x);
    }
    
    // Confirm
    if (InputPressed(INPUT_VERB.CONFIRM))
    {
        var confirm = item.confirm();
        // TODO: Play a sound depending on the return value of confirm
        // undefined obviously doesn't play anything.
    }
    
    // Cancel
    if (array_length(history) > 0 and InputPressed(INPUT_VERB.CANCEL))
    {
        current_menu = array_pop(history);
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