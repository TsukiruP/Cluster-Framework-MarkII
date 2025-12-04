///@description Update
if (xdistance != 0 or ydistance != 0)
{
    var time = ctrlStage.stage_time;
    x = xstart + (dsin((time div frame_speed) mod 360) * xdistance) div 1;
    y = ystart + (dsin((time div frame_speed) mod 360) * ydistance) div 1;
}