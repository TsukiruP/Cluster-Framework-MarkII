/// @description Update
if (lost and lifespan > 0)
{
    lifespan--;
    if (lifespan <= 0) instance_destroy();
}