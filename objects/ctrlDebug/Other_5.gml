/// @description Reset
array_foreach(player_views, function(_element, _index)
{
    if (dbg_view_exists(_element))
    {
        dbg_view_delete(_element);
    }
});

player_views = [];