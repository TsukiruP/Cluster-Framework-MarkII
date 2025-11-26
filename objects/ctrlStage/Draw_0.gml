/// @description Hitboxes
with (objStageObject)
{
    var flags = collision_player(0, global.players[0]);
    draw_hitboxes();
    draw_text(x, y, $"{flags & COLL_TOP}");
}