/// @description Initialize
image_speed = 0;
item_feed_config = db_read(DATABASE_CONFIG, CONFIG_DEFAULT_ITEM_FEED, "item_feed");

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