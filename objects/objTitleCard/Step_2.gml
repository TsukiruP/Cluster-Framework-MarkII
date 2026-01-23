/// @description Animate
curtain_y = interpolate(-15, CAMERA_HEIGHT + 15, curtain_time / curtain_duration, EASE_SMOOTHSTEP);
banner_x = interpolate(-sprite_get_width(sprTitleCardBanner), 0, banner_time / banner_duration, EASE_SMOOTHSTEP);

if (zone_width == -1)
{
    draw_set_font(global.font_title_card);
    zone_width = string_width(zone_test) + zone_padding;
    draw_set_font(-1);
}

if (state > TITLE_CARD_STATE.RESET)
{
    zone_x = interpolate(40, CAMERA_WIDTH + zone_padding, zone_time / zone_duration, EASE_INOUT_BACK);
}
else
{
    zone_x = interpolate(-zone_width, 40, zone_time / zone_duration, EASE_INOUT_BACK);
}

switch (state)
{
    case TITLE_CARD_STATE.FADE:
    {
        if (fade_alpha == 1)
        {
            with (ctrlStage) time_enabled = false;
            state = TITLE_CARD_STATE.FADE_WAIT;
            title_card_time = 50;
        }
        break;
    }
    case TITLE_CARD_STATE.FADE_WAIT:
    {
        if (title_card_time == 0)
        {
            state = TITLE_CARD_STATE.ENTER;
            fade_alpha = 0;
        }
        break;
    }
    case TITLE_CARD_STATE.ENTER:
    {
        if (banner_time == banner_duration and zone_time == zone_duration)
        {
            state = TITLE_CARD_STATE.ENTER_WAIT;
            title_card_time = 30;
        }
        break;
    }
    case TITLE_CARD_STATE.ENTER_WAIT:
    {
        state = TITLE_CARD_STATE.GOTO;
        title_card_time = 60;
        break;
    }
    case TITLE_CARD_STATE.GOTO:
    {
        if (title_card_time == 0)
        {
            //room_goto(target);
            state = TITLE_CARD_STATE.RESET;
            title_card_time = 90;
        }
        break;
    }
    case TITLE_CARD_STATE.RESET:
    {
        if (title_card_time == 0)
        {
            state = TITLE_CARD_STATE.EXIT;
            zone_time = 0;
        }
        break;
    }
    case TITLE_CARD_STATE.EXIT:
    {
        state = TITLE_CARD_STATE.END;
        break;
    }
    case TITLE_CARD_STATE.END:
    {
        if (curtain_time == 0 and banner_time == 0 and zone_time == zone_duration)
        {
            with (ctrlStage) time_enablde = true;
            instance_destroy();
        }
        break;
    }
}