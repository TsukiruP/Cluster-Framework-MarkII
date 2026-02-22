/// @description Animate
var pla = ctrlStage.stage_players[0];
x = pla.x div 1;
y = pla.y div 1 - 16;
if (ctrlGame.game_paused)
{
    exit;
}
else
{
    if (pla.swap_time == 0) instance_destroy();
}