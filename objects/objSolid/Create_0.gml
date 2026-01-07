/// @description Setup
// Inherit the parent event
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
    var flags_hurtbox = collision_player(0, pla);
    if (flags_hurtbox)
    {
        var side_direction = collision_to_direction(flags_hurtbox);
        var side_diff = angle_wrap(side_direction - pla.gravity_direction);
        var x_dist = hex_to_dec((flags_hurtbox & 0x0FF00) >> 8);
        var y_dist = hex_to_dec(flags_hurtbox & 0x000FF);
        pla.x += x_dist;
        pla.y += y_dist;
        
        switch (side_diff)
        {
            case 90:
            {
                if (pla.y_speed >= 0)
                {
                    sink_direction |= (flags_hurtbox & 0xF0000);
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