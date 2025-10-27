global.sprite_particles = {};

with (global.sprite_particles)
{
	system = part_system_create();
	
	ring_sparkle = part_type_create();
	part_type_life(ring_sparkle, 16, 16);
	part_type_sprite(ring_sparkle, sprRingSparkle, true, false, false);
	
	brake_dust = part_type_create();
	part_type_life(brake_dust, 16, 16);
	part_type_sprite(brake_dust, sprBrakeDust, true, true, false);
}