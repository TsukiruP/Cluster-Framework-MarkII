/// @description Effects
// Inherit the parent event
event_inherited();

var rolling = (animation_data.ani == global.ani_cream_roll_v0 || animation_data.ani == global.ani_cream_jump_v1);

with (ears_accessory)
{
    if (rolling)
    {
        x = other.x;
        y = other.y;
        image_xscale = other.image_xscale;
        
        if (other.on_ground)
        {
            image_angle = angle_wrap(other.direction);
        }
        else
        {
        	image_angle = rotate_towards(other.gravity_direction, image_angle);
        }
        
        animation_set(global.ani_cream_ears_v0);
    }
    else if (not is_undefined(animation_data.ani))
    {
        animation_set(undefined);
    }
}