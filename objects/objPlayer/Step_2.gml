/// @description Effects
var sine = dsin(gravity_direction);
var cosine = dcos(gravity_direction);
var action = state;

#region Spin Dash

with (spin_dash_effect)
{
    if (action == player_is_spin_dashing)
    {
        var charge = floor(other.spin_dash_charge);
        var variants = [global.ani_spin_dash_v0, global.ani_spin_dash_v1];
        x = other.x + sine * other.y_radius;
        y = other.y + cosine * other.y_radius;
        image_xscale = other.image_xscale;
        image_angle = other.mask_direction;
        animation_data.variant = (charge > 2);
        animation_set(variants);
    }
    else
    {
        animation_set(undefined);
    }
}

#endregion