/// @description Initialize
#region Camera

// Constants
#macro CAMERA_WIDTH 426
#macro CAMERA_HEIGHT 240
#macro CAMERA_PADDING 64

// STANNcam
scale = 1;
stanncam_init(CAMERA_WIDTH, CAMERA_HEIGHT, CAMERA_WIDTH * scale, CAMERA_HEIGHT * scale);
global.main_camera = new stanncam();
global.main_camera.room_constrain = true;
global.main_camera.bounds_w = 8;
global.main_camera.bounds_h = 32;
global.main_camera.debug_draw = true;
stanncam_debug_set_draw_zones(true);
event_perform(ev_keypress, vk_f4);

#endregion

#region Audio

// Volumes
global.volume_sound = 1;
global.volume_music = 1;

// Music
queue = ds_priority_create();
stream = -1;
overlay = -1;
looping_tracks = [bgmMadGear];

/// @method set_music_loop(soundid, loop_start, loop_end)
/// @description Sets the loop points of the given music track.
/// @param {Asset.GMSound} soundid Sound asset to set loop points for.
/// @param {Real} loop_start Start point of the loop in seconds.
/// @param {Real} loop_end End point of the loop in seconds.
var set_music_loop = function (soundid, loop_start, loop_end)
{
	audio_sound_loop_start(soundid, loop_start);
	audio_sound_loop_end(soundid, loop_end);
	array_push(looping_tracks, soundid);
};

// TODO: define loops points for music (if applicable)
// Looping tracks that don't have loop points should be added directly into the array

/// @method play_music(soundid)
/// @description Plays the given music track, muting it if an overlay is playing, and sets it as the current stream.
/// @param {Asset.GMSound} soundid Sound asset to play.
play_music = function (soundid)
{
	audio_stop_sound(stream);
	stream = audio_play_sound(soundid, 1, array_contains(looping_tracks, soundid), global.volume_music * (overlay == -1));
};

#endregion

#region Player

// Constants
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

// Player values
global.score = 0;
global.lives = 3;
global.rings = 0;

#endregion

// Fonts
global.font_hud = font_add_sprite(sprFontHUD, ord("0"), false, 1);
global.font_lives = font_add_sprite(sprFontLives, ord("0"), false, 0);

// Misc.
surface_depth_disable(true);
randomize();
audio_channel_num(16);
room_goto(rmTest);