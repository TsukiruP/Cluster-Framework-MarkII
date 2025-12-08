/// @description Animate
if (not reset)
{
    // Inherit the parent event
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
    usable = true;
    y_speed = 0;
    reset = false;
}