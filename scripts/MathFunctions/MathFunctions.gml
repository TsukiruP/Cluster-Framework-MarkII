/// @description Wraps the given angle between 0 and 360 degrees exclusively.
/// @param {Real} ang Angle to wrap.
/// @returns {Real}
function angle_wrap(_ang)
{
	return (_ang mod 360 + 360) mod 360;
}

/// @description Rotates the source angle to the destination angle.
/// @param {Real} dest Destination angle.
/// @param {Real} src Source angle.
/// @param {Real} amt The maximum amount to straighten by (optional, default is 2.8125).
/// @returns {Real}
function rotate_towards(_dest, _src, _amt = 2.8125)
{
	if (_src != _dest)
	{
		var diff = angle_difference(_dest, _src);
		return _src + min(_amt, abs(diff)) * sign(diff);
	}
    return _src;
}

/// @description Maintains the given value between the given range by overflowing or underflowing.
/// @param {Real} val Value to wrap.
/// @param {Real} min Minimum value.
/// @param {Real} max Maximum value.
/// @returns {Real}
function clamp_inverse(_val, _min, _max)
{
    if (_val < _min) return _max;
    else if (_val > _max) return _min;
    return _val;
}

/// @description Converts the given hexadecimal value to decimal, assuming the value is signed.
/// @param {Real} val Value to convert.
/// @param {Real} [bits] Number of bits (optional, defaults to 8).
/// @returns {Real}
function hex_to_dec(_val, _bits = 8)
{
    var maximum = power(2, _bits);
    if (_val >= maximum / 2) _val -= maximum;
    return _val;
}

/// @description Converts the given time to frames.
/// @param {Real} minutes Minutes to convert.
/// @param {Real} seconds Seconds to convert.
/// @returns {Real}
function time_to_frames(_minutes, _seconds)
{
    return (_minutes * 3600) + (_seconds * 60);
}

/// @description Wraps the given value between the given range - maximum exclusive. Ported from GM8.2.
/// @param {Real} val Value to wrap.
/// @param {Real} min Minimum value.
/// @param {Real} max Maximum value.
/// @returns {Real}
function modwrap(_val, _min, _max)
{
    var diff = _val - _min;
    var range = _max - _min;
    return diff - floor(diff / range) * range + _min;
}

/// @description Checks if the given value is 0, returning the given default if applicable. Ported from GM8.2.
/// @param {Real} val Value to get the sign of.
/// @param {Real} def Default value to give if the value is 0.
/// @returns {Real}
function esign(_val, _def)
{
    if (_val == 0) return _def;
    return sign(_val);
}

/// @description Find the value of a as it approaches b with the given step. Ported from GM8.2.
/// @param {Real} a First value.
/// @param {Real} b Second value.
/// @param {Real} step Amount to step.
/// @returns {Real}
function approach(_a, _b, _step)
{
    if (_a < _b) return min(_a + _step, _b);
    return max (_a - _step, _b);
}

/// @description x-component of two-dimensional lengthdir of a point. Ported from GM8.2.
/// @param {Real} x x-coordinate of the point.
/// @param {Real} y y-coordinate of the point.
/// @param {Real} dir Direction of the point.
/// @returns {Real}
function pivot_pos_x(_x, _y, _dir)
{
    return (dcos(_dir) * _x) + (dcos(_dir - 90) * _y);
}

/// @description y-component of two-dimensional lengthdir of a point. Ported from GM8.2.
/// @param {Real} x x-coordinate of the point.
/// @param {Real} y y-coordinate of the point.
/// @param {Real} dir Direction of the point.
/// @returns {Real}
function pivot_pos_y(_x, _y, _dir)
{
    return (dsin(_dir) * -_x) + (dsin(_dir - 90) * -_y);
}