array_foreach(home_menu, function (element, index)
{
    with (element) script_execute(update_function);
});