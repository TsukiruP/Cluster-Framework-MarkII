/// @description Render
var font_height = 15;
if (not InputPartyGetJoin())
{
    for (var i = 0; i < array_length(menu_index.options); i++)
    {
        var option_index = menu_index.options[i];
        var label = option_index.label;
        
        if (is_instanceof(option_index, dev_option_value))
        {
            label = $"{label}: {option_index.toString()}";
        }
        draw_set_color(menu_index.cursor == i ? c_white : c_gray);
        draw_text(10, i * font_height, label);
        draw_reset();
    }
    
    draw_set_valign(fa_bottom);
    draw_text(10, CAMERA_HEIGHT - 10, $"Confirm: {InputVerbGetBindingName(INPUT_VERB.CONFIRM)}\nCancel: {InputVerbGetBindingName(INPUT_VERB.CANCEL)}");
}
else
{
	for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
    {
        draw_text(10, i * font_height, $"Player {i}: {InputPlayerGetDevice(i)}");
    }
    
    draw_set_valign(fa_bottom);
    draw_text(10, CAMERA_HEIGHT - 10, $"Hold {InputVerbGetBindingName(INPUT_VERB.CONFIRM)} to Exit");
}

draw_reset();