/// @function animation(sprite, duration, [start], [loop], [order])
/// @description Creates a new animation with a given sprite and given duration.
/// @param {Asset.GMSprite} sprite Sprite to draw.
/// @param {Real|Array} duration Duration of each frame. Provide an array to set the duration per frame.
/// @param {Real} [start] Start frame. If a custom order is provided, this will be an index in that order.
/// @param {Real} [loop] Loop frame. If a custom order is provided, this will be an index in that order.
/// @param {Array} [order] Custom frame order.
function animation(sprite, duration, start = 0, loop = 0, order = []) constructor
{
    sprite_index = sprite;
    duration_data = duration;
    start_index = start;
    loop_index = loop;
    image_order = order;
}

/// @function animation_core()
/// @description Creates a new animation core.
function animation_core() constructor
{
    index  = 0;
    variant = 0;
    ani = undefined;
    force = false;
    alarm = 0;
    speed = 1;
    pos = 0;
}

/// @function effect()
/// @description Creates an effect struct.
function effect() constructor
{
    x = 0;
    y = 0;
    sprite_index = -1;
    image_index = 0;
    image_xscale = 1;
    image_yscale = 1;
    image_angle = 0;
    animation_data = new animation_core();
    static draw = function()
    {
        if (sprite_index != -1) draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
    };
}


/// @function animation_init(index, [variant], [force], [alternatives])
/// @description Initializes the next animation. Resets the variant when applicable.
/// @param {Real} index Animation index to initialize.
/// @param {Real} [variant] Animation variant to initialize.
/// @param {Bool} [force] Force the animation to restart.
/// @param {Array} [alternatives] Alternative animations that will be treated as the given index. 
function animation_init(index, variant = -1, force = false, alternatives = [])
{
    // Abort if...
    if (not force)
    {
        if (animation_data.index == index && animation_data.variant == variant) exit; // Index is the same
        if (array_contains(alternatives, animation_data.index)) exit; // Index is considered an alternative
    }
    
    if (variant == -1)
    {
        if (animation_data.index != index) variant = 0;
        else variant = animation_data.variant;
    }
    
    animation_data.index = index;
    animation_data.variant = variant;
    animation_data.force = force;
}

/// @function animation_set(ani)
/// @description Sets the animation core's animation.
/// @param {Undefined|Struct.animation|Array} ani Animation to play. Accepts an array as animation variants.
function animation_set(ani)
{
    ani = (is_array(ani) ? ani[min(array_length(ani) - 1, animation_data.variant)] : ani);
    
    if (is_undefined(ani))
    {
        animation_data.alarm = 0;
        animation_data.pos = 0;
        sprite_index = -1;
        image_index = 0;
    }
    else if (animation_data.ani != ani or animation_data.force)
    {
        var sprite = ani.sprite_index;
        var duration = ani.duration_data;
        var start = ani.start_index;
        var loop = ani.loop_index;
        var order = ani.image_order;
        
        animation_data.alarm = (is_array(duration) ? duration[start] : duration);
        animation_data.pos = start;
        sprite_index = sprite;
        image_index = (array_length(order) ? order[start] : start);
    }
    
    animation_data.ani = ani;
    animation_data.force = false;
    animation_data.speed = 1;
}

/// @function animation_update()
/// @description Updates the given core.
function animation_update()
{
    if (not is_undefined(animation_data.ani))
    {
        if (animation_data.alarm > 0)
        {
            animation_data.alarm -= animation_data.speed;
            
            if (animation_data.alarm <= 0)
            {
                var ani = animation_data.ani;
                var sprite = ani.sprite_index;
                var duration = ani.duration_data;
                var order = ani.image_order;
                var order_length = array_length(order);
                var last = (order_length > 0 ? order_length - 1 : sprite_get_number(sprite) - 1);
                
                animation_data.pos++;
                
                if (animation_data.pos > last)
                {
                    var loop = ani.loop_index;
                    animation_data.pos = loop;
                }
                
                if (animation_data.pos != -1)
                {
                    animation_data.alarm = (is_array(duration) ? duration[animation_data.pos] : duration);
                    image_index = (order_length > 0 ? order[animation_data.pos] : animation_data.pos);
                }
            }
        }
    }
}

/// @function animation_is_finished()
/// @description Checks if the animation core is finished animating.
/// @returns {Bool}
function animation_is_finished()
{
    return animation_data.pos == -1;
}