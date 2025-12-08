/// @description Setup
// Inherit the parent event
event_inherited();

crumble = false;
is_crumbled = false;
crumble_time = 0;
reset = false;
reaction = function(pla)
{
    // Abort if the player is not falling
    if (pla.gravity_direction != gravity_direction or pla.y_speed < 0 or is_crumbled) exit;
        
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
                crumble = true;
                pla.y += y_dist;
                pla.ground_id = self;
            }
        }
        else if (flags0 & (COLL_FLAG_LEFT | COLL_FLAG_RIGHT))
        {
            if (((flags0 & COLL_FLAG_LEFT) and pla.gravity_direction == 90) or 
                ((flags0 & COLL_FLAG_RIGHT) and pla.gravity_direction == 270))
            {
                crumble = true;
                pla.x += x_dist;
                pla.ground_id = self;
            }
        }
    }
}