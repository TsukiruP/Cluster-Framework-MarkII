/// @description Setup
// Inherit the parent event
event_inherited();

reaction = function(pla)
{
    // Abort if the player is not falling
    if (pla.y_speed < 0) exit;
        
    var flags_hurtbox = collision_player(0, pla);
    if (flags_hurtbox)
    {
        var side_direction = collision_to_direction(flags_hurtbox);
        var side_diff = angle_wrap(side_direction - pla.gravity_direction);
        var x_dist = hex_to_dec((flags_hurtbox & 0x0FF00) >> 8);
        var y_dist = hex_to_dec(flags_hurtbox & 0x000FF);
        
        if (side_diff == 90 and pla.y_speed >= 0)
        {
            sink_direction |= (flags_hurtbox & 0xF0000);
            pla.x += x_dist;
            pla.y += y_dist;
            pla.y_speed = 0;
            pla.ground_id = id;
        }
    }
};