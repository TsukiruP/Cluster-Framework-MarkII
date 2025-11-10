/// @description Initialize
// Inherit the parent event
event_inherited();

trick_speed =
[
    [0, -6],
    [0, 1],
    [6, 0],
    [-3.5, -2]
];

player_animate = function()
{
    switch (animation_data.index)
    {
        case PLAYER_ANIMATION.IDLE:
        {
            animation_set(global.players[0].object_index == objSonic ? global.ani_amy_idle_alt_v0 : global.ani_amy_idle_v0);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TEETER:
        {
            animation_data.variant = (cliff_sign != image_xscale);
            animation_set(global.ani_amy_teeter);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TURN:
        {
            animation_set(global.ani_amy_turn);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.RUN:
        {
            player_animate_run(global.players[0].object_index == objSonic ? global.ani_amy_run_alt : global.ani_amy_run);
            image_angle = direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.BRAKE:
        {
            animation_set(global.ani_amy_brake);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.LOOK:
        {
            animation_set(global.ani_amy_look);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.CROUCH:
        {
            animation_set(global.ani_amy_crouch);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -6, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.ROLL:
        {
            animation_set(global.ani_amy_roll_v0);
            image_angle = gravity_direction;
            player_set_radii(6, 9);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-10, -10, 10, 10);
                hitboxes[1].set_size(-10, -10, 10, 10);
            }
            break;
        }
        case PLAYER_ANIMATION.SPIN_DASH:
        {
            animation_set(global.ani_amy_spin_dash_v0);
            image_angle = gravity_direction;
            player_set_radii(6, 9);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -18, 6, 10);
                hitboxes[1].set_size(-6, -18, 6, 10);
            }
            break;
        }
        case PLAYER_ANIMATION.FALL:
        {
            if (animation_data.variant == 0 and animation_is_finished()) animation_data.variant = 1;
            animation_set(global.ani_amy_fall);
            image_angle = rotate_towards(direction, image_angle);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -14, 6, 12);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.JUMP:
        {
            player_animate_jump(global.ani_amy_jump);
            image_angle = gravity_direction;
            switch (animation_data.variant)
            {
                case 0:
                {
                    player_set_radii(6, 14);
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-10, -10, 10, 10);
                        hitboxes[1].set_size(-10, -10, 10, 10);
                    }
                    break;
                }
                case 1:
                {
                    player_set_radii(6, 9);
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-10, -10, 10, 10);
                        hitboxes[1].set_size(-10, -10, 10, 10);
                    }
                    break;
                }
                case 2:
                {
                    player_set_radii(6, 9);
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-10, -10, 10, 10);
                            hitboxes[1].set_size(-10, -10, 10, 10);
                            break;
                        }
                        case 1:
                        {
                            hitboxes[0].set_size(-6, -16, 6, 10);
                            hitboxes[1].set_size(-10, -7, 11, 15);
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.HURT:
        {
            animation_set(global.ani_sonic_hurt);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -8, 6, 24);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.DEAD:
        {
            animation_set(global.ani_sonic_dead_v0);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size();
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_UP:
        {
            if (animation_data.variant == 1 and y_speed > 0) animation_data.variant = 2;
            animation_set(global.ani_amy_trick_up);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 10);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -16, 6, 10);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 3:
                        {
                            hitboxes[0].set_size(-6, -16, 6, 10);
                            hitboxes[1].set_size(-5, -25, 4, -17);
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 10);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_DOWN:
        {
            animation_set(global.ani_amy_trick_down);
            image_angle = gravity_direction;
            player_set_radii(6, 9);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 10);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 10);
                        hitboxes[1].set_size(-26, -14, 26, 12);
                    }
                    break;
                }
                case 2:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 14);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.SPRING:
        {
            player_animate_spring(global.ani_amy_spring);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.SPRING_TWIRL:
        {
            animation_set(global.ani_amy_spring_twirl_v0);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -13, 6, 13);
                hitboxes[1].set_size();
            }
            break;
        }
    }
};