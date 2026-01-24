/// @description Start
var room_music = room_get_scene(room).music;
if (room_music != undefined) audio_enqueue_music(room_music, 0);