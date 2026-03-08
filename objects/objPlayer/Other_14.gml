/// @description Animations

/// @description Sets the player's current animation.
player_animate = function() {};

/// @description Updates the animation history.
player_refresh_animation_history = function()
{
    with (animation_history[animation_history_index])
    {
        x = other.x div 1;
        y = other.y div 1;
        image_xscale = other.image_xscale;
        image_yscale = other.image_yscale;
        image_angle = other.image_angle;
        ani = other.animation_data.ani;
        ani_speed = other.animation_data.speed;
    }
    
    animation_history_index = ++animation_history_index mod ANIMATION_RECORD_COUNT;
};

/// @description Sets the given animation as the player's current animation.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
/// @param {Real} [ang] Angle to set (optional, defaults to gravity_direction).
player_set_animation = function(_ani, _ang = gravity_direction)
{
    animation_set(_ani);
    image_angle = _ang;
};

/// @description Sets the given animation based on teeter conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_teeter = function(_ani)
{
    animation_data.variant = (cliff_sign != image_xscale);
    player_set_animation(_ani);
};

/// @description Sets the given animation based on running conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
/// @param {Real} [ang] Angle to set (optional, defaults to direction).
player_animate_run = function(_ani, _ang = direction)
{
    var variant = (on_ground ? 5 : animation_data.variant);
    if (on_ground)
    {
        var abs_speed = abs(x_speed);
        if (abs_speed <= 1.25) variant = 0;
        else if (abs_speed <= 2.5) variant = 1;
        else if (abs_speed <= 4.0) variant = 2;
        else if (abs_speed <= 9.0) variant = 3;
        else if (abs_speed <= 11.5) variant = 4;
    }
    
    player_set_animation(_ani, _ang);
    animation_data.variant = variant;
    if (on_ground) animation_data.speed = clamp((abs(x_speed) / 3) + (abs(x_speed) / 4), 0.5, 8);
};

/// @description Sets the given animation based on falling conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_fall = function(_ani)
{
    if (animation_data.variant == 0 and animation_is_finished()) animation_data.variant = 1;
    player_set_animation(_ani, rotate_towards(mask_direction, image_angle));
};

/// @description Sets the given animation based on jumping conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_jump = function(_ani)
{
    switch (animation_data.variant)
    {
        case 0:
        {
            if (animation_is_finished()) animation_data.variant = 1;
            break;
        }
        case 1:
        {
            if (y_speed > 0 and player_boxcast(tilemaps, y_radius + 32)) animation_data.variant = 2;
            break;
        }
    }
    
    player_set_animation(_ani);
};

/// @description Sets the given animation based on spring conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_spring = function(_ani)
{
    switch (animation_data.variant)
    {
        case 0:
        {
            if (y_speed > 0) animation_data.variant = 1;
            break;
        }
        case 1:
        {
            if (animation_is_finished()) animation_data.variant = 2;
            break;
        }
    }
    
    player_set_animation(_ani);
};