/// @description Setup
// Inherit the parent event
event_inherited();

gravity_direction = image_angle;
hitboxes[0].set_size(-16, -24, 15, 0);
reaction = function(pla)
{
    if (sprite_exists(sprite_index) and image_index == 0)
    {
        var flags = collision_player(0, pla);
        if (flags)
        {
            var x_dist = convert_hex((flags & 0x0FF00) >> 8);
            var y_dist = convert_hex(flags & 0x000FF);
            pla.x += x_dist;
            pla.y += y_dist;
            
            if (flags & COLL_FLAG_VERTICAL)
            {
                if (flags & COLL_FLAG_TOP)
                {
                    switch (pla.gravity_direction)
                    {
                        case 0:
                        {
                            if (pla.y_speed >= 0)
                            {
                                pla.ground_id = self;
                                if (gravity_direction == 0) pla.player_damage(self);
                            }
                            break;
                        }
                        case 90:
                        {
                            if (pla.x_speed <= 0)
                            {
                                pla.x_speed = 0;
                                if (gravity_direction == 0) pla.player_damage(self);
                            }
                            break;
                        }
                        case 180:
                        {
                            if (pla.y_speed <= 0) 
                            {
                                if (gravity_direction == 0) pla.player_damage(self);
                                pla.y_speed = 0;
                            }
                            break;
                        }
                        case 270:
                        {
                            if (pla.x_speed >= 0)
                            {
                                pla.x_speed = 0;
                                if (gravity_direction == 0) pla.player_damage(self);
                            }
                            break;
                        }
                    }
                }
                else if (flags & COLL_FLAG_BOTTOM)
                {
                    switch (pla.gravity_direction)
                    {
                        case 0:
                        {
                            if (pla.y_speed <= 0) 
                            {
                                if (gravity_direction == 180) pla.player_damage(self);
                                pla.y_speed = 0;
                            }
                            break;
                        }
                        case 90:
                        {
                            if (pla.x_speed >= 0) 
                            {
                                pla.x_speed = 0;
                                if (gravity_direction == 180) pla.player_damage(self);
                            }
                            break;
                        }
                        case 180:
                        {
                            if (pla.y_speed >= 0) 
                            {
                                pla.ground_id = self;
                                if (gravity_direction == 180) pla.player_damage(self);
                            }
                            break;
                        }
                        case 270:
                        {
                            if (pla.x_speed <= 0) 
                            {
                                pla.x_speed = 0;
                                if (gravity_direction == 180) pla.player_damage(self);
                            }
                            break;
                        }
                    }
                }
            }
            else if (flags & COLL_FLAG_HORIZONTAL)
            {
                if (flags & COLL_FLAG_RIGHT)
                {
                    switch (pla.gravity_direction)
                    {
                        case 0:
                        {
                            if (pla.x_speed <= 0) 
                            {
                                pla.x_speed = 0;
                                if (((gravity_direction == 0 or gravity_direction == 180) and x_dist > 6) or
                                    gravity_direction == 270) 
                                {
                                    pla.player_damage(self); 
                                }
                            }
                            break;
                        }
                        case 90:
                        {
                            if (pla.y_speed <= 0) 
                            {
                                if (gravity_direction == 270) pla.player_damage(self); 
                                pla.y_speed = 0;
                            }
                            break;
                        }
                        case 180:
                        {
                            if (pla.x_speed >= 0) 
                            {
                                pla.x_speed = 0;
                                if (((gravity_direction == 0 or gravity_direction == 180) and x_dist > 6) or
                                    gravity_direction == 270) 
                                {
                                    pla.player_damage(self); 
                                }
                            }
                            break;
                        }
                        case 270:
                        {
                            if (pla.y_speed >= 0)
                            {
                                pla.ground_id = self;
                                if (gravity_direction == 270) pla.player_damage(self);
                            }
                            break;
                        }
                    }
                }
                else if (flags & COLL_FLAG_LEFT)
                {
                    switch (pla.gravity_direction)
                    {
                        case 0:
                        {
                            if (pla.x_speed >= 0)
                            {
                                pla.x_speed = 0;
                                if (((gravity_direction == 0 or gravity_direction == 180) and x_dist < -6) or
                                    gravity_direction == 90) 
                                {
                                    pla.player_damage(self); 
                                }
                            }
                            break;
                        }
                        case 90:
                        {
                            if (pla.y_speed >= 0)
                            {
                                pla.ground_id = self;
                                if (gravity_direction == 90) pla.player_damage(self);
                            }
                            break;
                        }
                        case 180:
                        {
                            if (pla.x_speed <= 0)
                            {
                                pla.x_speed = 0;
                                if (((gravity_direction == 0 or gravity_direction == 180) and x_dist < -6) or
                                    gravity_direction == 90) 
                                {
                                    pla.player_damage(self); 
                                }
                            }
                            break;
                        }
                        case 270:
                        {
                            if (pla.y_speed <= 0)
                            {
                                if (gravity_direction == 90) pla.player_damage(self);
                                pla.y_speed = 0;
                            }
                            break;
                        }
                    }
                }
            }
        }
    }
};