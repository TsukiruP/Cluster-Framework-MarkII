/// @description Setup
// Inherit the parent event
event_inherited();

gravity_direction = angle_wrap(image_angle);
reaction = function(pla)
{
    var flags0 = collision_player(0, pla);
    if (flags0)
    {
        var x_dist = convert_hex((flags0 & 0x0FF00) >> 8);
        var y_dist = convert_hex(flags0 & 0x000FF);
        
        if (flags0 & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM))
        {
            if (flags0 & COLL_FLAG_TOP)
            {
                switch (pla.gravity_direction)
                {
                    case 0:
                    {
                        pla.y += y_dist;
                        if (pla.y_speed >= 0) pla.ground_id = self;
                        break;
                    }
                    case 90:
                    {
                        pla.y += y_dist;
                        if (pla.x_speed <= 0) pla.x_speed = 0;
                        break;
                    }
                    case 180:
                    {
                        pla.y += y_dist;
                        if (pla.y_speed <= 0) pla.y_speed = 0;
                        break;
                    }
                    case 270:
                    {
                        pla.y += y_dist;
                        if (pla.x_speed >= 0) pla.x_speed = 0;
                        break;
                    }
                }
            }
        }
    }
}