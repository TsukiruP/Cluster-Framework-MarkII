/// @description Setup
// Inherit the parent event
event_inherited();

gravity_direction = image_angle;
hitboxes[0].set_size(-16, -24, 15, 0);
reaction = function(pla)
{
    var flags = collision_player(0, pla);
    if (flags)
    {
        var x_dist = convert_hex((flags & 0x0FF00) >> 8);
        var y_dist = convert_hex(flags & 0x000FF);
        pla.x += x_dist;
        pla.y += y_dist;
        
        if (flags & COLL_VERTICAL)
        {
            if (flags & COLL_TOP)
            {
                if (pla.gravity_direction == 0) pla.ground_id = self;
            }
        }
        else if (flags & COLL_LEFT)
        {
            if (pla.input_button.select.check) pla.y = 0;
            pla.x_speed = 0;
        }
    }
};