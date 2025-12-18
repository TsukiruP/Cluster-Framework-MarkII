/// @description Setup
image_speed = 0;
ctrlGame.game_paused |= PAUSE_FLAG_MENU;
cursor = 0;

/// @method menu_close()
/// @description Closes the pause menu.
menu_close = function()
{
    ctrlGame.game_paused &= ~PAUSE_FLAG_MENU;
    InputVerbConsumeAll();
    instance_destroy();
};