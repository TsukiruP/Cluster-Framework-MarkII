/// @description Debug
with (objStageObject) draw_hitboxes();
with (objStageObject)
{
    var flags = collision_player(0, global.players[0]);
    draw_text(x, y, $"Left: {flags & COLL_LEFT}");
    draw_text(x, y + 15, $"Top: {flags & COLL_TOP}");
    draw_text(x, y + 30, $"X Distance: {convert_hex((flags & 0x0FF00) / 256)}");
    draw_text(x, y + 45, $"Y Distance: {convert_hex(flags & 0x000FF)}");
}