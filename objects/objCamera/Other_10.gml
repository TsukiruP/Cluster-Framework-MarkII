/// @description Move
// Calculate zoom
if (zoom_active)
{
    zoom_amount = interpolate(zoom_start, zoom_end, zoom_time++ / zoom_duration, EASE_SMOOTHSTEP);
    if (zoom_amount == zoom_end) zoom_active = false;
    camera_resize();
}

var width_step = CAMERA_WIDTH * zoom_amount;
var height_step = CAMERA_HEIGHT * zoom_amount;

var view_x = camera_get_view_x(CAMERA_ID);
var view_y = camera_get_view_y(CAMERA_ID);

// Calculate shake
if (shake_active)
{
    var shake_amount = max((shake_duration - shake_time++) / shake_duration, 0);
    shake_x_offset = random_range(-shake_magnitude, shake_magnitude) * shake_amount;
    shake_y_offset = random_range(-shake_magnitude, shake_magnitude) * shake_amount;
    if (shake_amount <= 0) shake_active = false;
}

// Calculate from view center
var camera_x = x - (view_x + width_step / 2) + shake_x_offset;
var camera_y = y - (view_y + height_step / 2) + shake_y_offset;

// Calculate offsets
var h_offset = 0;
var v_offset = 0;
if (x_offset != 0 or y_offset != 0)
{
    var sine = dsin(gravity_direction);
    var cosine = dcos(gravity_direction);
    h_offset += cosine * x_offset + sine * y_offset;
    v_offset += -sine * x_offset + cosine * y_offset;
}

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
        var volume_head = array_shift(volume_lists);
        if (ds_exists(volume_head, ds_type_list)) ds_list_destroy(volume_head);
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
        if (ds_exists(volume_lists[k], ds_type_list)) ds_list_destroy(volume_lists[k]);
        array_delete(volume_lists, k, 1);
        array_delete(volume_lists_strength, k, 1);
        strength_count = array_length(volume_lists_strength) - 1;
        k--;
    }
}

// Calculate volumes
var volume_x_constrain = array_create(array_length(volume_lists), 0);
var volume_y_constrain = array_create(array_length(volume_lists), 0);

for (var i = 0; i < array_length(volume_lists); i++)
{
    if (volume_lists[i] != noone)
    {
        var view_left = view_to_room_x(0) + 1 + h_offset;
        var view_right = view_to_room_x(CAMERA_WIDTH) + 1 + h_offset;
        var view_top = view_to_room_y(0) + 1 + v_offset;
        var view_bottom = view_to_room_y(CAMERA_HEIGHT) + 1 + v_offset;
        
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
                    volume_x_constrain[i] = volume_center - x - h_offset;
                    center_h = true;
                }
            }
            
            if (not center_h and (volume_left != undefined or volume_right != undefined))
            {
                if (volume_left != undefined) volume_x_constrain[i] -= min(view_left - volume_left, 0);
                if (volume_right != undefined) volume_x_constrain[i] -= max(view_right - volume_right, 0);
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
                    volume_y_constrain[i] = volume_middle - y - v_offset;
                    center_v = true;
                }
            }
            
            if (not center_v and (volume_top != undefined or volume_bottom != undefined))
            {
                if (volume_top != undefined) volume_y_constrain[i] -= min(view_top - volume_top, 0);
                if (volume_bottom != undefined) volume_y_constrain[i] -= max(view_bottom - volume_bottom, 9);
            }
        }
    }
}

volume_x_offset = 0;
volume_y_offset = 0;

for (var i = 0; i < array_length(volume_lists_strength); i++)
{
    volume_x_offset += volume_x_constrain[i] * volume_lists_strength[i];
    volume_y_offset += volume_y_constrain[i] * volume_lists_strength[i];
}

// Apply movement
camera_x += h_offset + volume_x_offset;
camera_y += v_offset + volume_y_offset;

// Limit to view border
if (volume_list == noone)
{
    var x_border = 8;
    camera_x = max(abs(camera_x) - x_border, 0) * sign(camera_x);
    if (not on_ground)
    {
    	var y_border = 32;
    	camera_y = max(abs(camera_y) - y_border, 0) * sign(camera_y);
    }
}

// Limit movement speed
var x_speed_cap = 24 * (x_lag_time == 0);
var y_speed_cap = min(6 + abs(y - yprevious), 24) * (y_lag_time == 0);
if (abs(camera_x) > x_speed_cap) camera_x = x_speed_cap * sign(camera_x);
if (abs(camera_y > y_speed_cap)) camera_y = y_speed_cap * sign(camera_y);

// Move the view
if (camera_x != 0 or camera_y != 0)
{
	camera_x = clamp(view_x + camera_x, bound_left, bound_right - width_step);
	camera_y = clamp(view_y + camera_y, bound_top, bound_bottom - height_step);
	camera_set_view_pos(CAMERA_ID, camera_x, camera_y);
}