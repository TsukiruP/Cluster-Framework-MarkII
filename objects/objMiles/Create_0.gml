/// @description Initialize
// Inherit the parent event
event_inherited();

// Tails
tails_effect = new player_effect();

player_animate = function ()
{
    switch (animation_data.index)
    {
        case PLAYER_ANIMATION.IDLE:
        {
            animation_set(global.ani_miles_idle_v0);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.TEETER:
        {
            animation_data.variant = (cliff_sign != image_xscale);
            animation_set(global.ani_miles_teeter);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.TURN:
        {
            animation_set(global.ani_miles_turn);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.RUN:
        {
            player_animate_run(global.ani_miles_run);
            player_set_radii(6, 14);
            image_angle = direction;
            break;
        }
        case PLAYER_ANIMATION.BRAKE:
        {
            animation_set(global.ani_miles_brake);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.LOOK:
        {
            animation_set(global.ani_miles_look);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.CROUCH:
        {
            animation_set(global.ani_miles_crouch);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.ROLL:
        {
            animation_set(global.ani_miles_roll_v0);
            player_set_radii(6, 9);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.SPIN_DASH:
        {
            if (animation_is_finished()) animation_data.variant = 0;
            animation_set(global.ani_miles_spin_dash);
            player_set_radii(6, 9);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.FALL:
        {
            if (animation_data.variant == 0 and animation_is_finished())
            {
                animation_data.variant = 1;
            }
            animation_set(global.ani_miles_fall);
            player_set_radii(6, 14);
            image_angle = rotate_towards(direction, image_angle);
            break;
        }
        case PLAYER_ANIMATION.JUMP:
        {
            if (animation_data.variant == 0)
            {
                player_set_radii(6, 14);
                if (animation_is_finished())
                {
                    animation_data.variant = 1;
                    player_set_radii(6, 9);
                }
            }
            else
            {
            	player_set_radii(6, 9);
                if (animation_data.variant == 1 and y_speed > 0)
                {
                    if (not is_undefined(player_find_floor(y_radius + 32))) animation_data.variant = 2;
                }
            }
            animation_set(global.ani_miles_jump);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.SPRING:
        {
            if (animation_data.variant == 0)
            {
                if (y_speed > 0)
                {
                    animation_data.variant = 1;
                }
            }
            else if (animation_is_finished())
            {
                animation_data.variant = 2;
            }
            animation_set(global.ani_miles_spring);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.SPRING_TWIRL:
        {
            animation_set(global.ani_miles_spring_twirl);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
    }
};

player_draw_before = function ()
{
    with (tails_effect) draw_effect();
};