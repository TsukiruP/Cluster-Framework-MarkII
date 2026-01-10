/// @description Setup
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-15, -17, 15, 15);

// Change index if debuffs are disabled
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
        if (not pla.on_ground and pla.y_speed > 0) pla.y_speed = -(pla.y_speed + 2 * pla.gravity_force);
        pla.player_obtain_item(index);
        image_index = 1;
        audio_play_single(sfxDestroy);
        particle_create(x, y + 15, global.ani_explosion_destroy_v0);
    }
};