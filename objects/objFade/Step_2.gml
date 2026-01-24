/// @description Animate
switch (state)
{
    case FADE_STATE.IN:
    {
        if (fade_alpha == 1)
        {
            state = FADE_STATE.WAIT;
            fade_time = 60;
        }
        break;
    }
    case FADE_STATE.WAIT:
    {
        if (fade_time == 0)
        {
            //room_goto(target);
            state = FADE_STATE.OUT;
        }
        break;
    }
    case FADE_STATE.OUT:
    {
        if (fade_alpha == 0) instance_destroy();
        break;
    }
}