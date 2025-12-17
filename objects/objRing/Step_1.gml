/// @description Update
if (ctrlGame.game_paused) exit;

if (lost and lifespan > 0)
{
    lifespan--;
    if (lifespan <= 0) instance_destroy();
}