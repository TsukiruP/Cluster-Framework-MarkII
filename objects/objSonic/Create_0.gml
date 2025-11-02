/// @description Initialize
// Inherit the parent event
event_inherited();

player_animate = function()
{
    switch (animation_data.index)
    {
        case PLAYER_ANIMATION.IDLE:
        {
            animation_set(global.ani_sonic_idle_v0);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.TEETER:
        {
            var variants = [global.ani_sonic_teeter_front_v0, global.ani_sonic_teeter_back_v0];
            animation_data.variant = (cliff_sign != image_xscale);
            animation_set(variants);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.TURN:
        {
            var variants = [global.ani_sonic_turn_v0, global.ani_sonic_turn_brake_v0];
            animation_set(variants);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.RUN:
        {
            var variants = [global.ani_sonic_run_v0, global.ani_sonic_run_v1, global.ani_sonic_run_v2, global.ani_sonic_run_v3, global.ani_sonic_run_v4];
            var run_speed = clamp((abs(x_speed) / 3) + (abs(x_speed) / 4), 0.5, 8);
            player_set_run_variant();
            animation_set(variants);
            player_set_radii(6, 14);
            if (on_ground) animation_data.speed = run_speed;
            image_angle = direction;
            break;
        }
        case PLAYER_ANIMATION.BRAKE:
        {
            var variants = [global.ani_sonic_brake_v0, global.ani_sonic_brake_fast_v0];
            animation_set(variants);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.LOOK:
        {
            var variants = [global.ani_sonic_look_v0, global.ani_sonic_look_v1];
            animation_set(variants);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.CROUCH:
        {
            var variants = [global.ani_sonic_crouch_v0, global.ani_sonic_crouch_v1];
            animation_set(variants);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.ROLL:
        {
            animation_set(global.ani_sonic_roll_v0);
            player_set_radii(6, 9);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.SPIN_DASH:
        {
            var variants = [global.ani_sonic_spin_dash_v0, global.ani_sonic_spin_dash_v1];
            if (animation_is_finished()) animation_data.variant = 0;
            animation_set(variants);
            player_set_radii(6, 9);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.FALL:
        {
            var variants = [global.ani_sonic_fall_v0, global.ani_sonic_fall_v1];
            if (animation_data.variant == 0 and animation_is_finished())
            {
                animation_data.variant = 1;
            }
            animation_set(variants);
            player_set_radii(6, 14);
            image_angle = angle_straighten(direction, image_angle);
            break;
        }
        case PLAYER_ANIMATION.JUMP:
        {
            var variants = [global.ani_sonic_jump_v0, global.ani_sonic_jump_v1, global.ani_sonic_jump_v2];
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
                if (y_speed > 0)
                {
                    if (not is_undefined(player_find_floor(y_radius + 32))) animation_data.variant = 2;
                }
            }
            animation_set(variants);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.SPRING:
        {
            var variants = [global.ani_sonic_spring_v0, global.ani_sonic_spring_v1, global.ani_sonic_spring_v2];
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
            animation_set(variants);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
        case PLAYER_ANIMATION.SPRING_TWIRL:
        {
            animation_set(global.ani_sonic_spring_twirl);
            player_set_radii(6, 14);
            image_angle = gravity_direction;
            break;
        }
    }
};