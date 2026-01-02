/// @description Stamps
var x_int = x div 1;
var y_int = y div 1;
var sine = dsin(gravity_direction);
var cosine = dcos(gravity_direction);
var action = state;

#region Spin Dash Dust

with (spin_dash_stamp)
{
    if (action == player_is_spin_dashing)
    {
        var charge = floor(other.spin_dash_charge);
        x = x_int + sine * other.y_radius;
        y = y_int + cosine * other.y_radius;
        image_xscale = other.image_xscale;
        image_angle = other.mask_direction;
        animation_data.variant = (charge > 2);
        animation_set(global.ani_spin_dash_dust);
    }
    else if (not is_undefined(animation_data.ani))
    {
        animation_set(undefined);
    }
}

#endregion

#region Shield

with (shield_stamp)
{
    var shield = other.shield;
    var invincible = (other.invin_time > 0);
    if (shield != SHIELD.NONE or invincible)
    {
        var shield_advance = (shield == SHIELD.BASIC or shield == SHIELD.MAGNETIC or invincible);
        var flicker_config = db_read(global.config_database, CONFIG_DEFAULT_FLICKER, "flicker");
        
        x = x_int div 1;
        y = y_int div 1;
        
        animation_init(invincible ? -1 : shield);
        switch (animation_data.index)
        {
            case -1:
            {
                animation_set(global.ani_shield_invin_v0);
                if (not ctrlGame.game_paused and animation_data.time mod 8 == 0)
                {
                    var x_off = irandom_range(-16, 16);
                    var y_off = irandom_range(-16, 16);
                    particle_create(x + x_off, y + y_off, global.ani_shield_invin_sparkle_v0);
                }
                break;
            }
            case SHIELD.BASIC:
            {
                animation_set(global.ani_shield_basic_v0);
                break;
            }
            case SHIELD.MAGNETIC:
            {
                animation_set(global.ani_shield_magnetic_v0);
                break;
            }
            case SHIELD.FIRE:
            {
                if (animation_data.variant == 1 and animation_is_finished()) animation_data.variant = 0;
                animation_set(global.ani_shield_fire);
                break;
            }
            case SHIELD.BUBBLE:
            {
                switch (animation_data.variant)
                {
                    case 1:
                    {
                        animation_data.variant = 2;
                        break;
                    }
                    case 3:
                    {
                        animation_data.variant = 0;
                        break;
                    }
                }
                animation_set(global.ani_shield_bubble);
                visible = (animation_data.variant == 0 ? animation_data.time mod 4 < 2 : true);
                break;
            }
            case SHIELD.LIGHTNING:
            {
                if (animation_is_finished()) animation_data.variant = (animation_data.variant == 0 ? 1 : 0);
                animation_set(global.ani_shield_lightning);
                break;
            }
        }
        
        // Visible
        if (shield_advance)
        {
            switch (flicker_config)
            {
                case CONFIG_FLICKER.ORIGINAL:
                {
                    visible = animation_data.time mod 4 < 2;
                    break;
                }
                case CONFIG_FLICKER.VIRTUAL_CONSOLE:
                case CONFIG_FLICKER.VIRTUAL_CONSOLE_ADVANCE_3:
                {
                    visible = animation_data.time mod 6 < (flicker_config == CONFIG_FLICKER.VIRTUAL_CONSOLE_ADVANCE_3 ? 4 : 2);
                    break;
                }
            }
        }
        else if (animation_data.index == SHIELD.BUBBLE and animation_data.variant == 0)
        {
            visible = animation_data.time mod 4 < 2;
        }
        else
        {
            visible = true;
        }
        if (not (animation_data.index == SHIELD.FIRE and animation_data.variant == 1))
        {
            image_xscale = (shield_advance ? 1 : other.image_xscale);
        }
        image_angle = other.gravity_direction;
        image_alpha = (shield_advance and flicker_config == CONFIG_FLICKER.OFF ? 0.8 : 1);
    }
    else if (not is_undefined(animation_data.ani))
    {
        animation_set(undefined);
    }
}

#endregion