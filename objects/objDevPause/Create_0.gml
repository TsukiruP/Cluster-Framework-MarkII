/// @description Initialize
image_speed = 0;
audio_pause_all();
cursor = 0;
with (ctrlGame) game_paused |= PAUSE_FLAG_MENU;

/// @method menu_close([destroy])
/// @description Closes the pause menu.
/// @param {Bool} [destroy] Destroy the menu (optional, defaults to true).
menu_close = function(destroy = true)
{
    ctrlGame.game_paused &= ~PAUSE_FLAG_MENU;
    InputVerbConsumeAll();
    if (destroy) instance_destroy();
};