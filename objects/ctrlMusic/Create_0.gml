/// @description Setup
image_speed = 0;
fade_out = false;
mute = 0;
swap = false;

// Streams
music_stream = noone;
life_stream = noone;
drown_stream = noone;
jingle_streams = [];

// Music
music = ds_priority_create();
music_playing = false;

// Loop points
audio_loop_points(bgmExtraBattle1, 14.2224, 128.0002);