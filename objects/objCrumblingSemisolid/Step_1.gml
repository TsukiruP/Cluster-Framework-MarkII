/// @description Update
if (ctrlGame.game_paused) exit;

if (not reset)
{
    event_inherited();
    is_crumbling = false;
}