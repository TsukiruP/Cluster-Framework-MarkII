/// @description Animate
visible = (ctrlGame.game_flags & GAME_FLAG_HIDE_HUD ? false : true);

curtain_y = interpolate(-15, CAMERA_HEIGHT + 15, curtain_time / curtain_duration, EASE_SMOOTHSTEP);
banner_x = interpolate(-banner_width, 0, banner_time / banner_duration, EASE_SMOOTHSTEP);

// Zone
if (zone_width == -1)
{
    draw_set_font(global.font_title_card);
    zone_text = (target_scene.zone ?? "Green Hill");
    zone_width = string_width(zone_text);
    draw_set_font(-1);
}

if (state > TITLE_CARD_STATE.RESET)
{
    zone_x = interpolate(40, CAMERA_WIDTH + zone_padding, zone_time / zone_duration, EASE_INOUT_BACK);
}
else
{
    zone_x = interpolate(-zone_width - zone_padding, 40, zone_time / zone_duration, EASE_INOUT_BACK);
}

switch (state)
{
    case TITLE_CARD_STATE.FADE:
    {
        if (fade_alpha == 1)
        {
            state = TITLE_CARD_STATE.FADE_WAIT;
            title_card_time = 50;
            with (ctrlGame) game_paused |= PAUSE_FLAG_TRANSITION;
            with (ctrlStage) time_enabled = false;
        }
        break;
    }
    case TITLE_CARD_STATE.FADE_WAIT:
    {
        if (title_card_time == 0) state = TITLE_CARD_STATE.ENTER;
        break;
    }
    case TITLE_CARD_STATE.ENTER:
    {
        if (banner_time == banner_duration and zone_time == zone_duration)
        {
            state = TITLE_CARD_STATE.ENTER_WAIT;
            title_card_time = 30;
            fade_alpha = 0;
        }
        break;
    }
    case TITLE_CARD_STATE.ENTER_WAIT:
    {
        if (title_card_time == 0)
        {
            state = TITLE_CARD_STATE.GOTO;
            title_card_time = 60;
        }
        break;
    }
    case TITLE_CARD_STATE.GOTO:
    {
        if (title_card_time == 0)
        {
            room_goto(target);
            state = TITLE_CARD_STATE.RESET;
            title_card_time = 120;
        }
        break;
    }
    case TITLE_CARD_STATE.RESET:
    {
        persistent = false;
        with (ctrlGame) game_paused &= ~PAUSE_FLAG_TRANSITION;
        if (title_card_time == 0)
        {
            state = TITLE_CARD_STATE.EXIT;
            zone_time = 0;
        }
        break;
    }
    case TITLE_CARD_STATE.EXIT:
    {
        stage_start();
        if (curtain_time == 0 and banner_time == 0 and zone_time == zone_duration) instance_destroy();
        break;
    }
}