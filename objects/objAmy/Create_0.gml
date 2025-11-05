/// @description Initialize
// Inherit the parent event
event_inherited();

player_animate = function ()
{
    switch (animation_data.index)
    {
        case PLAYER_ANIMATION.IDLE:
        {
            animation_set(global.players[0].object_index == objSonic ? global.ani_amy_idle_alt_v0 : global.ani_amy_idle_v0);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.TEETER:
        {
            animation_data.variant = (cliff_sign != image_xscale);
            animation_set(global.ani_amy_teeter);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.TURN:
        {
            animation_set(global.ani_amy_turn);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.RUN:
        {
            var run_speed = clamp((abs(x_speed) / 3) + (abs(x_speed) / 4), 0.5, 8);
            player_set_run_variant();
            animation_set(global.players[0].object_index == objSonic ? global.ani_amy_run_alt : global.ani_amy_run);
            player_set_radii(6, 14);
            if (on_ground) animation_data.speed = run_speed;
            image_angle = direction;
            break;
        }
        case PLAYER_ANIMATION.BRAKE:
        {
            animation_set(global.ani_amy_brake);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.LOOK:
        {
            animation_set(global.ani_amy_look);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.CROUCH:
        {
            animation_set(global.ani_amy_crouch);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.ROLL:
        {
            animation_set(global.ani_amy_roll_v0);
            player_set_radii(6, 9);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.SPIN_DASH:
        {
            animation_set(global.ani_amy_spin_dash_v0);
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
            animation_set(global.ani_amy_fall);
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
            animation_set(global.ani_amy_jump);
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
            animation_set(global.ani_amy_spring);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.SPRING_TWIRL:
        {
            animation_set(global.ani_amy_spring_twirl);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
    }
};