/// @description Setup
// Inherit the parent event
event_inherited();

state = 0; // 0 - idle, 1 - delay, 2 - falling
usable = true;
fall_time = 0;
reset = false;
gravity_force = 42 / 256;
y_speed = 0;
reaction = function(pla)
{
    // Abort if the player is not falling
    if (pla.y_speed < 0 or not usable) exit;
        
    var flags0 = collision_player(0, pla);
    if (flags0)
    {
        var x_dist = convert_hex((flags0 & 0x0FF00) >> 8);
        var y_dist = convert_hex(flags0 & 0x000FF);
        
        if (flags0 & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM))
        {
            if (((flags0 & COLL_FLAG_TOP) and pla.gravity_direction == 0) or 
                ((flags0 & COLL_FLAG_BOTTOM) and pla.gravity_direction == 180))
            {
                sink_direction |= (flags0 & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM));
                pla.y += y_dist;
                pla.ground_id = id;
                
                if (state == 0)
                {
                    state = 1;
                    fall_time = 30;
                }
            }
        }
        else if (flags0 & (COLL_FLAG_LEFT | COLL_FLAG_RIGHT))
        {
            if (((flags0 & COLL_FLAG_LEFT) and pla.gravity_direction == 90) or 
                ((flags0 & COLL_FLAG_RIGHT) and pla.gravity_direction == 270))
            {
                sink_direction |= (flags0 & (COLL_FLAG_LEFT | COLL_FLAG_RIGHT));
                pla.x += x_dist;
                pla.ground_id = id;
                
                if (state == 0)
                {
                    state = 1;
                    fall_time = 30;
                }
            }
        }
    }
    
    if (usable and state == 2 and pla.ground_id == id and fall_time > 32)
    {
        usable = false;
        pla.ground_id = noone;
        pla.y_speed = y_speed;
    }
}