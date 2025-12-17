/// @description Pause
if (InputPressed(INPUT_VERB.START) and not instance_exists(objPauseMenuDebug))
{
    instance_create_layer(0, 0, "Controllers", objPauseMenuDebug);
}