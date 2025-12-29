/// @description Tails
// Inherit the parent event
event_inherited();

var rolling = (animation_data.ani == global.ani_miles_roll_v0 || animation_data.ani == global.ani_miles_jump_v1);

with (tails_stamp)
{
    if (rolling)
    {
        x = other.x;
        y = other.y;
        image_xscale = other.image_xscale;
        
        if (other.on_ground)
        {
            image_angle = angle_wrap(other.direction - 90);
            if (sign(other.x_speed) == -1) image_angle = angle_wrap(image_angle + 180);
        }
        else
        {
        	image_angle = angle_wrap(point_direction(0, 0, other.x_speed, other.y_speed) - 90) + other.gravity_direction;
        }
        
        animation_set(global.ani_miles_tails_v0);
    }
    else if (not is_undefined(animation_data.ani))
    {
        animation_set(undefined);
    }
}