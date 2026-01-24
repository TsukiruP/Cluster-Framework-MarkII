/// @description Animate
// Curtain
if (state > TRY_AGAIN_STATE.RESET and state < TRY_AGAIN_STATE.EXIT)
{
    curtain_y = interpolate(32, CAMERA_HEIGHT / 2 + 15, curtain_time / curtain_duration, EASE_SMOOTHSTEP);
}
else if (state > TRY_AGAIN_STATE.GOTO)
{
    curtain_y = interpolate(-15, CAMERA_HEIGHT / 2 + 15, curtain_time / curtain_duration, EASE_SMOOTHSTEP);
}
else
{
    curtain_y = interpolate(-15, 32, curtain_time / curtain_duration, EASE_SMOOTHSTEP);
}

// Message
if (message_width == -1)
{
    draw_set_font(global.font_title_card);
    message_width = (string_width(message_text) + message_padding) div 2;
    draw_set_font(-1);
}

if (state > TRY_AGAIN_STATE.RESET)
{
    message_x = interpolate(CAMERA_WIDTH / 2 - message_width, -message_width, message_time / message_duration, EASE_INOUT_BACK);
}
else
{
    message_x = interpolate(CAMERA_WIDTH + message_width, CAMERA_WIDTH / 2, message_time / message_duration, EASE_INOUT_BACK);
}