/// @description Pause
if (InputPressed(INPUT_VERB.START) and not instance_exists(objDevPauseMenu))
{
    instance_create_layer(0, 0, "Controllers", objDevPauseMenu);
    InputVerbConsumeAll();
}