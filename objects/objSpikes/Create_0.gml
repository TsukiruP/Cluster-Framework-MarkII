/// @description Initialize
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
    
    var hurtbox_flags = collision_player(0, pla);
    var attackbox_flags = collision_player(0, pla);
    
    if (hurtbox_flags)
    {
        var hurtbox_direction = collision_direction(hurtbox_flags);
        var hurtbox_difference = angle_wrap(hurtbox_direction - pla.gravity_direction);
        var gravity_difference = angle_wrap(gravity_direction - pla.gravity_direction);
        var x_dist = hex_to_dec((hurtbox_flags & 0x0FF00) >> 8);
        var y_dist = hex_to_dec(hurtbox_flags & 0x000FF);
        
        switch (hurtbox_difference)
        {
            case 90:
            {
                if (gravity_difference == 180 and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.y_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.y_radius) * dsin(gravity_direction);
                    pla.player_damage(id);
                }
                else if ((gravity_difference == 90 or gravity_difference == 270) and attackbox_flags and hidden_fix)
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
                        if (gravity_difference == hurtbox_difference - 90) pla.player_damage(id);
                    }
                }
                break;
            }
            case 270:
            {
                if (gravity_difference == 0 and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.y_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.y_radius) * dsin(gravity_direction);
                    pla.ground_id = id;
                    pla.player_damage(id);
                }
                else if ((gravity_difference == 90 or gravity_difference == 270) and attackbox_flags and hidden_fix)
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
                        if (gravity_difference == hurtbox_difference - 90) pla.player_damage(id);
                    }
                }
                break;
            }
            case 180:
            {
                if (gravity_difference == 270 and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.x_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.x_radius) * dsin(gravity_direction);
                    pla.player_damage(id);
                }
                else if (gravity_difference == 0 or gravity_difference == 180 and attackbox_flags and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.y_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.y_radius) * dsin(gravity_direction);
                    if (gravity_difference == 0) pla.ground_id = id;
                    pla.player_damage(id);
                }
                else
                {
                    pla.x += x_dist;
                    pla.y += y_dist;
                    if (pla.x_speed >= 0)
                    {
                        pla.x_speed = 0;
                        if (gravity_difference == hurtbox_difference - 90) pla.player_damage(id);
                    }
                }
                break;
            }
            case 0:
            {
                if (gravity_difference == 90 and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.x_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.x_radius) * dsin(gravity_direction);
                    pla.player_damage(id);
                }
                else if ((gravity_difference == 0 or gravity_difference == 180) and attackbox_flags and hidden_fix)
                {
                    if (gravity_direction mod 180 == 0) pla.y = y + (hitboxes[0].top - pla.y_radius) * dcos(gravity_direction);
                    else pla.x = x + (hitboxes[0].top - pla.y_radius) * dsin(gravity_direction);
                    if (gravity_difference == 0) pla.ground_id = id;
                    pla.player_damage(id);
                }
                else
                {
                    pla.x += x_dist;
                    pla.y += y_dist;
                    if (pla.x_speed <= 0)
                    {
                        pla.x_speed = 0;
                        if (gravity_difference == hurtbox_difference - 90) pla.player_damage(id);
                    }
                }
                break;
            }
        }
    }
};