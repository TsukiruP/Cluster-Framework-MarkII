/// @description Setup
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-15, -17, 15, 15);

reaction = function(pla)
{
    // Abort if broken or player is a cpu
    if (image_index != 0 or pla.player_index != 0) exit;
    
    if (collision_player(0, pla) or collision_player(0, pla, 0) or collision_player(0, pla, 1))
    {
        if (not pla.on_ground and pla.y_speed > 0) pla.y_speed = -(pla.y_speed + 2 * pla.gravity_force);
        pla.player_obtain_item(index);
        image_index = 1;
        audio_play_single(sfxDestroy);
        particle_create(x, y + 15, global.ani_explosion_enemy_v0);
    }
}