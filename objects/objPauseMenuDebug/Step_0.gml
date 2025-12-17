if (InputPressed(INPUT_VERB.START))
{
    ctrlGame.game_paused &= ~PAUSE_MENU;
    InputVerbConsume(INPUT_VERB.START);
    instance_destroy();
}
else
{
    var input_axis_y = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
    if (input_axis_y != 0) cursor = wrap(cursor + input_axis_y, 0, 1);
}