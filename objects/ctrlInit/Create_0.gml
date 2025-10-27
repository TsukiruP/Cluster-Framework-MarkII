/// @description Initialize
image_speed = 0;

// Macros
#macro CAMERA_ID view_camera[0]
#macro CAMERA_PADDING 64
#macro CAMERA_WIDTH 426
#macro CAMERA_HEIGHT 240

// Misc.
surface_depth_disable(true);
randomize();
audio_channel_num(16);

// Volumes
global.volume_sound = 1;
global.volume_music = 1;

// Player values
global.score = 0;
global.lives = 3;
global.rings = 0;

// Fonts
global.font_hud = font_add_sprite(sprFontHUD, ord("0"), false, 1);
global.font_lives = font_add_sprite(sprFontLives, ord("0"), false, 0);

// Setup particles
global.sprite_particles = {};
with (global.sprite_particles)
{
	system = part_system_create();
	
	ring_sparkle = part_type_create();
	part_type_life(ring_sparkle, 24, 24);
	part_type_sprite(ring_sparkle, sprRingSparkle, true, true, false);
	
	brake_dust = part_type_create();
	part_type_life(brake_dust, 16, 16);
	part_type_sprite(brake_dust, sprBrakeDust, true, true, false);
}

// Create global controllers
instance_create_layer(0, 0, "Controllers", ctrlWindow);
instance_create_layer(0, 0, "Controllers", ctrlInput);
instance_create_layer(0, 0, "Controllers", ctrlMusic);

room_goto(rmTest);