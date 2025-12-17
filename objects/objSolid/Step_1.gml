/// @description Update
if (ctrlGame.game_paused) exit;

sink_direction = 0;
if (xdistance != 0 or ydistance != 0)
{
    var time = ctrlStage.stage_time;
    var factor = pi / 1024;
    x = xstart + xdistance * sin((8 * time) * factor) div 1;
    y = ystart + ydistance * sin((8 * time) * factor) div 1;
}