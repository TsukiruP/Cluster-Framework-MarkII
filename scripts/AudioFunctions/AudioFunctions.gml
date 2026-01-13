/// @function audio_play_single(soundid)
/// @description Plays the given sound effect, stopping any existing instances of it beforehand.
/// @param {Asset.GMSound} soundid Sound asset to play.
/// @returns {Id.Sound}
function audio_play_single(soundid)
{
	audio_stop_sound(soundid);
	return audio_play_sound(soundid, PRIORITY_SOUND, false, global.volume_sound);
}

/// @function audio_loop_points(soundid, [loop_start], [loop_end])
/// @description Sets the loop points of the given music track.
/// @param {Asset.GMSound} soundid Sound asset to set loop points for.
/// @param {Real} [loop_start] Start point of the loop in seconds.
/// @param {Real} [loop_end] End point of the loop in seconds.
function audio_loop_points(soundid, loop_start = 0, loop_end = 0)
{
    audio_sound_loop_start(soundid, loop_start);
	audio_sound_loop_end(soundid, loop_end);
}

/// @function audio_enqueue_music(soundid, priority)
/// @description Adds the given music track to the queue, swapping to it if it has the highest priority.
/// @param {Asset.GMSound} soundid Sound asset to play.
/// /// @param {Real} priority Priority value to set.
function audio_enqueue_music(soundid, priority)
{
    with (ctrlMusic)
    {
        if (ds_priority_find_priority(music, soundid) == undefined)
        {
            ds_priority_add(music, soundid, priority);
        }
        
        if (not audio_is_playing(soundid) and ds_priority_find_max(music) == soundid) 
        {
            swap = true;
            if (audio_is_playing(music_stream)) audio_sound_gain(music_stream, 0, TEN_MILLISECONDS);
        }
    }
}

/// @function audio_dequeue_music(soundid)
/// @description Removes the given music track from the queue. If it was streaming, the track below it is then played.
/// @param {Asset.GMSound} soundid Sound asset to remove.
function audio_dequeue_music(soundid)
{
	with (ctrlMusic)
	{
		ds_priority_delete_value(music, soundid);
		if (audio_is_playing(soundid))
        {
            swap = true;
            if (audio_is_playing(music_stream)) audio_sound_gain(music_stream, 0, TEN_MILLISECONDS);
        }
	}
}

/// @function audio_clear_music()
/// @description Clears the music queue and fades out the current track.
function audio_clear_music()
{
    with (ctrlMusic)
    {
        mute = 0;
        swap = true;
        ds_priority_clear(music);
        if (audio_is_playing(music_stream)) audio_sound_gain(music_stream, 0, TEN_MILLISECONDS);
    }
}

/// @function audio_play_life()
/// @description Plays the life jingle.
function audio_play_life()
{
    with (ctrlMusic)
    {
        life_stream = audio_play_single(bgmLife);
    }
}

/// @function audio_play_jingle(soundid)
/// @description Plays the given music track, stopping previous instances and adding it to the array.
/// @param {Asset.GMSound} soundid Sound asset to play.
function audio_play_jingle(soundid)
{
    with (ctrlMusic)
    {
        audio_stop_sound(soundid);
        if (array_length(jingle_streams) > 0) audio_sound_gain(array_last(jingle_streams), 0);
        array_push(jingle_streams, audio_play_sound(soundid, PRIORITY_JINGLE, false, global.volume_music * (mute & MUTE_FLAG_JINGLE == 0)));
    }
}