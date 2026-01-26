/// @description Pause
if (InputPressed(INPUT_VERB.START) and pause_allow and not instance_exists(objDevPauseMenu))
{
    instance_create_layer(0, 0, "Controllers", objDevPauseMenu);
    InputVerbConsumeAll();
}