/// @description Setup
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-15, -17, 15, 15);

reaction = function(pla)
{
    if (collision_player(0, pla) or collision_player(0, pla, 0) or collision_player(0, pla, 1))
    {
        pla.player_obtain_item(index);
        particle_create(x, y + 15, global.ani_explosion_enemy_v0);
        instance_create_depth(x, y, depth, objItemBoxBroken);
        instance_destroy();
    }
}