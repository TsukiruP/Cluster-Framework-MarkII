/// @description Time
if (ctrlGame.game_paused & PAUSE_FLAG_MENU and not ignore_pause) exit;

switch (index)
{
    case TRANSITION.FADE:
    {
        if (fade_time > 0) fade_time--;
        
        switch (state)
        {
            case FADE_STATE.OUT:
            {
                if (fade_alpha > 0) fade_alpha -= fade_speed;
                break;
            }
            default:
            {
                if (fade_alpha < 1) fade_alpha += fade_speed;
            }
        }
        break;
    }
    case TRANSITION.TITLE_CARD:
    {
        if (title_card_time > 0) title_card_time--;
        
        // Fade
        if (state == TITLE_CARD_STATE.FADE)
        {
            if (fade_alpha < 1) fade_alpha += fade_speed;
        }
        else if (state != TITLE_CARD_STATE.FADE_WAIT)
        {
            // Curtain
            if (state < TITLE_CARD_STATE.EXIT)
            {
                if (curtain_time < curtain_duration) curtain_time++;
            }
            else if (curtain_time > 0)
            {
                curtain_time--;
            }
            
            // Banner
            if (state < TITLE_CARD_STATE.EXIT and curtain_time == curtain_duration)
            {
                if (banner_time < banner_duration) banner_time++;
            }
            else if (banner_time > 0)
            {
                banner_time--;
            }
            
            banner_scroll = modwrap(banner_scroll + banner_speed, 0, banner_height);
            
            // Zone
            if ((state < TITLE_CARD_STATE.EXIT and curtain_time == curtain_duration) or
                (state > TITLE_CARD_STATE.RESET and curtain_time == 0 and banner_time == 0))
            {
                if (zone_time < zone_duration) zone_time++;
            }
            
            // TODO: Zone has to account for when character entrances are ever added
        }
        break;
    }
    case TRANSITION.TRY_AGAIN:
    {
        if (try_again_time > 0) try_again_time--;
        
        // Curtain
        if (state < TRY_AGAIN_STATE.OPEN)
        {
            if (curtain_time < curtain_duration) curtain_time++;
        }
        else if (curtain_time > 0)
        {
            curtain_time--;
        }
        
        curtain_scroll = modwrap(curtain_scroll + curtain_speed, 0, curtain_width);
        
        // Message
        if (message_time < message_duration) message_time++;
        break;
    }
}