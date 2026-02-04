/// @description Animate
visible = (ctrlGame.game_flags & GAME_FLAG_HIDE_HUD ? false : true);

time = ctrlStage.stage_time;
time_over = ctrlStage.time_over;
time_alert = (ctrlStage.time_limit - time) < time_to_frames(1, 0);
flash = ctrlGame.game_time mod 32 < 16;
minutes = time div 3600;
seconds = time div 60 mod 60;
centiseconds = floor(time / 0.6) mod 100;

if (item_feed_config)
{
    var popup_xstart = -sprite_get_width(sprHUDItemIcon);
    for (var i = 0; i < array_length(item_feed); i++)
    {
        var popup_index = item_feed[i];
        var popup_time = popup_index.time;
        var popup_xend = CAMERA_WIDTH / 2 + 9 * (array_length(item_feed) - 1) - i * ITEM_WIDTH;
        popup_index.x = interpolate(popup_xstart, popup_xend, popup_time / popup_duration, EASE_SMOOTHSTEP);
    }
}