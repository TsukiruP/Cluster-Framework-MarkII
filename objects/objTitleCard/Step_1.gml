/// @description Time
if (ctrlGame.game_paused & PAUSE_FLAG_MENU and not ignore_pause) exit;

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
    if ((state < TITLE_CARD_STATE.EXIT and curtain_time == curtain_duration) or state > TITLE_CARD_STATE.RESET)
    {
        if (zone_time < zone_duration) zone_time++;
    }
}