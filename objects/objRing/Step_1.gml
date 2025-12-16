/// @description Update
if (scattered and lifespan > 0)
{
    lifespan--;
    if (lifespan <= 0) instance_destroy();
}