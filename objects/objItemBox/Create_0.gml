/// @description Initialize
event_inherited();
hitboxes[0].set_size(-15, -17, 15, 15);

// Change debuffs to Eggman
if (not db_read(CONFIG_DATABASE, CONFIG_DEFAULT_DEBUFFS, "debuffs") and (index == ITEM.SLOW_DOWN or index == ITEM.CONFUSION))
{
    index = ITEM.EGGMAN;
}

reaction = function(_pla)
{
    // Abort if broken or player is a cpu
    if (image_index != 0 or _pla.player_index != 0) exit;
    
    var hurtbox_flags = [collision_player(0, _pla, 0), collision_player(0, _pla, 1)];
    if (hurtbox_flags[0] or hurtbox_flags[1])
    {
        if (not _pla.on_ground and _pla.state != player_is_trick_drill_clawing)
        {
            var in_shape = (_pla.gravity_direction mod 180 == 0 ?
                sign(_pla.y - y) * dcos(_pla.gravity_direction) :
                sign(_pla.x - x) * dsin(_pla.gravity_direction));
            
            if (_pla.y_speed < 0 or in_shape == 1)
            {
                _pla.y_speed -= sign(_pla.y_speed);
            }
            else if (_pla.y_speed >= 0 and in_shape == -1)
            {
                _pla.y_speed = -_pla.y_speed;
                if (_pla.state == player_is_aqua_bounding)
                {
                    _pla.player_perform(player_is_jumping);
                    audio_play_single(sfxAquaBound);
                }
                else if (_pla.state == player_is_trick_bounding)
                {
                    _pla.player_perform(player_is_trick_rebounding);
                }
            }
        }
        
        _pla.player_obtain_item(index);
        audio_play_single(sfxDestroy);
        particle_create(x, y + 15, global.ani_explosion_destroy_v0, image_angle);
        image_index = 1;
    }
};