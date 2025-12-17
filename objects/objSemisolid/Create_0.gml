/// @description Setup
// Inherit the parent event
event_inherited();

reaction = function(pla)
{
    // Abort if the player is not falling
    if (pla.y_speed < 0) exit;
        
    var flags0 = collision_player(0, pla);
    if (flags0)
    {
        var x_dist = convert_hex((flags0 & 0x0FF00) >> 8);
        var y_dist = convert_hex(flags0 & 0x000FF);
        
        if (flags0 & (COLL_TOP | COLL_BOTTOM))
        {
            if (((flags0 & COLL_TOP) and pla.gravity_direction == 0) or 
                ((flags0 & COLL_BOTTOM) and pla.gravity_direction == 180))
            {
                sink_direction |= (flags0 & (COLL_TOP | COLL_BOTTOM));
                pla.y += y_dist;
                pla.ground_id = id;
            }
        }
        else if (flags0 & (COLL_LEFT | COLL_RIGHT))
        {
            if (((flags0 & COLL_LEFT) and pla.gravity_direction == 90) or 
                ((flags0 & COLL_RIGHT) and pla.gravity_direction == 270))
            {
                sink_direction |= (flags0 & (COLL_LEFT | COLL_RIGHT));
                pla.x += x_dist;
                pla.ground_id = id;
            }
        }
    }
}