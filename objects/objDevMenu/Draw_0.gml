/// @description Render
var font_height = 15;
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
        draw_text(10, font_height * i, label);
    }
}
else
{
	for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
    {
        draw_text(10, font_height * i, string_concat("Player", string(i), ": ", InputPlayerGetDevice(i)));
    }
}
draw_reset();