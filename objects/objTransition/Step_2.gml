/// @description Animate
switch (index)
{
    case TRANSITION.FADE:
    {
        switch (state)
        {
            case FADE_STATE.IN:
            {
                if (fade_alpha == 1)
                {
                    state = FADE_STATE.WAIT;
                    fade_time = 60;
                    with (ctrlGame) game_paused |= PAUSE_FLAG_TRANSITION;
                }
                break;
            }
            case FADE_STATE.WAIT:
            {
                if (fade_time == 0)
                {
                    room_goto(target);
                    state = FADE_STATE.OUT;
                }
                break;
            }
            case FADE_STATE.OUT:
            {
                persistent = false;
                stage_start();
                with (ctrlGame) game_paused &= ~PAUSE_FLAG_TRANSITION;
                if (fade_alpha == 0) instance_destroy();
                break;
            }
        }
        break;
    }
    case TRANSITION.TITLE_CARD:
    {
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
        break;
    }
    case TRANSITION.TRY_AGAIN:
    {
        if (InputPressedMany(-1) and state == TRY_AGAIN_STATE.WAIT) state = TRY_AGAIN_STATE.RESET;
        
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
            message_width = string_width(message_text) div 2;
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
                    room_goto(target);
                    state = TRY_AGAIN_STATE.EXIT;
                }
                break;
            }
            case TRY_AGAIN_STATE.EXIT:
            {
                persistent = false;
                if (curtain_time == 0)
                {
                    stage_start();
                    instance_destroy();
                }
                break;
            }
        }
        break;
    }
}