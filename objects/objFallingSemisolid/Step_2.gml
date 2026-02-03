/// @description Animate
if (ctrlGame.game_paused) exit;

if (not reset)
{
    event_inherited();
    
    if (state != 0 and not instance_in_view(id, 128))
    {
        x = xstart;
        y = ystart;
        reset = true;
    }
}
else if (not instance_in_view(id, 128))
{
    state = 0;
    y_speed = 0;
    reset = false;
}