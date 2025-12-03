/// @description Debug
with (objStageObject) draw_hitboxes();
with (objStageObject) 
{
    draw_text(x, y, $"Top: {collision_player(0, global.players[0]) & COLL_FLAG_TOP}");
    draw_text(x, y + 15, $"Bottom: {collision_player(0, global.players[0]) & COLL_FLAG_BOTTOM}");
    draw_text(x, y + 30, $"Right: {collision_player(0, global.players[0]) & COLL_FLAG_RIGHT}");
    draw_text(x, y + 45, $"Left: {collision_player(0, global.players[0]) & COLL_FLAG_LEFT}");
}