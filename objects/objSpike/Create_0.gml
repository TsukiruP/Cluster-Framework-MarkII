/// @description Initialize
// Inherit the parent event
event_inherited();

direction = image_angle;
hitboxes[0].set_size(-16, -24, 16, 0);
reaction = function(pla)
{
    if (pla.state != player_is_hurt and pla.invincibility_time <= 0 and
        pla.invulnerability_time <= 0)
    {
        if (collision_player(0, pla) & COLL_TOP)
        {
            pla.on_ground = true;
            pla.ground_id = self;
            pla.y = y + hitboxes[0].top - pla.y_radius;
        }
        else if (pla.ground_id == self)
        {
            pla.ground_id = noone;
        }
        /*
        var diff = angle_wrap(direction - pla.gravity_direction);
        if (collision_player(0, pla) != 0)
        {
            switch (diff)
            {
                case 0:
                {
                    var is_floor = false;
                    with (pla) is_floor = (player_ray_collision(other, x_radius, y_radius + 1));
                    if (is_floor) pla.player_damage(self);
                    break;
                }
            }
        }
        */
    }
};