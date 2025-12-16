/// @description Debug
with (objInteractable) draw_hitboxes();
with (objRing)
{
    draw_text(x, y, $"{x_speed}");
    draw_text(x, y + 15, $"{y_speed}");
}