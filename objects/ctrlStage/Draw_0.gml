/// @description Debug
with (objStageObject) draw_hitboxes();
with (objStageObject)
{
    var flags = collision_player(0, global.players[0]);
    draw_text(x, y, $"{flags}");
    draw_text(x, y + 15, $"X Distance: {convert_hex((flags & 0x0FF00) / 256)}");
    draw_text(x, y + 30, $"Y Distance: {convert_hex(flags & 0x000FF)}");
    draw_text(x, y + 45, $"X Distance: {x div 1 + hitboxes[0].left - (global.players[0].x div 1 + global.players[0].hitboxes[0].right)}");
}