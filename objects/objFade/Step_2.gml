/// @description Animate
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