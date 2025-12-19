/// @description Setup
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-8, -8, 8, 8);
frame_speed = 8;
super = false;
value = 1;
x_speed = 0;
y_speed = 0;

target = noone;
magnet_range = 128;
magnetized = false;
follow_speed = 0.1875;
turn_speed = 0.75;

lost = false;
lifespan = 256;
gravity_force = 0.09375;
tilemaps = [layer_tilemap_get_id("TilesMain")];
semisolid_tilemap = layer_tilemap_get_id("TilesSemisolid");
reaction = function(pla)
{
	if (collision_player(0, pla) and pla.state != player_is_hurt and pla.invulnerability_time < 90)
    {
        pla.player_gain_rings(value, super);
        particle_create(x, y, global.ani_ring_sparkle_v0);
		instance_destroy();
    }
};