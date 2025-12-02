/// @description Setup
// Inherit the parent event
event_inherited();

gravity_direction = angle_wrap(image_angle);
hitboxes[0].set_size(-16, -24, 15, 0);
hitboxes[1] = new hitbox(c_green, -15, -24, 14, 0);
hidden_fix = false;
reaction = function(pla)
{
    // Abort if the spike is hidden
    if (not sprite_exists(sprite_index) or image_index != 0) exit;
    
    var flags0 = collision_player(0, pla);
    var flags1 = collision_player(1, pla);
    if (flags0)
    {
        var x_dist = convert_hex((flags0 & 0x0FF00) >> 8);
        var y_dist = convert_hex(flags0 & 0x000FF);
        
        if (flags0 & COLL_FLAG_VERTICAL)
        {
            if (flags0 & COLL_FLAG_TOP)
            {
                switch (pla.gravity_direction)
                {
                    case 0:
                    {
                        if (pla.y_speed >= 0)
                        {
                            pla.y += y_dist;
                            pla.ground_id = self;
                            if (gravity_direction == 0) pla.player_damage(self);
                        }
                        break;
                    }
                    case 90:
                    {
                        if (pla.x_speed <= 0)
                        {
                            if (((gravity_direction == 90 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM | COLL_FLAG_LEFT))) or 
                                (gravity_direction == 270 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM | COLL_FLAG_RIGHT)))) and
                                hidden_fix)
                            {
                                if (gravity_direction == 90) pla.x = x + hitboxes[0].top - pla.y_radius;
                                else pla.x = x - hitboxes[0].top + pla.y_radius;
                                pla.player_damage(self);
                            }
                            else
                            {
                            	pla.y += y_dist;
                                pla.x_speed = 0;
                                if (gravity_direction == 0) pla.player_damage(self);
                            }
                        }
                        break;
                    }
                    case 180:
                    {
                        if (pla.y_speed <= 0) 
                        {
                            pla.y += y_dist;
                            if (gravity_direction == 0) pla.player_damage(self);
                            pla.y_speed = 0;
                        }
                        break;
                    }
                    case 270:
                    {
                        if (pla.x_speed >= 0)
                        {
                            if (((gravity_direction == 90 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM | COLL_FLAG_LEFT))) or 
                                (gravity_direction == 270 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM | COLL_FLAG_RIGHT)))) and
                                hidden_fix)
                            {
                                if (gravity_direction == 90) pla.x = x + hitboxes[0].top - pla.y_radius;
                                else pla.x = x - hitboxes[0].top + pla.y_radius;
                                pla.player_damage(self);
                            }
                            else
                            {
                            	pla.y += y_dist;
                                pla.x_speed = 0;
                                if (gravity_direction == 0) pla.player_damage(self);
                            }
                        }
                        break;
                    }
                }
            }
            else if (flags0 & COLL_FLAG_BOTTOM)
            {
                switch (pla.gravity_direction)
                {
                    case 0:
                    {
                        if (pla.y_speed <= 0) 
                        {
                            pla.y += y_dist;
                            if (gravity_direction == 180) pla.player_damage(self);
                            pla.y_speed = 0;
                        }
                        break;
                    }
                    case 90:
                    {
                        if (pla.x_speed >= 0) 
                        {
                            if (((gravity_direction == 90 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM | COLL_FLAG_LEFT))) or 
                                (gravity_direction == 270 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM | COLL_FLAG_RIGHT)))) and
                                hidden_fix)
                            {
                                if (gravity_direction == 90) pla.x = x + hitboxes[0].top - pla.y_radius;
                                else pla.x = x - hitboxes[0].top + pla.y_radius;
                                pla.player_damage(self);
                            }
                            else
                            {
                            	pla.y += y_dist;
                                pla.x_speed = 0;
                                if (gravity_direction == 180) pla.player_damage(self);
                            }
                        }
                        break;
                    }
                    case 180:
                    {
                        if (pla.y_speed >= 0) 
                        {
                            pla.y += y_dist;
                            pla.ground_id = self;
                            if (gravity_direction == 180) pla.player_damage(self);
                        }
                        break;
                    }
                    case 270:
                    {
                        if (pla.x_speed <= 0) 
                        {
                            if (((gravity_direction == 90 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM | COLL_FLAG_LEFT))) or 
                                (gravity_direction == 270 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM | COLL_FLAG_RIGHT)))) and
                                hidden_fix)
                            {
                                if (gravity_direction == 90) pla.x = x + hitboxes[0].top - pla.y_radius;
                                else pla.x = x - hitboxes[0].top + pla.y_radius;
                                pla.player_damage(self);
                            }
                            else
                            {
                            	pla.y += y_dist;
                                pla.x_speed = 0;
                                if (gravity_direction == 180) pla.player_damage(self);
                            }
                        }
                        break;
                    }
                }
            }
        }
        else if (flags0 & COLL_FLAG_HORIZONTAL)
        {
            if (flags0 & COLL_FLAG_RIGHT)
            {
                switch (pla.gravity_direction)
                {
                    case 0:
                    {
                        if (pla.x_speed <= 0) 
                        {
                            if (((gravity_direction == 0 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_LEFT | COLL_FLAG_RIGHT))) or 
                                (gravity_direction == 180 and (flags1 & (COLL_FLAG_BOTTOM | COLL_FLAG_LEFT | COLL_FLAG_RIGHT)))) and
                                hidden_fix)
                            {
                                if (gravity_direction == 0) pla.y = y + hitboxes[0].top - pla.y_radius;
                                else pla.y = y - hitboxes[0].top + pla.y_radius;
                                pla.player_damage(self);
                            }
                            else
                            {
                                pla.x += x_dist;
                                pla.x_speed = 0;
                                if (gravity_direction == 270) pla.player_damage(self);
                            }
                        }
                        break;
                    }
                    case 90:
                    {
                        if (pla.y_speed <= 0) 
                        {
                            pla.x += x_dist;
                            if (gravity_direction == 270) pla.player_damage(self); 
                            pla.y_speed = 0;
                        }
                        break;
                    }
                    case 180:
                    {
                        if (pla.x_speed >= 0) 
                        {
                            if (((gravity_direction == 0 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_LEFT | COLL_FLAG_RIGHT))) or 
                                (gravity_direction == 180 and (flags1 & (COLL_FLAG_BOTTOM | COLL_FLAG_LEFT | COLL_FLAG_RIGHT)))) and
                                hidden_fix)
                            {
                                if (gravity_direction == 0) pla.y = y + hitboxes[0].top - pla.y_radius;
                                else pla.y = y - hitboxes[0].top + pla.y_radius;
                                pla.player_damage(self);
                            }
                            else
                            {
                                pla.x += x_dist;
                                pla.x_speed = 0;
                                if (gravity_direction == 270) pla.player_damage(self);
                            }
                        }
                        break;
                    }
                    case 270:
                    {
                        if (pla.y_speed >= 0)
                        {
                            pla.x += x_dist;
                            pla.ground_id = self;
                            if (gravity_direction == 270) pla.player_damage(self);
                        }
                        break;
                    }
                }
            }
            else if (flags0 & COLL_FLAG_LEFT)
            {
                switch (pla.gravity_direction)
                {
                    case 0:
                    {
                        if (pla.x_speed >= 0)
                        {
                            if (gravity_direction == 270 and x_dist < 0 and hidden_fix)
                            {
                                pla.x = x - hitboxes[0].top + pla.x_radius;
                                pla.x_speed = 0;
                                pla.player_damage(self);
                            }
                            else if (((gravity_direction == 0 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_LEFT | COLL_FLAG_RIGHT))) or 
                                (gravity_direction == 180 and (flags1 & (COLL_FLAG_BOTTOM | COLL_FLAG_LEFT | COLL_FLAG_RIGHT)))) and
                                hidden_fix)
                            {
                                if (gravity_direction == 0) pla.y = y + hitboxes[0].top - pla.y_radius;
                                else pla.y = y - hitboxes[0].top + pla.y_radius;
                                pla.player_damage(self);
                            }
                            else
                            {
                                pla.x += x_dist;
                                pla.x_speed = 0;
                                if (gravity_direction == 90) pla.player_damage(self);
                            }
                        }
                        break;
                    }
                    case 90:
                    {
                        if (pla.y_speed >= 0)
                        {
                            pla.x += x_dist;
                            pla.ground_id = self;
                            if (gravity_direction == 90) pla.player_damage(self);
                        }
                        break;
                    }
                    case 180:
                    {
                        if (pla.x_speed <= 0)
                        {
                            if (gravity_direction == 270 and x_dist < 0 and hidden_fix)
                            {
                                pla.x = x - hitboxes[0].top + pla.x_radius;
                                pla.x_speed = 0;
                                pla.player_damage(self);
                            }
                            else if (((gravity_direction == 0 and (flags1 & (COLL_FLAG_TOP | COLL_FLAG_LEFT | COLL_FLAG_RIGHT))) or
                                (gravity_direction == 180 and (flags1 & (COLL_FLAG_BOTTOM | COLL_FLAG_LEFT | COLL_FLAG_RIGHT)))) and
                                hidden_fix)
                            {
                                if (gravity_direction == 0) pla.y = y + hitboxes[0].top - pla.y_radius;
                                else pla.y = y - hitboxes[0].top + pla.y_radius;
                                pla.player_damage(self);
                            }
                            else
                            {
                                pla.x += x_dist;
                                pla.x_speed = 0;
                                if (gravity_direction == 90) pla.player_damage(self);
                            }
                        }
                        break;
                    }
                    case 270:
                    {
                        if (pla.y_speed <= 0)
                        {
                            pla.x += x_dist;
                            if (gravity_direction == 90) pla.player_damage(self);
                            pla.y_speed = 0;
                        }
                        break;
                    }
                }
            }
        }
    }
};