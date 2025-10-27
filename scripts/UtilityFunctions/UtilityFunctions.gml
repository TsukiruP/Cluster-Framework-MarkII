/// @function angle_wrap(ang)
/// @description Wraps the given angle between 0 and 359 degrees inclusively.
/// @param {Real} ang Angle to wrap.
/// @returns {Real}
function angle_wrap(ang)
{
	return ((ang mod 360) + 360) mod 360;
}

/// @function instance_in_view([obj], [padding])
/// @description Checks if the given instance is visible within the game view.
/// @param {Asset.GMObject|Id.Instance} [obj] Object or instance to check (optional, default is the calling instance).
/// @param {Real} [padding] Distance in pixels to extend the size of the view when checking (optional, default is the CAMERA_PADDING macro).
/// @returns {Bool}
function instance_in_view(obj = id, padding = CAMERA_PADDING)
{
	var left = global.main_camera.get_x();
	var top = global.main_camera.get_y();
	var right = left + CAMERA_WIDTH;
	var bottom = top + CAMERA_HEIGHT;
	
	with (obj) return point_in_rectangle(x, y, left - padding, top - padding, right + padding, bottom + padding);
}

/// @function effect_create(x, y, depth, ani, [xspd], [yspd], [xaccel], [yaccel])
/// @description Creates an effect with the given animation.
/// @param {Real} x x-coordinate of the effect.
/// @param {Real} y y-coordinate of the effect.
/// @param {Real} depth depth of the effect.
/// @param {Struct.animation} ani animation of the effect.
/// @param {Real} [xspd] x-speed of the effect.
/// @param {Real} [yspd] y-speed of the effect.
/// @param {Real} [xaccel] x-acceleration of the effect.
/// @param {Real} [yaccel] y-acceleration of the effect.
/// @returns {Id.Instance}
function effect_create(ox, oy, od, ani, xspd = 0, yspd = 0, xaccel = 0, yaccel = 0)
{
    var effect = instance_create_depth(ox, oy, od, objEffect);
    with (effect)
    {
        animation_set(ani);
        x_speed = xspd;
        y_speed = yspd;
        x_acceleration = xaccel;
        y_acceleration = yaccel;
    }
    return effect;
}

/// @function particle_spawn(name, x, y, [num])
/// @description Creates the given sprite particle a given number of times at the given position.
/// @param {String} name Name of the particle.
/// @param {Real} x x-coordinate of the particle.
/// @param {Real} y y-coordinate of the particle.
/// @param {Real} [num] Number of particles to create (optional, default is 1).
function particle_spawn(name, ox, oy, num = 1)
{
	with (global.sprite_particles)
	{
		part_particles_create(system, ox, oy, self[$ name], num);
	}
}