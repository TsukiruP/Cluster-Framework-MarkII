/// @description Render
if (item_feed_config)
{
    for (var i = 0; i < array_length(item_feed); i++)
    {
        var popup_index = item_feed[i];
        var popup_x = popup_index.x;
        var icon_index = popup_index.icon;
        if (item_feed_time > 30 or item_feed_time mod 4 < 2)
        {
            draw_sprite(sprHUDItemIcon, icon_index, popup_x, CAMERA_HEIGHT - 33);
        }
    }
}