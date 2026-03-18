/// @description Initialize
event_inherited();
hitboxes[0].set_size(-32, -32, 30, 0);

reaction = function(_pla)
{
    var hurtbox_flags = collision_player(0, _pla);
    if (hurtbox_flags)
    {
        if ((hurtbox_flags & COLL_FLAG_RIGHT and image_xscale == 1 and _pla.x_speed <= 0) or 
            (hurtbox_flags & COLL_FLAG_LEFT and image_xscale == -1 and _pla.x_speed >= 0))
        {
            var x_dist = hex_to_dec((hurtbox_flags & 0x0FF00) >> 8);
            _pla.x += x_dist;
            _pla.x_speed = 0;
        }
        else
        {
            var hb_left = x + image_xscale * hitboxes[0].left;
            var hb_width = hitboxes[0].right - hitboxes[0].left;
            var hb_dist = image_xscale * (_pla.x - hb_left);
            if (hb_dist > 0)
            {
                if (hb_dist > hb_width)
                {
                    
                }
                else
                {
                    var pla_bottom = (_pla.y + _pla.y_radius) div 1;
                    var hb_floor = (y + hitboxes[0].top * (hb_dist / hb_width)) div 1;
                    if (pla_bottom >= hb_floor)
                    {
                        if (_pla.on_ground and abs(_pla.x_speed) > 4 and _pla.input_button.jump.check)
                        {
                            
                        }
                        else
                        {
                            _pla.y += hb_floor - pla_bottom;
                            _pla.solid_id = id;
                        }
                    }
                    else if (_pla.on_ground)
                    {
                        _pla.y += hb_floor - pla_bottom;
                        _pla.solid_id = id;
                    }
                }
            }
        }
    }
};