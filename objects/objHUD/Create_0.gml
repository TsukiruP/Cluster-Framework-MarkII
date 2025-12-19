/// @description Setup
image_speed = 0;
hud_x = 0;
hud_y = 0;

switch (db_read(global.config_database, HUD.CLUSTER, "hud"))
{
    case HUD.CLUSTER:
    {
        break;
    }
    case HUD.ADVENTURE:
    {
        break;
    }
    case HUD.ADVENTURE_2:
    {
        break;
    }
    case HUD.ADVANCE_2:
    {
        break;
    }
    case HUD.ADVANCE_3:
    {
        break;
    }
    case HUD.EPISODE_II:
    {
        break;
    }
}