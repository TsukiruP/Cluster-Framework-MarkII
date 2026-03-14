/// @description Update
event_inherited();
if (ctrlGame.game_paused & PAUSE_FLAG_MENU) exit;

// Hammer trail
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

// Trick trail
with (trick_trail)
{
    for (var i = 0; i < HEART_COUNT; i++)
    {
        with (hearts[i]) animation_update();
    }
}