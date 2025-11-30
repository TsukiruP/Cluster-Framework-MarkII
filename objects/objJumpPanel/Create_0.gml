/// @description Setup
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-32, -32, 30, 0);
reaction = function(pla)
{
    var flags = collision_player(0, pla);
    if (flags)
    {
        var hb_left = x + hitboxes[0].left;
        var hb_width = hitboxes[0].right - hitboxes[0].left;
        var hb_dist = pla.x - hb_left;
        
        if (hb_dist > 0)
        {
            if (hb_dist > hb_width)
            {
                
            }
            else
            {
            	
                var pla_bottom = (pla.y + pla.y_radius) div 1;
                var hb_floor = (y + hitboxes[0].top * (hb_dist / hb_width)) div 1;
                
                pla.y += hb_floor - pla_bottom;
                pla.ground_id = self;
            }
        }
    }
};