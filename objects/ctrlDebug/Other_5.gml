/// @description Reset
// Stage
if (dbg_control_exists(stage_time_control)) dbg_control_delete(stage_time_control);
if (dbg_control_exists(time_enabled_control)) dbg_control_delete(time_enabled_control);

// Player
array_foreach(player_views, function(_element, _index)
{
    if (dbg_view_exists(_element))
    {
        dbg_view_delete(_element);
    }
});

player_views = [];