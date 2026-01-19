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
        
    var hurtbox_flags = collision_player(0, pla);
    if (hurtbox_flags)
    {
        var hurtbox_direction = collision_direction(hurtbox_flags);
        var hurtbox_difference = angle_wrap(hurtbox_direction - pla.gravity_direction);
        var x_dist = hex_to_dec((hurtbox_flags & 0x0FF00) >> 8);
        var y_dist = hex_to_dec(hurtbox_flags & 0x000FF);
        
        if (hurtbox_difference == 90 and pla.y_speed >= 0)
        {
            is_crumbling = true;
            pla.x += x_dist;
            pla.y += y_dist;
            pla.y_speed = 0;
            pla.ground_id = id;
        }
    }
};