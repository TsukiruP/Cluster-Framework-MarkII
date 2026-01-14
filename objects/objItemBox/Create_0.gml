/// @description Setup
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-15, -17, 15, 15);

// Change debuffs to Eggman
if (not db_read(DATABASE_CONFIG, CONFIG_DEFAULT_DEBUFFS, "debuffs") and (index == ITEM.SLOW_DOWN or index == ITEM.CONFUSION))
{
    index = ITEM.EGGMAN;
}

reaction = function(pla)
{
    // Abort if broken or player is a cpu
    if (image_index != 0 or pla.player_index != 0) exit;
    
    var flags_hurtbox = [collision_player(0, pla, 0), collision_player(0, pla, 1)];
    if (flags_hurtbox[0] or flags_hurtbox[1])
    {
        if (not pla.on_ground and pla.state != player_is_trick_drill_clawing)
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
                if (pla.state == player_is_trick_bounding) pla.player_perform(player_is_trick_rebounding);
            }
        }
        image_index = 1;
        pla.player_obtain_item(index);
        pla.shield_action = true;
        pla.player_refresh_aerial_skills();
        audio_play_single(sfxDestroy);
        particle_create(x, y + 15, global.ani_explosion_destroy_v0);
    }
};