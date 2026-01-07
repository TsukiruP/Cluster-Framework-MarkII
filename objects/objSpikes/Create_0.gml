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
    
    var flags_hurtbox = collision_player(0, pla);
    var flags_attackbox = collision_player(0, pla);
    
    if (flags_hurtbox)
    {
        var gravity_diff = angle_wrap(gravity_direction - pla.gravity_direction);
        var side_direction = collision_to_direction(flags_hurtbox);
        var side_diff = angle_wrap(side_direction - pla.gravity_direction);
        var x_dist = hex_to_dec((flags_hurtbox & 0x0FF00) >> 8);
        var y_dist = hex_to_dec(flags_hurtbox & 0x000FF);
        
        switch (side_diff)
        {
            case 90:
            {
                if (gravity_diff == 180 and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.y_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.y_radius) * dsin(gravity_direction);
                    pla.player_damage(id);
                }
                else if ((gravity_diff == 90 or gravity_diff == 270) and flags_attackbox and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.x_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.x_radius) * dsin(gravity_direction);
                    pla.player_damage(id);
                }
                else
                {
                    pla.x += x_dist;
                    pla.y += y_dist;
                    if (pla.y_speed >= 0)
                    {
                        pla.ground_id = id;
                        if (gravity_diff == side_diff - 90) pla.player_damage(id);
                    }
                }
                break;
            }
            case 270:
            {
                if (gravity_diff == 0 and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.y_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.y_radius) * dsin(gravity_direction);
                    pla.ground_id = id;
                    pla.player_damage(id);
                }
                else if ((gravity_diff == 90 or gravity_diff == 270) and flags_attackbox and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.x_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.x_radius) * dsin(gravity_direction);
                    pla.player_damage(id);
                }
                else
                {
                    pla.x += x_dist;
                    pla.y += y_dist;
                    if (pla.y_speed <= 0)
                    {
                        pla.x_speed = 0;
                        if (gravity_diff == side_diff - 90) pla.player_damage(id);
                    }
                }
                break;
            }
            case 180:
            {
                if (gravity_diff == 270 and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.x_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.x_radius) * dsin(gravity_direction);
                    pla.player_damage(id);
                }
                else if (gravity_diff == 0 or gravity_diff == 180 and flags_attackbox and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.y_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.y_radius) * dsin(gravity_direction);
                    if (gravity_diff == 0) pla.ground_id = id;
                    pla.player_damage(id);
                }
                else
                {
                    pla.x += x_dist;
                    pla.y += y_dist;
                    if (pla.x_speed >= 0)
                    {
                        pla.x_speed = 0;
                        if (gravity_diff == side_diff - 90) pla.player_damage(id);
                    }
                }
                break;
            }
            case 0:
            {
                if (gravity_diff == 90 and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.x_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.x_radius) * dsin(gravity_direction);
                    pla.player_damage(id);
                }
                else if ((gravity_diff == 0 or gravity_diff == 180) and flags_attackbox and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.y_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.y_radius) * dsin(gravity_direction);
                    if (gravity_diff == 0) pla.ground_id = id;
                    pla.player_damage(id);
                }
                else
                {
                    pla.x += x_dist;
                    pla.y += y_dist;
                    if (pla.x_speed <= 0)
                    {
                        pla.x_speed = 0;
                        if (gravity_diff == side_diff - 90) pla.player_damage(id);
                    }
                }
                break;
            }
        }
    }
};