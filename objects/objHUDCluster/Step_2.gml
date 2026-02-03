/// @description Status Bar
event_inherited();

if (visible)
{
    for (var i = 0; i < status_bar_count; i++)
    {
        status_bar[i].update();
    }
}
