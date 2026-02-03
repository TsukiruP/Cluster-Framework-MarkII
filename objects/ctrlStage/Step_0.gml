/// @description Pause
if (InputPressed(INPUT_VERB.START) and pause_allow and not instance_exists(objDevPause))
{
    instance_create_layer(0, 0, "Controllers", objDevPause);
    InputVerbConsumeAll();
}