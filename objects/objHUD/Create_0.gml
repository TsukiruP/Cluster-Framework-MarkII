/// @description Initialize
image_speed = 0;

// Configs
hud_config = db_read(DATABASE_CONFIG, CONFIG_DEFAULT_HUD, "hud");
status_bar_config = (hud_config == CONFIG_HUD.CLUSTER ? db_read(DATABASE_CONFIG, CONFIG_DEFAULT_STATUS_BAR, "status_bar") : 0);
item_feed_config = db_read(DATABASE_CONFIG, CONFIG_DEFAULT_ITEM_FEED, "item_feed");

// Active
hud_active = false;
active_duration = 10;
active_time = active_duration;

// Status Bar
if (status_bar_config != CONFIG_STATUS_BAR.OFF)
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
            var shield = ctrlStage.stage_players[0].shield.index;
            icon = ITEM.BASIC + (shield > SHIELD.NONE ? shield - SHIELD.BASIC : 0);
            active = (shield != SHIELD.NONE);
        };
    }
    
    status_invin = new status();
    with (status_invin)
    {
        icon = ITEM.INVINCIBILITY;
        update = function()
        {
            var time = max(ctrlStage.stage_players[0].invincibility_time, ctrlStage.stage_players[0].recovery_time);
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
            var abs_time = abs(time);
            icon = (time < 0 ? ITEM.SLOW_DOWN : ITEM.SPEED_UP);
            active = (time != 0);
            visible = (abs_time < 120 ? abs_time mod 4 < 2 : true);
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
        };
    }
    
    status_bar = [status_confusion, status_speed, status_invin, status_shield];
    if (not db_read(DATABASE_CONFIG, CONFIG_DEFAULT_DEBUFFS, "debuffs")) array_shift(status_bar);
    status_bar_count = array_length(status_bar);
}

// Item Feed
if (item_feed_config)
{
    /// @method popup(icon)
    /// @description Creates a new item post.
    popup = function(_icon) constructor
    {
        x = CAMERA_WIDTH / 2;
        icon = _icon;
        time = 0;
    };
    
    item_feed = [];
    item_feed_duration = 90;
    item_feed_time = 0;
    popup_duration = 10;
}