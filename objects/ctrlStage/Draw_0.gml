/// @description Debug
with (objInteractable) draw_hitboxes();
with (objInteractable) 
{
    var flags = collision_player(0, global.players[0]);
    draw_text(x, y, $"Top: {flags & COLL_FLAG_TOP}");
    draw_text(x, y + 15, $"Bottom: {flags & COLL_FLAG_BOTTOM}");
    draw_text(x, y + 30, $"Right: {flags & COLL_FLAG_RIGHT}");
    draw_text(x, y + 45, $"Left: {flags & COLL_FLAG_LEFT}");
    draw_text(x, y + 60, $"X Distance: {convert_hex((flags & 0x0FF00) >> 8)}");
    draw_text(x, y + 75, $"Y Distance: {convert_hex(flags & 0x000FF)}");
}