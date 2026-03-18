/// @description Initialize
event_inherited();
state = 0; // 0 - idle, 1 - delay, 2 - falling
state_time = 0;
reset = false;
gravity_force = 42 / 256;
y_speed = 0;

reaction = function(_pla)
{
    // Abort if the player is not falling
    if (_pla.y_speed < 0 or state == 3 or reset) exit;
        
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
            
            if (state == 0)
            {
                state = 1;
                state_time = 30;
            }
        }
        
        if (state == 2 and _pla.solid_id == id and state_time >= 32)
        {
            state = 3;
            _pla.aerial_flags |= AERIAL_FLAG_PLATFORM;
            _pla.y_speed = y_speed;
            _pla.on_ground = false;
            _pla.solid_id = noone;
        }
    }
}