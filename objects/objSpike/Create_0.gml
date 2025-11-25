/// @description Initialize
// Inherit the parent event
event_inherited();

gravity_direction = image_angle;
hitboxes[0].set_size(-16, -24, 16, 0);
reaction = function(pla)
{
    if (pla.state != player_is_hurt and pla.invincibility_time <= 0 and
        pla.invulnerability_time <= 0)
    {
        var flags = collision_player(0, pla);
        if (flags & COLL_TOP)
        {
            var dist = (flags & 0x000FF);
            pla.on_ground = true;
            pla.ground_id = self;
            pla.y -= dist div 1;
        }
        else if (flags & COLL_BOTTOM)
        {
            var dist = (flags & 0x000FF);
            pla.y_speed = 0;
            pla.y += dist div 1;
        }
    }
};