draw_text(10, 10, $"Swap: {swap}");
draw_text(10, 25, $"Mute: {mute}");
if (stream != -1) draw_text(10, 40, $"Position: {audio_sound_get_track_position(stream)}");