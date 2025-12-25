/// @description Visible
visible = (ctrlGame.game_flags & GAME_FLAG_HIDE_HUD ? false : true);

if (visible and hud == HUD.CLUSTER)
{
    var hud_xstart = -sprite_get_width(sprHUDCluster);
    var hud_xend = 4;
    hud_x = hud_xstart + (hud_xend - hud_xstart) * animcurve_channel_evaluate(active_channel, active_time / active_duration);
}