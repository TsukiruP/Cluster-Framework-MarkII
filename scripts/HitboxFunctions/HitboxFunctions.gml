/// @function hitbox(col, [left], [top], [right], [bottom])
/// @description Creates a new hitbox with the given color and dimensions.
/// @param {Constant.Color} col Color of the hitbox.
/// @param {Real} left Left radius of the hitbox (optional, default is 0).
/// @param {Real} top Top radius of the hitbox (optional, default is 0).
/// @param {Real} right Right radius of the hitbox (optional, default is 0).
/// @param {Real} bottom Bottom radius of the hitbox (optional, default is 0).
function hitbox(col, _left = 0, _top = 0, _right = 0, _bottom = 0) : rect(_left, _top, _right, _bottom) constructor
{
    color = col;
}

/// @function collision_player(hb, pla, [plahb])
/// @description Checks if the given player is intersecting the given hitbox.
/// @param {Real} hb Hitbox to check.
/// @param {Id.Instance} pla Player to check.
/// @param {Real} plahb Player hitbox to check (optional, defaults to virtual mask).
/// @returns {Real}
function collision_player(hb, pla, plahb = -1)
{
    var result = 0;
    var x_int = x div 1;
    var y_int = y div 1;
    
    var sine = dsin(gravity_direction);
    var cosine = dcos(gravity_direction);
    
    var left = hitboxes[hb].left;
    var top = hitboxes[hb].top;
    var right = hitboxes[hb].right;
    var bottom = hitboxes[hb].bottom;
    
    // Abort if hitbox is empty
    if ((left == 0 and top == 0 and right == 0 and bottom == 0)) return 0;
    
    if (image_xscale == -1)
    {
        left *= -1;
        right *= -1;
    }
    
    if (image_yscale == -1)
    {
        top *= -1;
        bottom *= -1;
    }
    
    var px_int = pla.x div 1;
    var py_int = pla.y div 1;
    
    var psine = dsin(pla.mask_direction);
    var pcosine = dcos(pla.mask_direction);
    
    var pleft = -pla.x_radius;
    var ptop = -pla.y_radius;
    var pright = pla.x_radius;
    var pbottom = pla.y_radius;
    
    if (plahb > -1)
    {
        pleft = pla.hitboxes[plahb].left;
        ptop = pla.hitboxes[plahb].top;
        pright = pla.hitboxes[plahb].right;
        pbottom = pla.hitboxes[plahb].bottom;
        
        if (pla.image_xscale == -1)
        {
            pleft *= -1;
            pright *= -1;
        }
        
        if (pla.image_yscale == -1)
        {
            ptop *= -1;
            pbottom *= -1;
        }
    }
    
    // Abort if hitbox is empty
    if ((pleft == 0 and ptop == 0 and pright == 0 and pbottom == 0)) return 0;
    
    var sx1 = px_int + pcosine * pleft + psine * ptop;
    var sy1 = py_int - psine * pright + pcosine * ptop;
    var sx2 = px_int + pcosine * pright + psine * pbottom;
    var sy2 = py_int - psine * pleft + pcosine * pbottom;
    
    var dx1 = x_int + cosine * left + sine * top;
    var dy1 = y_int - sine * right + cosine * top;
    var dx2 = x_int + cosine * right + sine * bottom;
    var dy2 = y_int - sine * left + cosine * bottom;
    
    // Ensure top left and bottom right are correct
    var swap;
    
    if (sx1 > sx2)
    {
        swap = sx1;
        sx1 = sx2;
        sx2 = swap;
    }
    
    if (sy1 > sy2)
    {
        swap = sy1;
        sy1 = sy2;
        sy2 = swap;
    }
    
    if (dx1 > dx2)
    {
        swap = dx1;
        dx1 = dx2;
        dx2 = swap;
    }
    
    if (dy1 > dy2)
    {
        swap = dy1;
        dy1 = dy2;
        dy2 = swap;
    }
    
    if (rectangle_in_rectangle(sx1, sy1, sx2, sy2, dx1, dy1, dx2, dy2))
    {
        var x_center = (dx1 + dx2) div 2;
        var y_center = (dy1 + dy2) div 2;
        var x_dist = 0;
        var y_dist = 0;
        var y_dist_ext = y_dist;
        
        if (x_center > px_int)
        {
            x_dist = dx1 - sx2;
            result |= COLL_FLAG_LEFT;
        }
        else
        {
            x_dist = dx2 - sx1;
            result |= COLL_FLAG_RIGHT;
        }
        
        if (y_center > py_int)
        {
            y_dist = dy1 - sy2;
            y_dist_ext = y_dist + 5;
            if (y_dist_ext > 0) y_dist_ext = 0;
            result |= COLL_FLAG_TOP;
        }
        else
        {
            y_dist = dy2 - sy1;
            y_dist_ext = y_dist + 2;
            if (y_dist_ext < 0) y_dist_ext = 0;
            result |= COLL_FLAG_BOTTOM;
        }
        
        if (abs(x_dist) <= abs(y_dist_ext))
        {
            result &= (COLL_FLAG_LEFT | COLL_FLAG_RIGHT);
        }
        else
        {
            result &= (COLL_FLAG_TOP | COLL_FLAG_BOTTOM);
        }
        
        result |= (((x_dist << 8) & 0xFF00) | (y_dist & 0xFF));
        if (not (result & (COLL_FLAG_TOP | COLL_FLAG_BOTTOM))) result &= 0xFFF00;
        if (not (result & (COLL_FLAG_LEFT | COLL_FLAG_RIGHT))) result &= 0xF00FF;
    }
    
    return result;
}

/// @function collision_direction(flags)
/// @description Converts the given flags to a direction in degrees.
/// @param {Real} flags Flags to convert.
/// @returns {Real}
function collision_direction(flags)
{
    if (flags & COLL_FLAG_TOP) return 90;
    else if (flags & COLL_FLAG_BOTTOM) return 270;
    else if (flags & COLL_FLAG_LEFT) return 180;
    else if (flags & COLL_FLAG_RIGHT) return 0;
}

/// @function draw_hitboxes([ang])
/// @description Draws all hitboxes assigned to the instance.
/// @param {Real} [ang] Angle to draw the hitboxes (optional, default is gravity_direction).
function draw_hitboxes(ang = gravity_direction)
{
	var x_int = x div 1;
	var y_int = y div 1;
	
	for (var i = 0; i < array_length(hitboxes); i++)
	{
		var left = hitboxes[i].left;
		var top = hitboxes[i].top;
		var right = hitboxes[i].right;
		var bottom = hitboxes[i].bottom;
		
		if (not (left == 0 and top == 0 and right == 0 and bottom == 0))
		{
			var sine = dsin(ang);
        	var cosine = dcos(ang);
        	var color = hitboxes[i].color;
        	
			if (image_xscale == -1)
			{
				left *= -1;
                right *= -1;
			}
			
            if (image_yscale == -1)
            {
                top *= -1;
                bottom *= -1;
            }
			
			var x1 = x_int + cosine * left + sine * top;
	        var y1 = y_int - sine * right + cosine * top;
	        var x2 = x_int + cosine * right + sine * bottom;
	        var y2 = y_int - sine * left + cosine * bottom;
            var swap;
            
            if (x1 > x2)
            {
                swap = x1;
                x1 = x2;
                x2 = swap;
            }
            
            if (y1 > y2)
            {
                swap = y1;
                y1 = y2;
                y2 = swap;
            }
	        
	        draw_rectangle_color(x1, y1, x2, y2, color, color, color, color, true);
		}
	}
}