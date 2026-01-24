/// @description Update
if (ctrlGame.game_paused & PAUSE_FLAG_MENU) exit;

if (lifespan > 0)
{
    lifespan--;
    if (lifespan == 0) instance_destroy();
}

if (x_acceleration != 0) x_speed += image_xscale * x_acceleration;
if (y_acceleration != 0) y_speed += image_yscale * y_acceleration;
if (x_speed != 0) x += x_speed;
if (y_speed != 0) y += y_speed;

animation_update();