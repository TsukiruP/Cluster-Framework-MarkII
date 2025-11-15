/// @description Mute
if (InputPressed(INPUT_VERB.START) and not audio_is_playing(bgmExtraBattle1)) audio_swap_music(bgmExtraBattle1);

#region Drown

if (audio_is_playing(bgmLife))
{
    if ((mute & MUTE_DROWN) == 0)
    {
        mute |= MUTE_DROWN;
    }
}
else if (mute & MUTE_DROWN)
{
	mute &= ~MUTE_DROWN;
}

#endregion

#region Stream

if (swap)
{
    if (stream == -1 or audio_sound_get_gain(stream) <= 0)
    {
        if (stream != -1) audio_stop_sound(stream);
        if (array_length(music) > 0) stream = audio_play_sound(array_last(music), 1, true, global.volume_music * (mute == 0));
        swap = false;
    }
}

if (mute & MUTE_DROWN)
{
    if ((mute & MUTE_STREAM) == 0)
    {
        mute |= MUTE_STREAM;
        if (stream != -1) audio_sound_gain(stream, 0);
    }
}
else if (mute & MUTE_STREAM)
{
    mute &= ~MUTE_STREAM;
    if (stream != -1 and not swap) audio_sound_gain(stream, global.volume_music, 1000);
}

#endregion