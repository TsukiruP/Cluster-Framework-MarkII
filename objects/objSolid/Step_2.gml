/// @description Animate
if (ctrlGame.game_paused) exit;

if (sink_direction & COLL_TOP)
{
    if (sink_top < 256) sink_top += 16;
}
else if (sink_top > 0)
{
	sink_top -= 16;
}

if (sink_direction & COLL_BOTTOM)
{
    if (sink_bottom < 256) sink_bottom += 16;
}
else if (sink_bottom > 0)
{
	sink_bottom -= 16;
}

if (sink_direction & COLL_LEFT)
{
    if (sink_left < 256) sink_left += 16;
}
else if (sink_left > 0)
{
	sink_left -= 16;
}

if (sink_direction & COLL_RIGHT)
{
    if (sink_right < 256) sink_right += 16;
}
else if (sink_right > 0)
{
	sink_right -= 16;
}