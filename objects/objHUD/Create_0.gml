/// @description Initialize
image_speed = 0;
item_feed_config = db_read(DATABASE_CONFIG, CONFIG_DEFAULT_ITEM_FEED, "item_feed");

// Time
time = 0;
time_over = false;
time_alert = false;
flash = false;
minutes = 0;
seconds = 0;
centiseconds = 0;

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
    item_feed_time = 0;
    item_feed_duration = 90;
    popup_duration = 10;
}