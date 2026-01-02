/// @description Setup
image_speed = 0;
hud_config = db_read(global.config_database, CONFIG_DEFAULT_HUD, "hud");
status_config = db_read(global.config_database, CONFIG_DEFAULT_STATUS_BAR, "status");

// HUD
hud_x = 0;
hud_y = 0;

switch (hud_config)
{
    case CONFIG_HUD.CLUSTER:
    {
        hud_x = 0;
        hud_y = 6;
        break;
    }
    case CONFIG_HUD.ADVENTURE:
    {
        hud_x = 10;
        hud_y = 13;
        break;
    }
    case CONFIG_HUD.ADVENTURE_2:
    {
        hud_x = 8;
        hud_y = 8;
        break;
    }
    case CONFIG_HUD.ADVANCE_2:
    {
        hud_x = 1;
        hud_y = 3;
        break;
    }
    case CONFIG_HUD.ADVANCE_3:
    {
        hud_x = 8;
        hud_y = 0;
        break;
    }
    case CONFIG_HUD.EPISODE_II:
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

// Status
if (status_config != CONFIG_STATUS_BAR.OFF)
{
    /// @method status()
    /// @description Creates a new status.
    status = function() constructor
    {
        icon = ITEM.EGGMAN;
        active = true;
        visible = true;
        update = function() {};
    };
    
    status_shield = new status();
    with (status_shield)
    {
        update = function()
        {
            var shield = ctrlStage.stage_players[0].shield;
            icon = ITEM.BASIC + (shield > SHIELD.NONE ? shield - SHIELD.BASIC : 0);
            active = shield != SHIELD.NONE;
        };
    }
    
    status_invin = new status();
    with (status_invin)
    {
        icon = ITEM.INVINCIBILITY;
        update = function()
        {
            var time = max(ctrlStage.stage_players[0].invin_time, ctrlStage.stage_players[0].invuln_time);
            active = (time > 0);
            visible = (time < 120 ? time mod 4 < 2 : true);
        };
    }
    
    status_speed = new status();
    with (status_speed)
    {
        icon = ITEM.SPEED_UP;
        update = function()
        {
            var time = ctrlStage.stage_players[0].superspeed_time;
            var time_abs = abs(time);
            icon = (time < 0 ? ITEM.SLOW_DOWN : ITEM.SPEED_UP);
            active = (time != 0);
            visible = (time_abs < 120 ? time_abs mod 4 < 2 : true);
        };
    }
    
    status_confusion = new status();
    with (status_confusion)
    {
        icon = ITEM.CONFUSION;
        update = function()
        {
            var time = ctrlStage.stage_players[0].confusion_time;
            active = (time > 0);
            visible = (time < 120 ? time mod 4 < 2 : true);
        }
    }
    
    status_bar = [status_confusion, status_speed, status_invin, status_shield];
    if (not db_read(global.config_database, CONFIG_DEFAULT_DEBUFFS, "debuffs")) array_shift(status_bar);
    status_bar_count = array_length(status_bar);
}