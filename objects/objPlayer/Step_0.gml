/// @description Behave
#region Input

input_axis_x = InputOpposing(INPUT_VERB.LEFT, INPUT_VERB.RIGHT, input_channel);
input_axis_y = InputOpposing(INPUT_VERB.UP, INPUT_VERB.DOWN, input_channel);

struct_foreach(input_button, function (name, value)
{
    var verb = value.index;
    value.check = InputCheck(verb, input_channel);
    value.pressed = InputPressed(verb, input_channel);
    value.released = InputReleased(verb, input_channel);
});

#endregion

#region Perform

state(PHASE.STEP);
if (state_changed) state_changed = false;
player_animate();

#endregion

#region Camera

var sine = dsin(gravity_direction);
var cosine = dcos(gravity_direction);

#region Offset

var ox = 0;
var oy = 0;

if (mask_direction == gravity_direction and abs(x_speed) > 6)
{
    if (camera_offset_x != 64 * sign(x_speed)) camera_offset_x += 2 * sign(x_speed);
}
else if (camera_offset_x != 0)
{
    camera_offset_x -= 2 * sign(camera_offset_x);
}

if (camera_offset_y != 0 and ((state != player_is_looking and state != player_is_crouching) or camera_look_time > 0))
{
    camera_offset_y -= 2 * sign(camera_offset_y);
}

ox += cosine * camera_offset_x + sine * camera_offset_y;
oy += -sine * camera_offset_x + cosine * camera_offset_y;

#endregion

#region Padding

var px = 0;
var py = 0;

camera_padding_y = PLAYER_HEIGHT - y_radius;

px += cosine * camera_padding_x + sine * camera_padding_y;
py += sine * camera_padding_x + cosine * camera_padding_y;

#endregion

with (camera)
{
    offset(ox, oy);
    padding(px, py);
    center(false, other.on_ground);
    spd_max_y = (other.x_speed >= 8 or not other.on_ground ? 24 : 6);
    
    if (follow != other)
    {
        move(other.x, other.y);
        follow = other;
    }
}

#endregion