/// @description Update
if (fade_out)
{
    
}
else
{
    #region Drown
    
    if (audio_is_playing(life_voice))
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
    
    #region Jingles
    
    for (var i = 0; i < array_length(jingle_voices); i++)
    {
        if (not audio_is_playing(jingle_voices[i])) array_delete(jingle_voices, i, 1);
    }
    
    if (mute & MUTE_DROWN)
    {
        if ((mute & MUTE_JINGLE) == 0)
        {
            mute |= MUTE_JINGLE;
            if (array_length(jingle_voices) > 0) audio_sound_gain(array_last(jingle_voices), 0);
        }
    }
    else if (mute & MUTE_JINGLE)
    {
    	mute &= ~MUTE_JINGLE;
        if (array_length(jingle_voices) > 0) audio_sound_gain(array_last(jingle_voices), global.volume_music, 1000);
    }
    
    #endregion
    
    #region Stream
    
    if (swap)
    {
        if (music_voice == -1 or audio_sound_get_gain(music_voice) <= 0)
        {
            if (music_voice != -1) audio_stop_sound(music_voice);
            if (ds_priority_size(music) > 0) music_voice = audio_play_sound(ds_priority_find_max(music), PRIORITY_MUSIC, true, global.volume_music * (mute == 0));
            swap = false;
        }
    }
    
    if (array_length(jingle_voices) > 0 or mute & MUTE_JINGLE)
    {
        if ((mute & MUTE_MUSIC) == 0)
        {
            mute |= MUTE_MUSIC;
            if (music_voice != -1) audio_sound_gain(music_voice, 0);
        }
    }
    else if (mute & MUTE_MUSIC)
    {
        mute &= ~MUTE_MUSIC;
        if (music_voice != -1 and not swap) audio_sound_gain(music_voice, global.volume_music, 1000);
    }
    
    #endregion
}