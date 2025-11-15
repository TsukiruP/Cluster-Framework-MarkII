/// @description Mute
if (audio_is_playing(bgmLife))
{
    if (not drown_mute)
    {
        drown_mute = true;
    }
}
else if (drown_mute)
{
	drown_mute = false;
}

if (drown_mute)
{
    if (not stream_mute)
    {
        stream_mute = true;
        if (stream != -1) audio_sound_gain(stream, 0);
    }
}
else if (stream_mute)
{
    stream_mute = false;
    if (stream != -1) audio_sound_gain(stream, global.volume_music, 1000);
}