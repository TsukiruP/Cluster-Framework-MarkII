/// @description Animate
if (ctrlGame.game_paused) exit;

if (not reset)
{
    if (is_crumbling or crumbled)
    {
        if (crumble_time < 64) crumble_time++;
        if (crumble_time > 48) crumbled = true;
    }
    else if (crumble_time > 0)
    {
    	crumble_time--;
    }
    
    var crumble_index = (crumble_time >> 2) - 4;
    if (crumble_index < image_number)
    {
        image_index = max(0, crumble_index);
    }
    else
    {
        x = xstart;
        y = ystart;
        reset = true;
    }
}
else if (not instance_in_view(id, 128))
{
    is_crumbling = false;
    crumbled = false;
    crumble_time = 0;
    reset = false;
}