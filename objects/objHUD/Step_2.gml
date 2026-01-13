/// @description Visible
visible = (ctrlGame.game_flags & GAME_FLAG_HIDE_HUD ? false : true);

if (visible and hud_config == CONFIG_HUD.CLUSTER and status_bar_config != CONFIG_STATUS_BAR.OFF)
{
    for (var i = 0; i < status_bar_count; i++)
    {
        status_bar[i].update();
    }
}

if (item_feed_config)
{
    for (var i = 0; i < array_length(item_feed); i++)
    {
        var popup_index = item_feed[i];
        var popup_time = popup_index.time;
        var popup_xstart = -sprite_get_width(sprHUDItemIcon);
        var popup_xend = CAMERA_WIDTH / 2 + 9 * (array_length(item_feed) - 1) - i * ITEM_WIDTH;
        popup_index.x = interpolate(popup_xstart, popup_xend, popup_time / popup_duration, EASE_SMOOTHSTEP);
    }
}