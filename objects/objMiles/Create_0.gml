/// @description Initialize
event_inherited();
character_index = CHARACTER.MILES;
trick_speed =
[
    [0, -6],
    [0, 0.5],
    [4, -2.5],
    [-3.5, -3]
];

tails = new stamp();

flight_time = 0;
flight_reset_time = 0;
flight_carry_time = 0;
flight_carry = false;
flight_hammer = false;
flight_base_force = 0.03125;
flight_ascent_force = 0.125;
flight_force = flight_base_force;
flight_buddy = noone;
flight_soundid = noone;

player_animate = function()
{
    switch (animation_data.index)
    {
        case PLAYER_ANIMATION.IDLE:
        {
            player_set_animation(global.ani_miles_idle_v0);
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
            player_animate_teeter(global.ani_miles_teeter);
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
            player_set_animation(global.ani_miles_turn);
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
            player_set_animation(global.ani_miles_brake);
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
            player_set_animation(global.ani_miles_look);
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
            player_set_animation(global.ani_miles_crouch);
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
            player_set_animation(global.ani_miles_roll_v0);
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
            player_set_animation(global.ani_miles_spin_dash);
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
            player_animate_fall(global.ani_miles_fall);
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
                            hitboxes[0].set_size(-7, -6, 5, 16);
                            hitboxes[1].set_size(-7, -6, 5, 16);
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
                            hitboxes[0].set_size(-6, -18, 8, 4);
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
            player_set_animation(global.ani_miles_hurt);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -12, 10, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-8, -9, 8, 19);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.DEAD:
        {
            player_set_animation(global.ani_miles_dead_v0);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size();
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.SPRUNG:
        {
            player_animate_spring(global.ani_miles_sprung);
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
        case PLAYER_ANIMATION.SPRUNG_TWIRL:
        {
            player_set_animation(global.ani_miles_sprung_twirl_v0);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -11, 6, 11);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_UP:
        {
            if (animation_data.variant == 1 and y_speed > 0) animation_data.variant = 2;
            player_set_animation(global.ani_miles_trick_up);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 10);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_DOWN:
        {
            player_set_animation(global.ani_miles_trick_down);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 10);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_FRONT:
        {
            if (animation_data.variant == 1 and y_speed > 0) animation_data.variant = 2;
            player_set_animation(global.ani_miles_trick_front);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 10);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_BACK:
        {
            if (animation_data.variant == 1 and y_speed > 0) animation_data.variant = 2;
            player_set_animation(global.ani_miles_trick_back);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                    case 2:
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
                        case 3:
                        {
                            hitboxes[0].set_size(-6, -12, 6, 10);
                            hitboxes[1].set_size(-23, 0, 14, 10);
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case MILES_ANIMATION.FLIGHT:
        {
            if (animation_data.variant == 1 and animation_is_finished()) animation_data.variant = 0;
            player_set_animation(global.ani_miles_flight);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -10, 6, 10);
                        hitboxes[1].set_size(-22, -23, 21, -11);
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -10, 6, 10);
                        hitboxes[1].set_size(-17, -19, 17, -11);
                    }
                    break;
                }
            }
            break;
        }
        case MILES_ANIMATION.FLIGHT_TIRED:
        {
            player_set_animation(global.ani_miles_flight_tired_v0);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 10);
                hitboxes[1].set_size();
            }
            break;
        }
        case MILES_ANIMATION.FLIGHT_CANCEL:
        {
            player_set_animation(global.ani_miles_flight_cancel_v0);
            player_set_radii(6, 14);
            switch (image_index)
            {
                case 0:
                {
                    hitboxes[0].set_size(-6, -10, 6, 10);
                    hitboxes[1].set_size();
                    break;
                }
                case 1:
                {
                    hitboxes[0].set_size(-2, -10, 10, 10);
                    hitboxes[1].set_size();
                    break;
                }
            }
            break;
        }
        case MILES_ANIMATION.HAMMER_FLIGHT:
        {
            if (animation_data.variant == 1 and animation_is_finished()) animation_data.variant = 0;
            player_set_animation(global.ani_miles_hammer_flight);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-7, -10, 6, 10);
                        hitboxes[1].set_size(-26, -22, 22, -9);
                    }
                    break;
                }
                case 1:
                {
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-7, -10, 6, 10);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 6:
                        {
                            hitboxes[0].set_size(-7, -10, 6, 10);
                            hitboxes[1].set_size(4, -24, 38, 11);
                            break;
                        }
                        case 7:
                        {
                            hitboxes[0].set_size(-7, -10, 6, 10);
                            hitboxes[1].set_size(-15, -9, 31, 32);
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
    }
};

player_draw_before = function()
{
    tails.image_alpha = image_alpha;
    with (tails) draw_self_floored();
};