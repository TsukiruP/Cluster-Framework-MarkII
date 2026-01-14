/// @description Update
if (ctrlGame.game_paused) exit;

if (lifespan > 0)
{
    lifespan--;
    if (lifespan == 0) instance_destroy();
}

if (x_acceleration != 0) x_speed += image_xscale * x_acceleration;
if (y_acceleration != 0) y_speed += image_yscale * y_acceleration;
animation_update();