/// @description Initialize
image_speed = 0;
fade_out = false;
mute = 0;
swap = false;

// Streams
music_soundid = noone;
life_soundid = noone;
drown_soundid = noone;
jingle_soundids = [];

// Music
music = ds_priority_create();
music_playing = false;