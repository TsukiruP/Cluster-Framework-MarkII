/// @description Checks if the given instance is visible within the game view.
/// @param {Asset.GMObject|Id.Instance} [obj] Object or instance to check (optional, default is the calling instance).
/// @param {Real} [padding] Distance in pixels to extend the size of the view when checking (optional, default is the CAMERA_PADDING macro).
/// @returns {Bool}
function instance_in_view(_obj = id, _padding = CAMERA_PADDING)
{
    var left = camera_get_view_x(CAMERA_ID);
    var top = camera_get_view_y(CAMERA_ID);
    var right = left + CAMERA_WIDTH;
    var bottom = top + CAMERA_HEIGHT;
    
    with (_obj) return point_in_rectangle(x, y, left - _padding, top - _padding, right + _padding, bottom + _padding);
}

/// @description Creates a new particle with the given animation.
/// @param {Real} x x-coordinate of the particle.
/// @param {Real} y y-coordinate of the particle.
/// @param {Struct.animation} ani animation of the particle.
/// @param {Real} [rot] Rotation of the particle (optional, defaults to 0).
/// @param {Real} [life] Lifespan of the particle (optional, defaults to -1).
/// @param {Real} [xspd] x-speed of the particle (optional, defaults to 0).
/// @param {Real} [yspd] y-speed of the particle (optional, defaults to 0).
/// @param {Real} [xaccel] x-acceleration of the particle (optional, defaults to 0).
/// @param {Real} [yaccel] y-acceleration of the particle (optional, defaults to 0).
/// @returns {Id.Instance}
function particle_create(_x, _y, _ani, _rot = 0, _life = -1, _xspd = 0, _yspd = 0, _xaccel = 0, _yaccel = 0)
{
    var particle = instance_create_depth(_x, _y, ctrlStage.particles_depth, objParticle);
    with (particle)
    {
        animation_set(_ani);
        image_angle = angle_wrap(_rot);
        
        lifespan = _life;
        x_speed = _xspd;
        y_speed = _yspd;
        x_acceleration = _xaccel;
        y_acceleration = _yaccel;
    }
    
    return particle;
}

/// @description Returns an option based on the given value. Ported from GM8.2.
/// @param {Real} val Value to check.
/// @param {Array} options Options to return.
/// @returns {Any}
function pick(_val, _options)
{
	return _options[(max(_val, 0) mod array_length(_options))];
}

/// @description Pads the given value with zeros to occupy the specified dimensions. Ported from GM8.2.
/// @param {Real} val Value to pad.
/// @param {Real} digits Number of spaces to occupy.
/// @returns {String}
function string_pad(_val, _digits)
{
    return string_repeat("-", _val < 0) + string_replace_all(string_format(abs(_val), _digits, 0), " ", "0");
}