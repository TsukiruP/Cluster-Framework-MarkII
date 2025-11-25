/// @description Initialize
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-8, -8, 8, 8);
reaction = function(pla)
{
	if (collision_player(0, pla) and pla.invulnerability_time < 90)
    {
        pla.player_gain_rings(1);
        particle_create(x, y, global.ani_ring_sparkle_v0);
		instance_destroy();
    }
};