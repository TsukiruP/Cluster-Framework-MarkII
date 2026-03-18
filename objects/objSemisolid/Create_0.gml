/// @description Initialize
event_inherited();

reaction = function(_pla)
{
    // Abort if the player is not falling
    if (_pla.y_speed < 0) exit;
        
    var hurtbox_flags = collision_player(0, _pla);
    if (hurtbox_flags)
    {
        var hurtbox_direction = collision_direction(hurtbox_flags);
        var hurtbox_difference = angle_wrap(hurtbox_direction - _pla.gravity_direction);
        var x_dist = hex_to_dec((hurtbox_flags & 0x0FF00) >> 8);
        var y_dist = hex_to_dec(hurtbox_flags & 0x000FF);
        
        if (hurtbox_difference == 90 and _pla.y_speed >= 0)
        {
            sink_direction |= (hurtbox_flags & 0xF0000);
            _pla.x += x_dist;
            _pla.y += y_dist;
            _pla.y_speed = 0;
            _pla.solid_id = id;
        }
    }
};