/// @function audio_play_single(sound, [loop])
/// @description Plays the given sound effect, stopping any existing instances of it beforehand.
/// @param {Asset.GMSound} sound Sound asset to play.
/// @param {Bool} [loop] Sets the sound to loop or not (optional, defaults to false).
/// @returns {Id.Sound}
function audio_play_single(sound, loop = false)
{
	audio_stop_sound(sound);
	return audio_play_sound(sound, PRIORITY_SOUND, loop, global.volume_sound);
}

/// @function audio_loop_points(sound, [loop_start], [loop_end])
/// @description Sets the loop points of the given music track.
/// @param {Asset.GMSound} sound Sound asset to set loop points for.
/// @param {Real} [loop_start] Start point of the loop in seconds.
/// @param {Real} [loop_end] End point of the loop in seconds.
function audio_loop_points(sound, loop_start = 0, loop_end = 0)
{
    audio_sound_loop_start(sound, loop_start);
	audio_sound_loop_end(sound, loop_end);
}

/// @function audio_enqueue_music(sound, priority)
/// @description Adds the given music track to the queue, swapping to it if it has the highest priority.
/// @param {Asset.GMSound} sound Sound asset to play.
/// /// @param {Real} priority Priority value to set.
function audio_enqueue_music(sound, priority)
{
    with (ctrlMusic)
    {
        if (ds_priority_find_priority(music, sound) == undefined)
        {
            ds_priority_add(music, sound, priority);
        }
        
        if (not audio_is_playing(sound) and ds_priority_find_max(music) == sound) 
        {
            swap = true;
            if (audio_is_playing(music_soundid)) audio_sound_gain(music_soundid, 0, TEN_MILLISECONDS);
        }
    }
}

/// @function audio_dequeue_music(sound)
/// @description Removes the given music track from the queue. If it was streaming, the track below it is then played.
/// @param {Asset.GMSound} sound Sound asset to remove.
function audio_dequeue_music(sound)
{
	with (ctrlMusic)
	{
		ds_priority_delete_value(music, sound);
		if (audio_is_playing(sound))
        {
            swap = true;
            if (audio_is_playing(music_soundid)) audio_sound_gain(music_soundid, 0, TEN_MILLISECONDS);
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
        if (audio_is_playing(music_soundid)) audio_sound_gain(music_soundid, 0, TEN_MILLISECONDS);
    }
}

/// @function audio_play_life()
/// @description Plays the life jingle.
function audio_play_life()
{
    with (ctrlMusic)
    {
        life_soundid = audio_play_single(bgmLife);
    }
}

/// @function audio_play_jingle(sound)
/// @description Plays the given music track, stopping previous instances and adding it to the array.
/// @param {Asset.GMSound} sound Sound asset to play.
function audio_play_jingle(sound)
{
    with (ctrlMusic)
    {
        audio_stop_sound(sound);
        if (array_length(jingle_soundids) > 0) audio_sound_gain(array_last(jingle_soundids), 0);
        array_push(jingle_soundids, audio_play_sound(sound, PRIORITY_JINGLE, false, global.volume_music * (mute & MUTE_FLAG_JINGLE == 0)));
    }
}