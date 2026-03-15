/// @description Update
if (ctrlGame.game_paused) exit;

if (lost and lifespan > 0)
{
    if (--lifespan <= 0) instance_destroy();
}