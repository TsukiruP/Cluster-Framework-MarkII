/// @description Initialize
event_inherited();
active = 0;
animation_data = new animation_core();
ani_spring = global.ani_spring_vertical;

reaction = function(_pla)
{
    var bit = 1 << _pla.player_index;
    var collision_hammer = false;
    
    // High Jump
    var collision_amy = false;
    if (_pla.object_index == objAmy)
    {
        with (_pla)
        {
            collision_amy = (animation_data.index == AMY_ANIMATION.AIR_HAMMER_ATTACK or animation_data.index == AMY_ANIMATION.HAMMER_JUMP);
            collision_amy = (collision_amy or state == player_is_trick_bounding or state == player_is_hammer_whirling);
        }
    }
    
    if (_pla.state == player_is_hammer_attacking or collision_amy)
    {
        if (collision_player(0, _pla, 1)) collision_hammer = true;
    }
    
    if (collision_hammer or collision_player(0, _pla))
    {
        if (active & bit == 0)
        {
            var diff = angle_wrap(direction - _pla.gravity_direction);
            if (diff == 90 or diff == 270)
            {
                _pla.player_perform(player_is_sprung);
                _pla.y_speed = -dsin(diff) * force;
            }
            else if (diff == 0 or diff == 180)
            {
                if (_pla.on_ground)
                {
                    _pla.control_lock_time = SPRING_DURATION;
                    if (_pla.on_ground and force > 9) _pla.boost_mode = true;
                }
                else
                {
                    _pla.player_perform(player_is_sprung);
                }
                
                _pla.image_xscale = image_xscale;
                _pla.x_speed = image_xscale * force;
            }
            else
            {
                _pla.player_perform(player_is_sprung);
                _pla.image_xscale = image_xscale;
                _pla.x_speed = image_xscale * force;
                _pla.y_speed = -dsin(diff) * force;
            }
            
            if (collision_hammer) _pla.y_speed *= 1.5;
            if (_pla.state == player_is_sprung) _pla.state_time = max(2, TRICK_LOCK_DURATION - (force / 1.5) div 1);
            
            _pla.aerial_flags = 0;
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