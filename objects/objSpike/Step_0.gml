/// @description Behave
if (ctrlGame.game_paused) exit;

if (hidden)
{
    var time = ctrlStage.stage_time mod 128;
    if (time < 60)
    {
        sprite_index = -1;
    }
    else
    {
        sprite_index = sprSpike;
        hidden_fix = (image_index != 0);
        if (time < 62) image_index = 1;
        else if (time < 64) image_index = 2;
        else if (time < 124) image_index = 0;
        else if (time < 126) image_index = 2;
        else image_index = 1;
    }
}