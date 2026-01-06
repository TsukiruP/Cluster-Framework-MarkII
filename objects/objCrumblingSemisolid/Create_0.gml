/// @description Setup
// Inherit the parent event
event_inherited();

is_crumbling = false;
crumbled = false;
crumble_time = 0;
reset = false;

reaction = function(pla)
{
    // Abort if the player is not falling
    if (pla.gravity_direction != gravity_direction or pla.y_speed < 0 or crumbled) exit;
        
    var flags0 = collision_player(0, pla);
    if (flags0)
    {
        var side_direction = collision_to_direction(flags0);
        var diff = angle_wrap(side_direction - pla.gravity_direction);
        var x_dist = hex_to_dec((flags0 & 0x0FF00) >> 8);
        var y_dist = hex_to_dec(flags0 & 0x000FF);
        
        if (diff == 90 and pla.y_speed >= 0)
        {
            is_crumbling = true;
            pla.x += x_dist * (side_direction mod 180 == 0);
            pla.y += y_dist * (side_direction mod 180 != 0);
            pla.y_speed = 0;
            pla.ground_id = id;
        }
    }
};