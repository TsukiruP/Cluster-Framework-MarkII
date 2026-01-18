/// @description Initialize
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
        
    var flags_hurtbox = collision_player(0, pla);
    if (flags_hurtbox)
    {
        var side_direction = collision_to_direction(flags_hurtbox);
        var side_diff = angle_wrap(side_direction - pla.gravity_direction);
        var x_dist = hex_to_dec((flags_hurtbox & 0x0FF00) >> 8);
        var y_dist = hex_to_dec(flags_hurtbox & 0x000FF);
        
        if (side_diff == 90 and pla.y_speed >= 0)
        {
            is_crumbling = true;
            pla.x += x_dist;
            pla.y += y_dist;
            pla.y_speed = 0;
            pla.ground_id = id;
        }
    }
};