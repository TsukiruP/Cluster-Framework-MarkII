/// @description Setup
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-32, -32, 30, 0);
reaction = function(pla)
{
    var flags0 = collision_player(0, pla);
    if (flags0)
    {
        if (((flags0 & COLL_FLAG_RIGHT) and image_xscale == 1 and pla.x_speed <= 0) or 
            ((flags0 & COLL_FLAG_LEFT) and image_xscale == -1 and pla.x_speed >= 0))
        {
            var x_dist = convert_hex((flags0 & 0x0FF00) >> 8);
            pla.x += x_dist;
            pla.x_speed = 0;
        }
        else
        {
            var hb_left = x + image_xscale * hitboxes[0].left;
            var hb_width = hitboxes[0].right - hitboxes[0].left;
            var hb_dist = image_xscale * (pla.x - hb_left);
            if (hb_dist > 0)
            {
                if (hb_dist > hb_width)
                {
                    
                }
                else
                {
                    var pla_bottom = (pla.y + pla.y_radius) div 1;
                    var hb_floor = (y + hitboxes[0].top * (hb_dist / hb_width)) div 1;
                    if (pla_bottom >= hb_floor)
                    {
                        if (pla.on_ground and abs(pla.x_speed) > 4 and pla.input_button.jump.check)
                        {
                            
                        }
                        else
                        {
                            pla.y += hb_floor - pla_bottom;
                            pla.ground_id = self;
                        }
                    }
                    else if (pla.on_ground)
                    {
                        pla.y += hb_floor - pla_bottom;
                        pla.ground_id = self;
                    }
                }
            }
        }
    }
};