if (InputPressed(INPUT_VERB.START))
{
    menu_close();
}
else
{
    var input_axis_y = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
    if (input_axis_y != 0) cursor = wrap(cursor + input_axis_y, 0, 1);
    if (InputPressed(INPUT_VERB.CONFIRM))
    {
        switch (cursor)
        {
            // Back
            case 1:
            {
                ctrlGame.game_paused &= ~PAUSE_FLAG_MENU;
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