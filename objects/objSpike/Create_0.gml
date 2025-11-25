/// @description Initialize
// Inherit the parent event
event_inherited();

gravity_direction = image_angle;
hitboxes[0].set_size(-16, -24, 15, 0);
hitboxes[1] = new hitbox(c_green, -15, -24, 14, 0);
reaction = function(pla)
{
    var flags = collision_player(0, pla);
    if (flags)
    {
        if (flags & COLL_VERTICAL)
        {
            if (flags & COLL_TOP)
            {
                var dist = convert_hex(flags & 0x000FF);
                pla.y += dist;
                pla.ground_id = self;
                if (gravity_direction == 0 and (collision_player(1, pla) & COLL_TOP)) pla.player_damage(self);
            }
            else if (flags & COLL_BOTTOM)
            {
                var dist = convert_hex(flags & 0x000FF);
                pla.y += dist;
                pla.ceiling_id = self;
                if (gravity_direction == 180 and (collision_player(1, pla) & COLL_BOTTOM)) pla.player_damage(self);
            }
        }
        else if (flags & COLL_ANY)
        {
            var dist = convert_hex((flags & 0x0FF00) / 256);
            pla.x += dist;
            pla.x_speed = 0;
            if ((gravity_direction == 90 and (flags & COLL_LEFT)) or (gravity_direction == 270 and (flags & COLL_RIGHT))) pla.player_damage(self);
        }
    }
};