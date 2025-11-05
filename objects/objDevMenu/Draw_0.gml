/// @description Render
if (not InputPartyGetJoin())
{
    for (var i = 0; i < array_length(current_menu.items); i++)
    {
        var item = current_menu.items[i];
        var label = item.text;
        
        if (is_instanceof(item, option_value))
        {
            label = string_concat(label, ": ", item.toString());
        }
        
        draw_set_color(current_menu.cursor == i ? c_white : c_gray);
        draw_text(10, 10 * i, label);
    }
}
else
{
	for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
    {
        draw_text(10, 10 * i, string_concat("Player", string(i), ": ", InputPlayerGetDevice(i)));
    }
}
draw_reset();