/// @description Effects
if (ctrlGame.game_paused) exit;

var sine = dsin(gravity_direction);
var cosine = dcos(gravity_direction);
var action = state;

#region Spin Dash

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