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
                    transition_time = 60;
                    with (ctrlGame) game_paused |= PAUSE_FLAG_TRANSITION;
                }
                break;
            }
            case FADE_STATE.WAIT:
            {
                if (transition_time == 0)
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
        if (text_width == -1)
        {
            draw_set_font(global.font_title_card);
            zone_text = (target_scene.zone ?? "Green Hill");
            text_width = string_width(zone_text);
            draw_set_font(-1);
        }
        
        if (state > TITLE_CARD_STATE.RESET)
        {
            zone_x = interpolate(40, CAMERA_WIDTH + text_padding, zone_time / zone_duration, EASE_INOUT_BACK);
        }
        else
        {
            zone_x = interpolate(-text_width - text_padding, 40, zone_time / zone_duration, EASE_INOUT_BACK);
        }
        
        switch (state)
        {
            case TITLE_CARD_STATE.FADE:
            {
                if (fade_alpha == 1)
                {
                    state = TITLE_CARD_STATE.FADE_WAIT;
                    transition_time = 50;
                    with (ctrlGame) game_paused |= PAUSE_FLAG_TRANSITION;
                    with (ctrlStage) time_enabled = false;
                }
                break;
            }
            case TITLE_CARD_STATE.FADE_WAIT:
            {
                if (transition_time == 0) state = TITLE_CARD_STATE.ENTER;
                break;
            }
            case TITLE_CARD_STATE.ENTER:
            {
                if (banner_time == banner_duration and zone_time == zone_duration)
                {
                    state = TITLE_CARD_STATE.ENTER_WAIT;
                    transition_time = 30;
                    fade_alpha = 0;
                }
                break;
            }
            case TITLE_CARD_STATE.ENTER_WAIT:
            {
                if (transition_time == 0)
                {
                    state = TITLE_CARD_STATE.GOTO;
                    transition_time = 60;
                }
                break;
            }
            case TITLE_CARD_STATE.GOTO:
            {
                if (transition_time == 0)
                {
                    room_goto(target);
                    state = TITLE_CARD_STATE.RESET;
                    transition_time = 120;
                }
                break;
            }
            case TITLE_CARD_STATE.RESET:
            {
                persistent = false;
                with (ctrlGame) game_paused &= ~PAUSE_FLAG_TRANSITION;
                if (transition_time == 0)
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
        
        // Try Again
        if (text_width == -1)
        {
            draw_set_font(global.font_title_card);
            text_width = string_width(try_again_text) div 2;
            draw_set_font(-1);
        }
        
        if (state > TRY_AGAIN_STATE.RESET)
        {
            try_again_x = interpolate(CAMERA_WIDTH / 2, -text_width - text_padding, try_again_time / try_again_duration, EASE_INOUT_BACK);
        }
        else
        {
            try_again_x = interpolate(CAMERA_WIDTH + text_width + text_padding, CAMERA_WIDTH / 2, try_again_time / try_again_duration, EASE_INOUT_BACK);
        }
        
        switch (state)
        {
            case TRY_AGAIN_STATE.ENTER:
            {
                if (curtain_time == curtain_duration)
                {
                    state = TRY_AGAIN_STATE.WAIT;
                    transition_time = 60;
                }
                break;
            }
            case TRY_AGAIN_STATE.WAIT:
            {
                if (transition_time == 0)
                {
                    state = TRY_AGAIN_STATE.RESET;
                }
                break;
            }
            case TRY_AGAIN_STATE.RESET:
            {
                state = TRY_AGAIN_STATE.CLOSE;
                curtain_time = 0;
                try_again_time = 0;
                break;
            }
            case TRY_AGAIN_STATE.CLOSE:
            {
                if (curtain_time == curtain_duration and try_again_time == try_again_duration)
                {
                    state = TRY_AGAIN_STATE.GOTO;
                    transition_time = 30;
                }
                break;
            }
            case TRY_AGAIN_STATE.GOTO:
            {
                if (transition_time == 0)
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
    case TRANSITION.GAME_OVER:
    {
        // Game Over
        if (text_width == -1)
        {
            draw_set_font(global.font_title_card);
            text_width = string_width(game_over_text) div 2;
            draw_set_font(-1);
        }
        
        game_over_x = interpolate(CAMERA_WIDTH + text_width + text_padding, CAMERA_WIDTH / 2, game_over_time / game_over_duration, EASE_INOUT_BACK);
        
        switch (state)
        {
            case GAME_OVER_STATE.ENTER:
            {
                state = GAME_OVER_STATE.WAIT;
                transition_time = 60;
                audio_stop_sound(bgmInvincibility);
                audio_stop_sound(bgmSpeedUp);
                audio_clear_music();
                break;
            }
            case GAME_OVER_STATE.WAIT:
            {
                if (transition_time == 0)
                {
                    state = GAME_OVER_STATE.JINGLE;
                    transition_time = audio_sound_length(bgmGameOver) * 60 div 1;
                    audio_play_single(bgmGameOver);
                    audio_stop_sound(bgmLife);
                }
                break;
            }
            case GAME_OVER_STATE.JINGLE:
            {
                if (transition_time == 0)
                {
                    state = GAME_OVER_STATE.FADE;
                }
                break;
            }
            case GAME_OVER_STATE.FADE:
            {
                if (fade_alpha == 1)
                {
                    state = GAME_OVER_STATE.GOTO;
                    transition_time = 90;
                }
                break;
            }
            case GAME_OVER_STATE.GOTO:
            {
                if (transition_time == 0)
                {
                    room_goto(rmDevMenu);
                    state = GAME_OVER_STATE.EXIT;
                }
                break;
            }
            case GAME_OVER_STATE.EXIT:
            {
                persistent = false;
                global.life_count = 3;
                if (fade_alpha == 0) instance_destroy();
                break;
            }
        }
    }
}