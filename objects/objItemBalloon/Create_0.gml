/// @description Initialize
event_inherited();
hitboxes[0].set_size(-14, -16, 12, 8);
animation_data = new animation_core();
animation_set(global.ani_item_balloon_v0);

reaction = function(pla)
{
    // Abort if player is a cpu
    if (pla.player_index != 0) exit;
    
    var hurtbox_flags = [collision_player(0, pla, 0), collision_player(0, pla, 1)];
    if (hurtbox_flags[0] or hurtbox_flags[1])
    {
        if (pla.state != player_is_trick_drill_clawing)
        {
            var in_shape = (pla.gravity_direction mod 180 == 0 ?
                sign(pla.y - y) * dcos(pla.gravity_direction) :
                sign(pla.x - x) * dsin(pla.gravity_direction));
            
            if (pla.y_speed < 0 or in_shape == 1)
            {
                pla.y_speed -= sign(pla.y_speed);
            }
            else if (pla.y_speed >= 0 and in_shape == -1)
            {
                pla.y_speed = -pla.y_speed;
                if (pla.state == player_is_aqua_bounding)
                {
                    pla.player_perform(player_is_jumping);
                    audio_play_single(sfxAquaBound);
                }
                else if (pla.state == player_is_trick_bounding)
                {
                    pla.player_perform(player_is_trick_rebounding);
                }
            }
        }
        
        pla.aerial_flags = 0;
        pla.player_refresh_aerials();
        pla.player_obtain_item(index);
        audio_play_single(sfxDestroyBalloon);
        particle_create(x, y + 15, global.ani_explosion_destroy_v0, image_angle);
        instance_destroy();
    }
};