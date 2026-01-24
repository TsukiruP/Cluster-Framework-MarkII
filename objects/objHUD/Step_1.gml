/// @description Time
if (ctrlGame.game_paused & PAUSE_FLAG_MENU) exit;

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
    var popup_last = array_last(item_feed);
    if (popup_last != undefined)
    {
        if (popup_last.time == popup_duration and item_feed_time > 0)
        {
            item_feed_time--;
            if (item_feed_time == 0)
            {
                array_resize(item_feed, 0);
            }
        }
    }
    
    for (var i = 0; i < array_length(item_feed); i++)
    {
        var popup_index = item_feed[i];
        if (popup_index.time < popup_duration) popup_index.time++;
    }
}