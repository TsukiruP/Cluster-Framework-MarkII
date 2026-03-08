/// @description Setters

/// @description Moves the player's wall sensor out of collision with any walls.
/// @returns {Real|Undefined} Sign of the wall from the player, or undefined on failure to reposition.
player_escape_wall = function()
{
    var x_int = x div 1;
    var y_int = y div 1;
    var sine = dsin(mask_direction);
    var cosine = dcos(mask_direction);
    var ind = tilemaps; //instance_place(x_int, y_int, tilemaps);
    
    if (collision_point(x_int, y_int, ind, true, false) == noone)
    {
        for (var ox = x_wall_radius - 1; ox > -1; ox--)
        {
            if (player_linecast(ind, ox)) continue;
            
            if (collision_point(x_int + cosine * (ox + 1), y_int - sine * (ox + 1), ind, true, false) != noone)
            {
                x -= cosine * (x_wall_radius - ox);
                y += sine * (x_wall_radius - ox);
                return 1;
            }
            else if (collision_point(x_int - cosine * (ox + 1), y_int + sine * (ox + 1), ind, true, false) != noone)
            {
                x += cosine * (x_wall_radius - ox);
                y -= sine * (x_wall_radius - ox);
                return -1;
            }
        }
    }
    else
    {
        for (var ox = 1; ox <= x_wall_radius; ox++)
        {
            if (collision_point(x_int + cosine * ox, y_int - sine * ox, ind, true, false) == noone)
            {
                x += cosine * (x_wall_radius + ox);
                y -= sine * (x_wall_radius + ox);
                return -1;
            }
            else if (collision_point(x_int - cosine * ox, y_int + sine * ox, ind, true, false) == noone)
            {
                x -= cosine * (x_wall_radius + ox);
                y += sine * (x_wall_radius + ox);
                return 1;
            }
        }
    }
    
    return undefined;
};

/// @description Aligns the player to the ground and updates their angle values should they land, otherwise they are detached.
/// @param {Bool} land Whether to stick to the ground.
player_ground = function(_land)
{
    if (not _land)
    {
        on_ground = false;
        mask_direction = gravity_direction;
        exit;
    }
    
    // Reposition
    var sine = dsin(mask_direction);
    var cosine = dcos(mask_direction);
    
    repeat (y_radius + 1)
    {
        if (player_boxcast(tilemaps, y_radius))
        {
            x -= sine;
            y -= cosine;
        }
        else
        {
            break;
        }
    }
    
    repeat (y_tile_reach - 1)
    {
        if (not player_boxcast(tilemaps, y_radius + 1))
        {
            x += sine;
            y += cosine;
        }
        else
        {
            break;
        }
    }
    
    // Update current ground and angle values
    ground_id = instance_place(x div 1 + sine, y div 1 + cosine, tilemaps);
    if (not instance_exists(ground_id))
    {
        ground_id = noone;
        player_detect_angle();
    }
};

/// @description Sets the player's angle values.
player_detect_angle = function()
{
    // Check for points of collision with the ground
    var edge = 0;
    if (player_raycast(tilemaps, -x_radius, y_radius + 1)) edge |= 1;
    if (player_raycast(tilemaps, x_radius, y_radius + 1)) edge |= 2;
    if (player_raycast(tilemaps, 0, y_radius + 1)) edge |= 4;
    
    if (edge == 0) exit;
    
    // Set new angle values
    if (edge & (edge - 1) == 0) // Check for only one point (power of 2 calculation)
    {
        // Calculate offset point, and reposition it if applicable
        var sine = dsin(mask_direction);
        var cosine = dcos(mask_direction);
        var ox = x div 1 + sine * y_radius;
        var oy = y div 1 + cosine * y_radius;
        
        if (edge == 1)
        {
            ox -= cosine * x_radius;
            oy += sine * x_radius;
        }
        else if (edge == 2)
        {
            ox += cosine * x_radius;
            oy -= sine * x_radius;
        }
        
        direction = player_calc_tile_normal(ox, oy);
    }
    else
    {
        direction = mask_direction;
    }
    
    local_direction = angle_wrap(direction - gravity_direction);
};

/// @description Updates the direction of the player's virtual mask on slopes.
player_rotate_mask = function()
{
    if (rotation_lock_time > 0 and not landed)
    {
        rotation_lock_time--;
        exit;
    }
    
    var new_mask_direction = round(direction / 90) mod 4 * 90;
    if (mask_direction != new_mask_direction)
    {
        mask_direction = new_mask_direction;
        rotation_lock_time = (not landed) * max(16 - abs(x_speed * 2) div 1, 0);
    }
};

/// @description Sets the given function as the player's current state.
/// @param {Function} state State function to set.
/// @param {Bool} [enter] Whether to perform the enter phase (optional, defaults to true).
player_perform = function(_state, _enter = true)
{
    var reset = (argument_count > 1);
    if (state != _state or reset)
    { 
        state_previous = state;
        state = _state;
        state_changed = true;
        state_previous(PHASE.EXIT);
        if (_enter) state(PHASE.ENTER);
    }
};

/// @description Sets the given radii as the player's virtual mask.
/// @param {Real} xrad Horizontal radius to use.
/// @param {Real} yrad Vertical radius to use.
player_set_radii = function(_xrad, _yrad)
{
    // Abort if radii already match
    if (x_radius == _xrad and y_radius == _yrad) exit;
    
    var old_x_radius = x_radius;
    var old_y_radius = y_radius;
    x_radius = _xrad;
    x_wall_radius = x_radius + 2;
    y_radius = _yrad;
    
    if (on_ground)
    {
        var sine = dsin(mask_direction);
        var cosine = dcos(mask_direction);
        x += sine * (old_y_radius - y_radius);
        y += cosine * (old_y_radius - y_radius);
    }
};

/// @description Resets the player's physics variables back to their default values, applying any modifiers afterward.
player_refresh_physics = function()
{
    // Speed values
    speed_limit = 6;
    speed_cap = 16;
    base_acceleration = 0.046875;
    acceleration = base_acceleration;
    deceleration = 0.5;
    air_acceleration = 0.09375;
    roll_deceleration = 0.125;
    roll_friction = 0.0234375;
    
    // Aerial values
    gravity_cap = 16;
    gravity_force = 0.21875;
    jump_height = 6.5;
    jump_release = 4;
    hurt_force = 0.1875;
    
    trick_bound_force = 0.21875;
    trick_bound_height = 6;
    
    // Superspeed modification
    if (superspeed_time > 0)
    {
        speed_limit *= 2;
        base_acceleration *= 2;
        roll_friction *= 2;
    }
    else if (superspeed_time < 0)
    {
        speed_limit /= 2;
        base_acceleration /= 2;
        roll_friction /= 2;
    }
    
    acceleration = base_acceleration;
    air_acceleration = acceleration * 2;
}();

/// @description Applies slope friction to the player's horizontal speed, if appropriate.
/// @param {Real} force Friction value to use.
player_resist_slope = function(_force)
{
    // Abort if moving along a ceiling
    if (local_direction >= 135 and local_direction <= 225) exit;
    
    // Apply (Sonic 3 method)
    var slope_factor = dsin(local_direction) * _force;
    if (abs(slope_factor) >= 0.05078125) x_speed -= slope_factor;
};

/// @description Sets the player's Boost Mode, applying any modifiers afterward.
player_refresh_boost_mode = function()
{
    var boost_mode_config = db_read(SAVE_DATABASE, true, "boost_mode");
    boost_index = (global.ring_count > 10 ? 1 : 0) + min(global.ring_count / 50, 3);
    
    if (boost_mode)
    {
        if (on_ground or superspeed_time < 0)
        {
            boost_speed = boost_thresholds[boost_index] / 0.75;
            if (abs(x_speed) < 4.5 or superspeed_time < 0)
            {
                boost_mode = false;
                boost_speed = 0;
            }
        }
    }
    else if (boost_mode_config)
    {
        if (on_ground and abs(x_speed) >= speed_limit and not (superspeed_time < 0))
        {
            if (boost_speed >= boost_thresholds[boost_index] / 0.75)
            {
                boost_mode = true;
                player_speed_break();
                camera_set_x_lag_time(16);
                audio_play_single(sndSpeedBreak);
            }
        }
        else
        {
            boost_speed = 0;
        }
    }
    
    if (boost_mode_config or boost_mode)
    {
        if (boost_mode or superspeed_time > 0)
        {
            speed_limit = 12;
            speed_cap = 16;
        }
        else
        {
            speed_limit = 6;
            speed_cap = 9;
        }
        
        // TODO: Halve speed_limit when underwater.
        
        acceleration = base_acceleration + (2 / 256) * min(global.ring_count / 50, 30);
        if (global.ring_count > 10) acceleration += 4 / 256;
        air_acceleration = acceleration * 2;
    }
};

/// @description Resets the player's status.
player_refresh_status = function()
{
    aerial_flags &= ~AERIAL_FLAG_SHIELD_ACTION;
    recovery_time = 0;
    invincibility_time = 0;
    superspeed_time = 0;
    confusion_time = 0;
    shield.index = SHIELD.NONE;
}();

/// @description Resets the player's inputs.
player_refresh_inputs = function()
{
    input_axis_x = 0;
    input_axis_y = 0;
    
    struct_foreach(input_button, function(_name, _value)
    {
        var verb = _value.verb;
        _value.check = false;
        _value.pressed = false;
        _value.released = false;
    });
};

/// @description Resets the player's input records.
player_refresh_cpu_records = function()
{
    array_foreach(cpu_axis_x, function(_element, _index) { _element = 0; });
    array_foreach(cpu_axis_y, function(_element, _index) { _element = 0; });
    array_foreach(cpu_input_jump, function(_element, _index) { _element = false; });
    array_foreach(cpu_input_jump_pressed, function(_element, _index) { _element = false; });
};