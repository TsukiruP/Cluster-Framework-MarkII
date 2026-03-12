/// @description Initialize
event_inherited();
active = 0;
animation_data = new animation_core();
ani_spring = global.ani_spring_vertical;

reaction = function(pla)
{
    var bit = 1 << pla.player_index;
    var collision_hammer = false;
    
    // High Jump
    var collision_amy = false;
    if (pla.object_index == objAmy)
    {
        with (pla)
        {
            collision_amy = (animation_data.index == AMY_ANIMATION.AIR_HAMMER_ATTACK or animation_data.index == AMY_ANIMATION.HAMMER_JUMP);
            collision_amy = (collision_amy or state == player_is_trick_bounding or state == player_is_hammer_whirling);
        }
    }
    
    if (pla.state == player_is_hammer_attacking or collision_amy)
    {
        if (collision_player(0, pla, 1)) collision_hammer = true;
    }
    
    if (collision_hammer or collision_player(0, pla))
    {
        if (active & bit == 0)
        {
            var diff = angle_wrap(direction - pla.gravity_direction);
            if (diff == 90 or diff == 270)
            {
                pla.player_perform(player_is_sprung);
                pla.y_speed = -dsin(diff) * force;
            }
            else if (diff == 0 or diff == 180)
            {
                if (pla.on_ground)
                {
                    pla.control_lock_time = SPRING_DURATION;
                    if (pla.on_ground and force > 9) pla.boost_mode = true;
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
                pla.y_speed = -dsin(diff) * force;
            }
            
            if (collision_hammer) pla.y_speed *= 1.5;
            if (pla.state == player_is_sprung) pla.state_time = max(2, TRICK_LOCK_DURATION - (force / 1.5) div 1);
            
            pla.aerial_flags = 0;
            active |= bit;
            animation_data.variant = 1;
            audio_play_single(sfxSpring);
        }
    }
    else 
    {
        active &= ~bit;
    }
};