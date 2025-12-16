/// @description Animate
if (magnetized)
{
    
}
else if (scattered)
{
    var x_int = x div 1;
    var y_int = y div 1;
    var sine = dsin(gravity_direction);
    var cosine = dcos(gravity_direction);
    
    if (x_speed != 0)
    {
        x += cosine * x_speed;
        y -= sine * x_speed;
    }
    
    if (y_speed != 0)
    {
        x += sine * y_speed;
        y += cosine * y_speed;
    }
    
    y_speed += gravity_force;
    
    if (semisolid_tilemap != -1)
    {
        var valid = array_contains(tilemaps, semisolid_tilemap);
        if (y_speed > 0)
        {
            if (not valid) array_push(tilemaps, semisolid_tilemap);
        }
        else if (valid) array_pop(tilemaps);
    }
    
    for (var n = array_length(tilemaps) - 1; n > -1; --n)
    {
        var inst = tilemaps[n];
        var coll_left = (x_speed < 0 and collision_point(x_int + cosine * hitboxes[0].left, y_int - sine * hitboxes[0].left, inst, true, false));
        var coll_right = (x_speed > 0 and collision_point(x_int + cosine * hitboxes[0].right, y_int - sine * hitboxes[0].right, inst, true, false));
        var coll_top = (y_speed < 0 and collision_point(x_int + sine * hitboxes[0].top, y_int + cosine * hitboxes[0].top, inst, true, false));
        var coll_bottom = (y_speed > 0 and collision_point(x_int + sine * hitboxes[0].bottom, y_int + cosine * hitboxes[0].bottom, inst, true, false));
        
        if (coll_left or coll_right)
        {
            x_speed *= -1;
        }
        
        if (coll_top)
        {
            y_speed *= -1;
        }
        else if (coll_bottom)
        {
            y_speed = (y_speed div 4) - y_speed;
        }
    }
}

image_index = ctrlWindow.image_index div (scattered ? frame_speed div 2 : frame_speed);