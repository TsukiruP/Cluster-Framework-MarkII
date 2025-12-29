/// @description Update
music_playing = audio_is_playing(music_voice);

if (fade_out)
{
    if (audio_get_master_gain(0) > 0)
    {
        audio_master_gain(audio_get_master_gain(0) - 0.01);
        if (audio_get_master_gain(0) == 0)
        {
            fade_out = false;
            audio_stop_all();
            audio_master_gain(1);
        }
    }
}

#region Drown

if (audio_is_playing(life_voice))
{
    if ((mute & MUTE_FLAG_DROWN) == 0)
    {
        mute |= MUTE_FLAG_DROWN;
    }
}
else if (mute & MUTE_FLAG_DROWN)
{
    mute &= ~MUTE_FLAG_DROWN;
}

#endregion

#region Jingles

for (var i = 0; i < array_length(jingle_voices); i++)
{
    if (not audio_is_playing(jingle_voices[i])) array_delete(jingle_voices, i, 1);
}

// TODO: Check if drowning is playing
if (mute & MUTE_FLAG_DROWN)
{
    if ((mute & MUTE_FLAG_JINGLE) == 0)
    {
        mute |= MUTE_FLAG_JINGLE;
        if (array_length(jingle_voices) > 0) audio_sound_gain(array_last(jingle_voices), 0);
    }
}
else if (mute & MUTE_FLAG_JINGLE)
{
    mute &= ~MUTE_FLAG_JINGLE;
    if (array_length(jingle_voices) > 0) audio_sound_gain(array_last(jingle_voices), global.volume_music, 1000);
}

#endregion

#region Stream

if (swap)
{
    if (not music_playing or audio_sound_get_gain(music_voice) <= 0)
    {
        if (music_playing) audio_stop_sound(music_voice);
        if (ds_priority_size(music) > 0) music_voice = audio_play_sound(ds_priority_find_max(music), PRIORITY_MUSIC, true, global.volume_music * (mute == 0));
        swap = false;
    }
}

if (array_length(jingle_voices) > 0 or mute & MUTE_FLAG_JINGLE)
{
    if ((mute & MUTE_FLAG_MUSIC) == 0)
    {
        mute |= MUTE_FLAG_MUSIC;
        if (music_playing) audio_sound_gain(music_voice, 0);
    }
}
else if (mute & MUTE_FLAG_MUSIC)
{
    mute &= ~MUTE_FLAG_MUSIC;
    if (music_playing and not swap) audio_sound_gain(music_voice, global.volume_music, 1000);
}

#endregion