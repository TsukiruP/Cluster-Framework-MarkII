/// @description Initialize
event_inherited();
character_index = CHARACTER.AMY;
trick_speed =
[
    [0, -6],
    [0, 1],
    [6, 0],
    [-3.5, -2]
];

hammer_double = false;

player_animate = function()
{
    var lovely_couple = (global.characters[0] == CHARACTER.SONIC);
    switch (animation_data.index)
    {
        case PLAYER_ANIMATION.IDLE:
        {
            player_set_animation(lovely_couple ? global.ani_amy_idle_alt_v0 : global.ani_amy_idle_v0);
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
            player_animate_teeter(global.ani_amy_teeter);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-9, -12, 3, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-11, -12, 1, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.TURN:
        {
            player_set_animation(global.ani_amy_turn);
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
            player_animate_run(lovely_couple ? global.ani_amy_run_alt : global.ani_amy_run);
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
            player_set_animation(global.ani_amy_brake);
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
            player_set_animation(global.ani_amy_look);
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
            player_set_animation(global.ani_amy_crouch);
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
            player_set_animation(global.ani_amy_roll_v0);
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
            player_set_animation(global.ani_amy_spin_dash_v0);
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
            player_animate_fall(global.ani_amy_fall);
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
                            hitboxes[1].set_size(-11, -7, 10, 15);
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
            player_set_animation(global.ani_amy_hurt);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -12, 6, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
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
        case PLAYER_ANIMATION.DEAD:
        {
            player_set_animation(global.ani_amy_dead_v0);
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
            player_animate_spring(global.ani_amy_spring);
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
            player_set_animation(global.ani_amy_spring_twirl_v0);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -13, 6, 13);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_UP:
        {
            if (animation_data.variant == 1 and y_speed > 0) animation_data.variant = 2;
            player_set_animation(global.ani_amy_trick_up);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                case 2:
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
                            hitboxes[1].set_size(-4, -25, 5, -17);
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_DOWN:
        {
            player_set_animation(global.ani_amy_trick_down);
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
        case PLAYER_ANIMATION.TRICK_FRONT:
        {
            player_set_animation(global.ani_amy_trick_front);
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
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 10);
                        hitboxes[1].set_size(-14, -16, 14, 10);
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_BACK:
        {
            player_set_animation(global.ani_amy_trick_back);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 8, 10);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
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
        case PLAYER_ANIMATION.FLIGHT_RIDE:
        {
            player_set_animation(global.ani_amy_flight_ride_v0);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-1, -17, 11, 14);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.HAMMER_ATTACK:
        {
            player_set_animation(global.ani_amy_hammer_attack);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -12, 6, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 1:
                        {
                            hitboxes[0].set_size(-14, -12, 0, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 2:
                        {
                            hitboxes[0].set_size(-14, -12, -2, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 3:
                        {
                            hitboxes[0].set_size(-18, -12, -6, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 6:
                        {
                            hitboxes[0].set_size(-14, -12, -2, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 7:
                        {
                            hitboxes[0].set_size(-12, -12, 0, 16);
                            hitboxes[1].set_size(-10, -35, 20, -2);
                            break;
                        }
                        case 8:
                        {
                            hitboxes[0].set_size(-6, -12, 6, 16);
                            hitboxes[1].set_size(0, -23, 32, 16);
                            break;
                        }
                        case 12:
                        {
                            hitboxes[0].set_size(-6, -12, 6, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                    }
                    
                    // Sound
                    if (animation_is_starting(8)) audio_play_single(sfxHammerAttack);
                    break;
                }
                case 1:
                {
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -12, 6, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 8:
                        {
                            hitboxes[0].set_size(-6, -12, 6, 16);
                            hitboxes[1].set_size(0, -42, 32, 0);
                            break;
                        }
                        case 9:
                        {
                            hitboxes[0].set_size(2, -12, 14, 16);
                            hitboxes[1].set_size(7, -34, 40, 6);
                            break;
                        }
                        case 10:
                        {
                            hitboxes[0].set_size(2, -12, 14, 16);
                            hitboxes[1].set_size(11, -23, 44, 16);
                            break;
                        }
                        case 15:
                        {
                            hitboxes[0].set_size(-4, -12, 8, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 16:
                        {
                            hitboxes[0].set_size(-8, -12, 4, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 17:
                        {
                            hitboxes[0].set_size(-10, -12, 2, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                    }
                    
                    // Sound
                    if (animation_is_starting(10)) audio_play_single(sfxHammerAttack);
                    break;
                }
            }
            break;
        }
        case AMY_ANIMATION.BIG_HAMMER_ATTACK:
        {
            player_set_animation(global.ani_amy_big_hammer_attack_v0);
            player_set_radii(6, 14);
            switch (image_index)
            {
                case 0:
                {
                    hitboxes[0].set_size(-6, -12, 6, 16);
                    hitboxes[1].set_size();
                    break;
                }
                case 3:
                {
                    hitboxes[0].set_size(-8, -15, 4, 13);
                    hitboxes[1].set_size();
                    break;
                }
                case 4:
                {
                    hitboxes[0].set_size(-9, -18, 3, 10);
                    hitboxes[1].set_size();
                    break;
                }
                case 5:
                {
                    hitboxes[0].set_size(-10, -21, 2, 7);
                    hitboxes[1].set_size();
                    break;
                }
                case 6:
                {
                    hitboxes[0].set_size(-12, -23, 0, 5);
                    hitboxes[1].set_size();
                    break;
                }
                case 7:
                {
                    hitboxes[0].set_size(-12, -24, 0, 4);
                    hitboxes[1].set_size();
                    break;
                }
                case 9:
                {
                    hitboxes[0].set_size(-10, -21, 2, 7);
                    hitboxes[1].set_size(-21, -47, 14, -20);
                    break;
                }
                case 10:
                {
                    hitboxes[0].set_size(-9, -20, 3, 8);
                    hitboxes[1].set_size(8, -32, 45, 3);
                    break;
                }
                case 11:
                {
                    hitboxes[0].set_size(-5, -19, 7, 9);
                    hitboxes[1].set_size(12, -24, 54, 16);
                    break;
                }
                case 14:
                {
                    hitboxes[0].set_size(-5, -15, 7, 13);
                    hitboxes[1].set_size();
                    break;
                }
                case 16:
                {
                    hitboxes[0].set_size(-6, -12, 6, 16);
                    hitboxes[1].set_size();
                    break;
                }
            }
            
            // Sound
            if (animation_is_starting(10)) audio_play_single(sfxBigHammerAttack);
            break;
        }
        case AMY_ANIMATION.HAMMER_JUMP:
        {
            player_set_animation(global.ani_amy_hammer_jump_v0);
            player_set_radii(6, 14);
            break;
        }
        case AMY_ANIMATION.AIR_HAMMER_ATTACK:
        {
            player_set_animation(global.ani_amy_air_hammer_attack_v0);
            player_set_radii(6, 14);
            switch (image_index)
            {
                case 0:
                {
                    hitboxes[0].set_size(-10, -8, 10, 12);
                    hitboxes[1].set_size(-14, -12, 14, 16);
                    break;
                }
                case 11:
                {
                    hitboxes[0].set_size(-6, -14, 6, 12);
                    hitboxes[1].set_size();
                    break;
                }
            }
            break;
        }
    }
};