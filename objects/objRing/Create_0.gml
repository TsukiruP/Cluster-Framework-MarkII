/// @description Setup
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-8, -8, 8, 8);
value = 1;
x_speed = 0;
y_speed = 0;
magnetized = false;
scattered = false;
lifespan = 256;
gravity_force = 0.09375;
tilemaps = [layer_tilemap_get_id("TilesMain")];
semisolid_tilemap = layer_tilemap_get_id("TilesSemisolid");
frame_speed = 8;
reaction = function(pla)
{
	if (collision_player(0, pla) and pla.state != player_is_hurt and pla.invulnerability_time < 90)
    {
        pla.player_gain_rings(value);
        particle_create(x, y, global.ani_ring_sparkle_v0);
		instance_destroy();
    }
};