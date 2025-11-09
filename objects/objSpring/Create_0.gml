/// @description Initialize
// Inherit the parent event
event_inherited();

active = 0;
animation_data = new animation_core();
ani_spring = global.ani_spring_vertical;
hitboxes[0] = new hitbox(c_maroon);
reaction = function(pla)
{
    var bit = 1 << pla.player_index;
    if (collision_player(0, pla) != 0)
    {
        if ((active & bit) == 0)
        {
            switch (abs(angle_difference(direction, pla.gravity_direction)))
            {
                case 0:
                {
                    pla.player_perform(player_is_sprung);
                    pla.y_speed = -image_yscale * force;
                    break;
                }
                case 90:
                {
                    if (not pla.on_ground) pla.player_perform(player_is_sprung);
                    // TODO: Set Boost Mode
                    pla.x_speed = image_xscale * force;
                    pla.image_xscale = image_xscale;
                    break;
                }
                case 45:
                {
                    pla.player_perform(player_is_sprung);
                    pla.x_speed = image_xscale * force;
                    pla.y_speed = -image_yscale * force;
                    pla.image_xscale = image_xscale;
                    break;
                }
            }
            active |= bit;
            animation_data.variant = 1;
            sound_play(sfxSpring);
        }
    }
    else 
    {
        active &= ~bit;
    }
};