/// @description Time
if (ctrlGame.game_paused & PAUSE_FLAG_MENU and not ignore_pause) exit;

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