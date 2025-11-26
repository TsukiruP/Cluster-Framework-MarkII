/// @description Setup
// Inherit the parent event
event_inherited();

gravity_direction = image_angle;
hitboxes[0].set_size(-15, -24, 14, 0);

reaction = function(pla)
{
    var flags = collision_player(0, pla);
    if (flags)
    {
        switch (gravity_direction)
        {
            case 0:
            {
                if (flags & COLL_TOP) pla.player_damage(self);
                break;
            }
        }
    }
};