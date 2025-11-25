/// @description Hitboxes
with (objStageObject)
{
    var flags = collision_player(0, global.players[0]);
    draw_text(x, y, $"{(flags & 0x000FF)}");
    //draw_text(x, y, $"{(y - hitboxes[0].top - global.players[0].y + 14) div 1}");
    draw_hitboxes();
}