/// @description Visible
visible = (ctrlGame.game_flags & GAME_FLAG_HIDE_HUD ? false : true);

if (visible)
{
    for (var i = 0; i < array_length(status_bar); i++)
    {
        status_bar[i].update();
    }
}