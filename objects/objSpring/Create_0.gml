/// @description Initialize
// Inherit the parent event
event_inherited();

active = 0;
animation_data = new animation_core();
ani_spring = global.ani_spring_vertical;
reaction = function(pla)
{
    var bit = 1 << pla.player_index;
    if (collision_player(0, pla) != 0)
    {
        if ((active & bit) == 0)
        {
            var diff = angle_wrap(direction - pla.gravity_direction);
            if (diff == 90 or diff == 270)
            {
                pla.player_perform(player_is_sprung);
                pla.y_speed = dsin(diff) * force;
            }
            else if (diff == 0 or diff == 180)
            {
                if (pla.on_ground)
                {
                    pla.control_lock_time = pla.spring_duration;
                    // TODO: Set Boost Mode
                }
                else
                {
                    pla.player_perform(player_is_sprung);
                }
                pla.image_xscale = image_xscale;
                pla.x_speed = image_xscale * force;
            }
            else
            {
                pla.player_perform(player_is_sprung);
                pla.image_xscale = image_xscale;
                pla.x_speed = image_xscale * force;
                pla.y_speed = dsin(diff) * force;
            }
            active |= bit;
            pla.player_gain_rings(1);
            animation_data.variant = 1;
            sound_play(sfxSpring);
        }
    }
    else 
    {
        active &= ~bit;
    }
};