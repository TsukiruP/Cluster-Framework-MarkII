// Constants
#macro CAMERA_WIDTH 426
#macro CAMERA_HEIGHT 240
#macro CAMERA_PADDING 64

#macro DEPTH_AFTERIMAGE 75 
#macro DEPTH_PLAYER 50
#macro DEPTH_PARTICLE 25

enum CHARACTER
{
    NONE = -1,
    SONIC,
    MILES,
    KNUCKLES,
    AMY,
    CREAM
}

// Volumes
volume_sound = 1;
volume_music = 1;

// Player values
score = 0;
lives = 3;
rings = 0;

// Fonts
font_hud = font_add_sprite(sprFontHUD, ord("0"), false, 1);
font_lives = font_add_sprite(sprFontLives, ord("0"), false, 0);

// Misc.
surface_depth_disable(true);
randomize();
audio_channel_num(16);

// Create global controllers
call_later(1, time_source_units_frames, function ()
{
	instance_create_layer(0, 0, "Controllers", ctrlWindow);
	instance_create_layer(0, 0, "Controllers", ctrlMusic);
    room_goto(rmTest);
});

/* AUTHOR NOTE: this must be done one frame later as the first room will not have loaded yet.
 * also, while the manual recommends variables declared in scripts to have a global prefix, this is not done here.
 */