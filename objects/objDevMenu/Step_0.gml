/// @description Behave

if (not InputPartyGetJoin())
{
    var input_axis_y = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
    current_menu.cursor += input_axis_y;
    current_menu.cursor = wrap(current_menu.cursor, 0, array_length(current_menu.items) - 1);
    
    var item = current_menu.items[current_menu.cursor];

    // Update
    if (is_instanceof(item, option_value))
    {
        var input_axis_x = InputOpposingRepeat(INPUT_VERB.LEFT, INPUT_VERB.RIGHT);
        if (input_axis_x != 0) item.update(input_axis_x);
    }
    
    // Confirm
    if (InputPressed(INPUT_VERB.CONFIRM))
    {
        confirm = item.confirm();
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