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
        x = x_int div 1;
        y = y_int div 1;
        image_angle = other.gravity_direction;
        
        if (invincible)
        {
            animation_set(global.ani_shield_invin_v0);
        }
        else 
        {
        	switch (shield)
            {
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
                    animation_set(global.ani_shield_fire);
                    break;
                }
                case SHIELD.BUBBLE:
                {
                    animation_set(global.ani_shield_bubble);
                    visible = ctrlGame.game_time mod 4 < 2;
                    break;
                }
                case SHIELD.LIGHTNING:
                {
                    if (animation_is_finished()) animation_data.variant = (animation_data.variant == 0 ? 1 : 0)
                    animation_set(global.ani_shield_lightning);
                    break;
                }
            }
        }
        
        if (shield == SHIELD.BASIC or shield == SHIELD.MAGNETIC or invincible) visible = ctrlGame.game_time mod 4 < 2;
    }
    else if (not is_undefined(animation_data.ani))
    {
        animation_set(undefined);
    }
}

#endregion