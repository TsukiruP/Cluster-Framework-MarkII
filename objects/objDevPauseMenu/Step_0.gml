/// @description Behave
// Invisible
if (InputPressed(INPUT_VERB.HIDE))
{
    if (not (ctrlGame.game_flags & GAME_FLAG_HIDE_PAUSE))
    {
        ctrlGame.game_flags |= GAME_FLAG_HIDE_PAUSE;
    }
    else
    {
    	if (not (ctrlGame.game_flags & GAME_FLAG_HIDE_HUD))
        {
            ctrlGame.game_flags |= GAME_FLAG_HIDE_HUD;
        }
        else
        {
            ctrlGame.game_flags &= ~(GAME_FLAG_HIDE_PAUSE | GAME_FLAG_HIDE_HUD);
        }
    }
    
    InputVerbConsumeAll();
}

if (ctrlGame.game_flags & GAME_FLAG_HIDE_PAUSE)
{
    // Visible
    if (InputPressed(INPUT_VERB.START) or InputPressed(INPUT_VERB.CANCEL))
    {
        ctrlGame.game_flags &= ~(GAME_FLAG_HIDE_PAUSE | GAME_FLAG_HIDE_HUD);
    }
}
else
{
    // Close
    if (InputPressed(INPUT_VERB.START) or InputPressed(INPUT_VERB.CANCEL))
    {
        menu_close();
    }
    
    // Update
    var input_axis_y = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
    if (input_axis_y != 0) cursor = wrap(cursor + input_axis_y, 0, 1);
    if (InputPressed(INPUT_VERB.CONFIRM))
    {
        switch (cursor)
        {
            // Back
            case 1:
            {
                menu_close(false);
                room_goto(rmInit);
                break;
            }
            
            // Continue
            default:
            {
                menu_close();
            }
        }
    }
}