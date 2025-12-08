/// @description Update
if (not reset)
{
    // Inherit the parent event
    event_inherited();
    
    if (state == 1)
    {
        fall_time--;
        if (fall_time <= 0) state = 2;
    }
    else if (state == 2)
    {
        fall_time++;
        y_speed += gravity_force;
        y = y + y_speed;
    }
}