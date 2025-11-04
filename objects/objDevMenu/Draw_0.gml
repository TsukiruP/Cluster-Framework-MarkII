/// @description Render
for (var i = 0; i < array_length(home_menu); i++)
{
    var text = home_menu[i].text_string;
    var val = home_menu[i].value - home_menu[i].value_offset;
    if (not is_undefined(val))
    {
        var label = home_menu[i].value_labels;
        if (array_length(label) > 0)
        {
            text = string_concat(text, ": " + label[val]);
        }
        else
        {
        	text = string_concat(text, ": " + string(val));
        }
    }
    draw_text(10, 10, text);
}