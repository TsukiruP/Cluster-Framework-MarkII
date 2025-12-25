/// @description Setup
image_speed = 0;
hud = db_read(global.config_database, HUD.CLUSTER, "hud");
hud_x = 0;
hud_y = 0;

switch (hud)
{
    case HUD.CLUSTER:
    {
        hud_x = 0;
        hud_y = 6;
        break;
    }
    case HUD.ADVENTURE:
    {
        hud_x = 10;
        hud_y = 13;
        break;
    }
    case HUD.ADVENTURE_2:
    {
        hud_x = 8;
        hud_y = 8;
        break;
    }
    case HUD.ADVANCE_2:
    {
        hud_x = 1;
        hud_y = 3;
        break;
    }
    case HUD.ADVANCE_3:
    {
        hud_x = 8;
        hud_y = 0;
        break;
    }
    case HUD.EPISODE_II:
    {
        hud_x = 25;
        hud_y = 26;
        break;
    }
}

// Active
hud_active = true;
active_time = 0;
active_duration = 10;