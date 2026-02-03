/// @description Initialize
event_inherited();
gravity_direction = angle_wrap(image_angle);

sink_direction = 0;
sink_shift = 7;
sink_left = 0;
sink_top = 0;
sink_right = 0;
sink_bottom = 0;

reaction = function(pla)
{
    var hurtbox_flags = collision_player(0, pla);
    if (hurtbox_flags)
    {
        var hurtbox_direction = collision_direction(hurtbox_flags);
        var hurtbox_difference = angle_wrap(hurtbox_direction - pla.gravity_direction);
        var x_dist = hex_to_dec((hurtbox_flags & 0x0FF00) >> 8);
        var y_dist = hex_to_dec(hurtbox_flags & 0x000FF);
        pla.x += x_dist;
        pla.y += y_dist;
        
        switch (hurtbox_difference)
        {
            case 90:
            {
                if (pla.y_speed >= 0)
                {
                    sink_direction |= (hurtbox_flags & 0xF0000);
                    pla.ground_id = id;
                }
                break;
            }
            case 180:
            {
                if (pla.x_speed >= 0) pla.x_speed = 0;
                break;
            }
            case 270:
            {
                if (pla.y_speed <= 0) pla.y_speed = 0;
                break;
            }
            case 0:
            {
                if (pla.x_speed <= 0) pla.x_speed = 0;
                break;
            }
        }
    }
};