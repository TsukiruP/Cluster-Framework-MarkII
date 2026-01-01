/// @description Visible
visible = (ctrlGame.game_flags & GAME_FLAG_HIDE_HUD ? false : true);

if (visible and hud_config == CONFIG_HUD.CLUSTER and status_config != CONFIG_STATUS_BAR.OFF)
{
    for (var i = 0; i < array_length(status_bar); i++)
    {
        status_bar[i].update();
    }
}