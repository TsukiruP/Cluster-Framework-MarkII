/// @description Initialize
image_speed = 0;

// Constants
#macro MUTE_MUSIC 1
#macro MUTE_JINGLE 2
#macro MUTE_DROWN 4
#macro PRIORITY_SOUND 0 
#macro PRIORITY_MUSIC 1
#macro PRIORITY_JINGLE 2
#macro PRIORITY_DROWN 3 

music = ds_priority_create();
music_voice = -1;
jingle_voices = [];
drown_voice = -1;
life_voice = -1;
mute = 0;
swap = false;
fade_out = false;
active = -1;