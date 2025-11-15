/// @description Initialize
image_speed = 0;

// Constants
#macro MUTE_DROWN 1
#macro MUTE_JINGLE 2
#macro MUTE_MUSIC 4 

music = ds_priority_create();
music_voice = -1;
jingle_voices = [];
drown_voice = -1;
life_voice = -1;
mute = 0;
swap = false;