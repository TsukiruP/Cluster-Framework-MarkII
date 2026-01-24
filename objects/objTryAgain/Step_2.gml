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
    message_width = (string_width(message_text)) div 2;
    draw_set_font(-1);
}

if (state > TRY_AGAIN_STATE.RESET)
{
    message_x = interpolate(CAMERA_WIDTH / 2, -message_width - message_padding, message_time / message_duration, EASE_INOUT_BACK);
}
else
{
    message_x = interpolate(CAMERA_WIDTH + message_width + message_padding, CAMERA_WIDTH / 2, message_time / message_duration, EASE_INOUT_BACK);
}

switch (state)
{
    case TRY_AGAIN_STATE.ENTER:
    {
        if (curtain_time == curtain_duration)
        {
            state = TRY_AGAIN_STATE.WAIT;
            try_again_time = 60;
        }
        break;
    }
    case TRY_AGAIN_STATE.WAIT:
    {
        if (try_again_time == 0)
        {
            state = TRY_AGAIN_STATE.RESET;
        }
        break;
    }
    case TRY_AGAIN_STATE.RESET:
    {
        state = TRY_AGAIN_STATE.CLOSE;
        curtain_time = 0;
        message_time = 0;
        break;
    }
    case TRY_AGAIN_STATE.CLOSE:
    {
        if (curtain_time == curtain_duration and message_time == message_duration)
        {
            state = TRY_AGAIN_STATE.GOTO;
            try_again_time = 30;
        }
        break;
    }
    case TRY_AGAIN_STATE.GOTO:
    {
        if (try_again_time == 0)
        {
            //room_goto;
            state = TRY_AGAIN_STATE.EXIT;
        }
        break;
    }
    case TRY_AGAIN_STATE.EXIT:
    {
        if (curtain_time == 0)
        {
            instance_destroy();
        }
        break;
    }
}