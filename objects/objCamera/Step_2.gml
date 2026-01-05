/// @description Scroll
if (ctrlGame.game_paused) exit;

var vx = camera_get_view_x(CAMERA_ID);
var vy = camera_get_view_y(CAMERA_ID);
var width_step = CAMERA_WIDTH * zoom_amount;
var height_step = CAMERA_HEIGHT * zoom_amount;

// Calculate from view center
var ox = x - (vx + width_step / 2);
var oy = y - (vy + height_step / 2);

// List volumes
var volume_list = ds_list_create();
var volume_count = instance_position_list(x, y, objCameraVolume, volume_list, false);
if (volume_count != 0)
{
    for (var i = 0; i < volume_count; i++)
    {
        var volume = volume_list[|i];
        var included_volume_count = array_length(volume.included_volumes);
        if (included_volume_count > 0)
        {
            for (var j = 0; j < included_volume_count; j++)
            {
                var included_volume = volume.included_volumes[i];
                if (ds_list_find_index(volume_list, included_volume) == -1)
                {
                    ds_list_add(volume_list, included_volume);
                }
            }
        }
    }
}
else
{
    ds_list_destroy(volume_list);
    volume_list = noone;
}

var active_list = array_last(volume_lists);
var active_list_compare = noone;
var volume_list_compare = noone;
if (ds_exists(active_list, ds_type_list)) active_list_compare = ds_list_write(active_list);
if (ds_exists(volume_list, ds_type_list)) volume_list_compare = ds_list_write(volume_list);
    
if (active_list_compare != volume_list_compare)
{
    array_push(volume_lists, volume_list);
    array_push(volume_lists_strength, 0);
    if (array_length(volume_lists) > volume_lists_cap)
    {
        array_shift(volume_lists);
        array_shift(volume_lists_strength);
    }
}

var strength_count = array_length(volume_lists_strength) - 1;
for (var k = 0; k <= strength_count; k++)
{
    if (k != strength_count)
    {
        volume_lists_strength[k] = lerp(volume_lists_strength[k], 0, volume_speed);
    }
    else
    {
        volume_lists_strength[k] = lerp(volume_lists_strength[k], 1, volume_speed);
    }
    
    if (volume_lists_strength[k] == 0)
    {
        array_delete(volume_lists, k, 1);
        array_delete(volume_lists_strength, k, 1);
        strength_count = array_length(volume_lists_strength) - 1;
        k--;
    }
}

// Apply volume
var x_constraint = array_create(array_length(volume_lists), 0);
var y_constraint = array_create(array_length(volume_lists), 0);

for (var i = 0; i < array_length(volume_lists); i++)
{
    if (volume_lists[i] != noone)
    {
        var view_left = view_to_room_x(0) + 1;
        var view_right = view_to_room_x(CAMERA_WIDTH) + 1;
        var view_top = view_to_room_y(0) + 1;
        var view_bottom = view_to_room_y(CAMERA_HEIGHT) + 1;
        
        var volume_left = undefined;
        var volume_right = undefined;
        var volume_top = undefined;
        var volume_bottom = undefined;
        
        for (var j = 0; j < ds_list_size(volume_lists[i]); j++)
        {
            var volume = volume_lists[i][|j];
            if (volume.left and (volume_left == undefined or volume.bbox_left < volume_left)) volume_left = volume.bbox_left;
            if (volume.right and (volume_right == undefined or volume.bbox_right > volume_right)) volume_right = volume.bbox_right;
            if (volume.top and (volume_top == undefined or volume.bbox_top < volume_top)) volume_top = volume.bbox_top;
            if (volume.bottom and (volume_bottom == undefined) or volume.bbox_bottom > volume_bottom) volume_bottom = volume.bbox_bottom;
            
            // Horizontal constraint
            var center_h = false;
            if (volume_left != undefined and volume_right != undefined)
            {
                var volume_width = volume_right - volume_left;
                var view_width = view_right - view_left;
                if (view_width > volume_width)
                {
                    var volume_center = ((volume_left + volume_right) / 2) - 1;
                    x_constraint[i] = volume_center - x;
                    center_h = true;
                }
            }
            
            if (not center_h and (volume_left != undefined or volume_right != undefined))
            {
                if (volume_left != undefined) x_constraint[i] -= min(view_left - volume_left, 0);
                if (volume_right != undefined) x_constraint[i] -= max(view_right - volume_right, 0);
            }
            
            // Vertical constraint
            var center_v = false;
            if (volume_top != undefined and volume_bottom != undefined)
            {
                var volume_height = volume_bottom - volume_top;
                var view_height = view_bottom - view_top;
                if (view_height > volume_height)
                {
                    var volume_middle = ((volume_top + volume_bottom) / 2) - 1;
                    y_constraint[i] = volume_middle - y;
                    center_v = true;
                }
            }
            
            if (not center_v and (volume_top != undefined or volume_bottom != undefined))
            {
                if (volume_top != undefined) y_constraint[i] -= min(view_top - volume_top, 0);
                if (volume_bottom != undefined) y_constraint[i] -= max(view_bottom - volume_bottom, 9);
            }
        }
    }
}

volume_x = 0;
volume_y = 0;

for (var i = 0; i < array_length(volume_lists_strength); i++)
{
    volume_x += x_constraint[i] * volume_lists_strength[i];
    volume_y += y_constraint[i] * volume_lists_strength[i];
}

ox += volume_x;
oy += volume_y;

// Apply scroll
if (x_scroll != 0 or y_scroll != 0)
{
    var sine = dsin(gravity_direction);
    var cosine = dcos(gravity_direction);
    ox += cosine * x_scroll + sine * y_scroll;
    oy += -sine * x_scroll + cosine * y_scroll;
}

// Confine to borders
if (volume_list == noone)
{
    ox = max(abs(ox) - 8, 0) * sign(ox);
    if (not on_ground) oy = max(abs(oy) - 32, 0) * sign(oy);
}

// Limit movement speed
var x_speed_cap = 24 * (x_lag == 0);
var y_speed_cap = min(6 + abs(y - yprevious), 24) * (y_lag == 0);
if (abs(ox) > x_speed_cap) ox = x_speed_cap * sign(ox);
if (abs(oy) > y_speed_cap) oy = y_speed_cap * sign(oy);

// Move the view
if (ox != 0 or oy != 0)
{
	ox = clamp(vx + ox, bound_left, bound_right - width_step);
	oy = clamp(vy + oy, bound_top, bound_bottom - height_step);
	camera_set_view_pos(CAMERA_ID, ox, oy);
}