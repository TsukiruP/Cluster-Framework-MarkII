/// @description Update
if (not reset)
{
    // Inherit the parent event
    event_inherited();
    
    if (state == 1)
    {
        state_time--;
        if (state_time <= 0) state = 2;
    }
    else if (state == 2 or state == 3)
    {
        state_time++;
        y_speed += gravity_force;
        y = y + y_speed;
    }
}