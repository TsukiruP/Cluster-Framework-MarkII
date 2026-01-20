/// @description Animate
if (ctrlGame.game_paused) exit;

with (objPlayer)
{
    if (other.target == noone and (shield.index == SHIELD.MAGNETIC or shield.index == SHIELD.THUNDER))
    {
        if (abs(point_distance(other.x, other.y, x, y)) <= other.magnet_range)
        {
            other.target = id;
            other.magnetized = true;
            other.lost = false;
        }
    }
    else if (other.target == id and not (shield.index == SHIELD.MAGNETIC or shield.index == SHIELD.THUNDER))
    {
        other.target = noone;
        other.magnetized = false;
        other.lost = true;
        other.lifespan = 256;
    }
}

if (magnetized)
{
    if (x_speed != 0) x += x_speed;
    if (y_speed != 0) y += y_speed;
    
    if (instance_exists(target))
    {
    	var ox = sign(target.x - x);
    	var oy = sign(target.y - y);
    	if (ox != 0)
    	{
    		var move_x = (ox != sign(x_speed) ? turn_speed : follow_speed);
    		x_speed = x_speed + (move_x * ox);
    	}
    	if (oy != 0)
    	{
    		var move_y = (oy != sign(y_speed) ? turn_speed : follow_speed);
    		y_speed = y_speed + (move_y * oy);
    	}
    }
}
else if (lost)
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
    
    array_resize(tilemaps, tilemap_count);
    if (semisolid_tilemap != -1 and y_speed > 0) array_push(tilemaps, semisolid_tilemap);
    
    for (var n = array_length(tilemaps) - 1; n > -1; n--)
    {
        var inst = tilemaps[n];
        var coll_left = (x_speed < 0 and collision_point(x_int + cosine * hitboxes[0].left, y_int - sine * hitboxes[0].left, inst, true, false));
        var coll_right = (x_speed > 0 and collision_point(x_int + cosine * hitboxes[0].right, y_int - sine * hitboxes[0].right, inst, true, false));
        var coll_top = (y_speed < 0 and collision_point(x_int + sine * hitboxes[0].top, y_int + cosine * hitboxes[0].top, inst, true, false));
        var coll_bottom = (y_speed > 0 and collision_point(x_int + sine * hitboxes[0].bottom, y_int + cosine * hitboxes[0].bottom, inst, true, false));
        
        if (inst != semisolid_tilemap and (coll_left or coll_right))
        {
            x_speed *= -1;
        }
        
        if (inst != semisolid_tilemap and coll_top)
        {
            y_speed *= -1;
        }
        else if (coll_bottom)
        {
            y_speed = (y_speed div 4) - y_speed;
        }
    }
}

image_index = ctrlGame.game_time div (lost ? frame_speed div 2 : frame_speed);