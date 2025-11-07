/// @description Initialize
image_speed = 0;
hitboxes[0] = new hitbox(c_maroon, -8, -8, 8, 8);
reaction = function (player)
{
	if (player_in_hitbox(self, 0, player))
    {
        player.player_gain_rings(1);
        particle_create(x, y, global.ani_ring_sparkle_v0);
		instance_destroy();
    }
};