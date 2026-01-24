/// @description Time
if (ctrlGame.game_paused & PAUSE_FLAG_MENU and not ignore_pause) exit;

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