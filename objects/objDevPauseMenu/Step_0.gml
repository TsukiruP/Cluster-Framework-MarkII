/// @description Behave
// Hide
if (InputPressed(INPUT_VERB.HIDE))
{
    with (ctrlGame)
    {
        if (not (game_flags & GAME_FLAG_HIDE_PAUSE))
        {
            game_flags |= GAME_FLAG_HIDE_PAUSE;
        }
        else
        {
            if (not (game_flags & GAME_FLAG_HIDE_HUD))
            {
                game_flags |= GAME_FLAG_HIDE_HUD;
            }
            else
            {
                game_flags &= ~(GAME_FLAG_HIDE_PAUSE | GAME_FLAG_HIDE_HUD);
            }
        }
    }
    
    InputVerbConsumeAll();
}

if (ctrlGame.game_flags & GAME_FLAG_HIDE_PAUSE)
{
    with (ctrlGame)
    {
        // Show
        if (InputPressed(INPUT_VERB.START) or InputPressed(INPUT_VERB.CANCEL))
        {
            game_flags &= ~(GAME_FLAG_HIDE_PAUSE | GAME_FLAG_HIDE_HUD);
        }
    }
}
else
{
    // Close
    if (InputPressed(INPUT_VERB.START) or InputPressed(INPUT_VERB.CANCEL))
    {
        audio_resume_all();
        menu_close();
    }
    
    // Update
    var input_axis_y = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
    if (input_axis_y != 0) cursor = clamp_inverse(cursor + input_axis_y, 0, 1);
    if (InputPressed(INPUT_VERB.CONFIRM))
    {
        switch (cursor)
        {
            // Back
            case 1:
            {
                audio_stop_all();
                audio_clear_music();
                menu_close(false);
                room_goto(rmDevMenu);
                break;
            }
            
            // Continue
            default:
            {
                audio_resume_all();
                menu_close();
            }
        }
    }
}