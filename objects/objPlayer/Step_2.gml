/// @description Accessories
if (ctrlGame.game_paused) exit;

var sine = dsin(gravity_direction);
var cosine = dcos(gravity_direction);
var action = state;

#region Spin Dash Dust

with (spin_dash_accessory)
{
    if (action == player_is_spin_dashing)
    {
        var charge = floor(other.spin_dash_charge);
        x = other.x + sine * other.y_radius;
        y = other.y + cosine * other.y_radius;
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

with (shield_accessory)
{
    var shield = other.shield;
    var invincible = (other.invin_time > 0);
    if (shield != SHIELD.NONE or invincible)
    {
        x = other.x;
        y = other.y;
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