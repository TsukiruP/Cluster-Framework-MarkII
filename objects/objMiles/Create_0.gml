/// @description Initialize
// Inherit the parent event
event_inherited();

// Tails
tails_effect = new player_effect();

player_animate = function()
{
    switch (animation_data.index)
    {
        case PLAYER_ANIMATION.IDLE:
        {
            animation_set(global.ani_miles_idle_v0);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TEETER:
        {
            animation_data.variant = (cliff_sign != image_xscale);
            animation_set(global.ani_miles_teeter);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TURN:
        {
            animation_set(global.ani_miles_turn);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.RUN:
        {
            player_animate_run(global.ani_miles_run);
            image_angle = direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.BRAKE:
        {
            animation_set(global.ani_miles_brake);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.LOOK:
        {
            animation_set(global.ani_miles_look);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.CROUCH:
        {
            animation_set(global.ani_miles_crouch);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -4, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.ROLL:
        {
            animation_set(global.ani_miles_roll_v0);
            image_angle = gravity_direction;
            player_set_radii(6, 9);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-8, -8, 8, 8);
                hitboxes[1].set_size(-8, -8, 8, 8);
            }
            break;
        }
        case PLAYER_ANIMATION.SPIN_DASH:
        {
            if (animation_data.variant == 1 and animation_is_finished()) animation_data.variant = 0;
            animation_set(global.ani_miles_spin_dash);
            image_angle = gravity_direction;
            player_set_radii(6, 9);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -8, 6, 8);
                hitboxes[1].set_size(-8, -8, 8, 8);
            }
            break;
        }
        case PLAYER_ANIMATION.FALL:
        {
            if (animation_data.variant == 0 and animation_is_finished()) animation_data.variant = 1;
            animation_set(global.ani_miles_fall);
            image_angle = rotate_towards(direction, image_angle);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 12);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.JUMP:
        {
            player_animate_jump(global.ani_miles_jump);
            image_angle = gravity_direction;
            switch (animation_data.variant)
            {
                case 0:
                {
                    player_set_radii(6, 14);
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -18, 6, 4);
                            hitboxes[1].set_size(-6, -18, 6, 4);
                            break;
                        }
                        case 1:
                        {
                            hitboxes[0].set_size(-5, -6, 7, 16);
                            hitboxes[1].set_size(-5, -6, 7, 16);
                            break;
                        }
                    }
                    break;
                }
                case 1:
                {
                    player_set_radii(6, 9);
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-8, -8, 8, 8);
                        hitboxes[1].set_size(-8, -8, 8, 8);
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
                            hitboxes[0].set_size(-6, -16, 6, 6);
                            hitboxes[1].set_size(-10, -8, 10, 12);
                            break;
                        }
                        case 1:
                        {
                            hitboxes[0].set_size(-8, -18, 6, 4);
                            hitboxes[1].set_size(-9, -9, 9, 9);
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
        case PLAYER_ANIMATION.SPRING:
        {
            player_animate_spring(global.ani_miles_spring);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -12, 6, 10);
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
                            hitboxes[0].set_size(-6, -12, 6, 10);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 1:
                        {
                            hitboxes[0].set_size(-6, -14, 6, 8);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 4:
                        {
                            hitboxes[0].set_size(-6, -16, 6, 6);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 5:
                        {
                            hitboxes[0].set_size(-6, -14, 6, 6);
                            hitboxes[1].set_size();
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    hitboxes[0].set_size(-6, -16, 6, 6);
                    hitboxes[1].set_size();
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.SPRING_TWIRL:
        {
            animation_set(global.ani_miles_spring_twirl_v0);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -11, 6, 11);
                hitboxes[1].set_size();
            }
            break;
        }
    }
};

player_draw_before = function()
{
    tails_effect.draw();
};