/// @description Setup
image_speed = 0;
ctrlGame.game_paused |= PAUSE_FLAG_MENU;
global.main_camera.set_paused(true);
cursor = 0;

/// @method menu_close()
/// @description Closes the pause menu.
menu_close = function()
{
    ctrlGame.game_paused &= ~PAUSE_FLAG_MENU;
    global.main_camera.set_paused(false);
    InputVerbConsumeAll();
    instance_destroy();
};