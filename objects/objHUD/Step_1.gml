/// @description Time
if (ctrlGame.game_paused) exit;

if (hud_config == CONFIG_HUD.CLUSTER)
{
    if (hud_active)
    {
        if (active_time < active_duration) active_time++;
    }
    else
    {
        if (active_time > 0) active_time--;
    }
}

if (item_feed_config)
{
    if (item_feed_time > 0)
    {
        item_feed_time--;
        if (item_feed_time == 0)
        {
            array_resize(item_feed, 0);
        }
    }
    
    for (var i = 0; i < array_length(item_feed); i++)
    {
        var item_post_index = item_feed[i];
        if (item_post_index.time < item_post_duration) item_post_index.time++;
    }
}