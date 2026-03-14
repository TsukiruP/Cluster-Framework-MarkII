/// @description Update
event_inherited();
if (ctrlGame.game_paused & PAUSE_FLAG_MENU) exit;
with (hammer_trail)
{
    for (var i = 0; i < HEART_COUNT; i++)
    {
        if (hearts[i].visible)
        {
            with (hearts[i]) animation_update();
        }
    }
}