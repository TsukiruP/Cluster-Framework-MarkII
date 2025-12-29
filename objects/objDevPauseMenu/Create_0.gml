/// @description Setup
image_speed = 0;
ctrlGame.game_paused |= PAUSE_FLAG_MENU;
global.main_camera.set_paused(true);
audio_pause_all();
cursor = 0;

/// @method menu_close([destroy])
/// @description Closes the pause menu.
/// @param {Bool} [destroy] Destroy the menu (optional, defaults to true).
menu_close = function(destroy = true)
{
    ctrlGame.game_paused &= ~PAUSE_FLAG_MENU;
    global.main_camera.set_paused(false);
    InputVerbConsumeAll();
    if (destroy) instance_destroy();
};