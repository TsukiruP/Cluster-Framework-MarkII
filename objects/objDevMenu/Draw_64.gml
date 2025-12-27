/// @description Render
var font_height = 15;
if (not InputPartyGetJoin())
{
    for (var i = 0; i < array_length(current_menu.options); ++i)
    {
        var item = current_menu.options[i];
        var label = item.label;
        
        if (is_instanceof(item, dev_option_value))
        {
            label = $"{label}: {item.toString()}";
        }
        draw_set_color(current_menu.cursor == i ? c_white : c_gray);
        draw_text(10, i * font_height, label);
        draw_reset();
    }
    
    draw_set_valign(fa_bottom);
    draw_text(10, CAMERA_HEIGHT - 10, $"Confirm: {InputVerbGetBindingName(INPUT_VERB.CONFIRM)}\nCancel: {InputVerbGetBindingName(INPUT_VERB.CANCEL)}");
}
else
{
	for (var i = 0; i < INPUT_MAX_PLAYERS; ++i)
    {
        draw_text(10, i * font_height, $"Player {i}: {InputPlayerGetDevice(i)}");
    }
    
    draw_set_valign(fa_bottom);
    draw_text(10, CAMERA_HEIGHT - 10, $"Hold {InputVerbGetBindingName(INPUT_VERB.CONFIRM)} to Exit");
}

draw_reset();