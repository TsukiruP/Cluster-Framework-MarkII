/// @description Initialize
image_speed = 0;

// State machine
state = player_is_ready;
state_changed = false;

rolling = false;

spindash_charge = 0;

// Timers
rotation_lock_time = 0;
control_lock_time = 0;

camera_look_delay = 120;
camera_look_time = camera_look_delay;

// Movement and collision
x_speed = 0;
y_speed = 0;

slide_threshold = 2.5;
slide_duration = 30;

air_drag_threshold = 0.125;
air_drag = 0.96875;

roll_threshold = 0.5;

x_radius = 8;
x_wall_radius = 10;

y_radius = 15;
y_tile_reach = 16;

landed = false;
on_ground = true;
ground_id = noone;

direction = 0;
gravity_direction = 0;
local_direction = 0;
mask_direction = 0;

hard_colliders = [layer_tilemap_get_id("CollisionMain")];
semisolid_tilemap = layer_tilemap_get_id("CollisionSemisolid");
tilemap_count = array_length(hard_colliders);

// Methods
var n = 0;
repeat (16) event_user(n++);

// Misc.
instance_create_layer(x, y, layer, objCamera, { gravity_direction });

// Animations
animations =
{
	idle: animSonicIdle,
	walk: animSonicWalk,
	run: animSonicRun,
	roll: animSonicRoll,
	look: animSonicLook,
	crouch: animSonicCrouch,
	spindash: animSonicSpindash
};