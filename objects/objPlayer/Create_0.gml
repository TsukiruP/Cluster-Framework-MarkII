/// @description Initialize
image_speed = 0;

// Constants
enum PHASE
{ 
    ENTER,
    STEP,
    EXIT
}

enum PLAYER_ANIMATION
{ 
    IDLE,
    TEETER,
    TURN,
    RUN,
    BRAKE,
    LOOK,
    CROUCH,
    ROLL,
    SPIN_DASH,
    FALL,
    JUMP,
    HURT,
    DEAD,
    TRICK_UP,
    TRICK_DOWN,
    TRICK_FRONT,
    TRICK_BACK,
    SPRING,
    SPRING_TWIRL
}

enum TRICK
{
	UP,
	DOWN,
	FRONT,
	BACK
}

enum CPU_INPUT
{
	X,
	Y,
	JUMP,
	JUMP_PRESSED,
	MAX
}

enum CPU_STATE
{
	FOLLOW,
	CROUCH,
	SPIN_DASH
}

#macro PLAYER_HEIGHT 14

// State machine
state = player_is_ready;
state_changed = false;

jump_action = false;
jump_cap = true;

spin_dash_charge = 0;

trick_index = TRICK.FRONT;
trick_speed = array_create(TRICK.BACK + 1);
for (var i = 0; i < array_length(trick_speed); i++) trick_speed[i] = array_create(2);

// Timers
control_lock_time = 0;
trick_time = 0;
superspeed_time = 0;
invincibility_time = 0;
invulnerability_time = 0;
input_cpu_state_time = 0;
input_cpu_respawn_time = 0;
input_cpu_gamepad_time = 0;
camera_look_time = 0;

slide_duration = 30;
spring_duration = 16;
trick_lock_duration = 9;
invulnerability_duration = 120;
input_cpu_respawn_duration = 300;
input_cpu_gamepad_duration = 600;

// Physics
x_speed = 0;
y_speed = 0;

player_refresh_physics();

slide_threshold = 2.5;

air_drag_threshold = 0.125;
air_drag = 0.96875;

// Collision detection
x_radius = 8;
x_wall_radius = 10;

y_radius = 15;
y_tile_reach = 16;

hitboxes[0] = new hitbox(c_maroon);
hitboxes[1] = new hitbox(c_green);

landed = false;
on_ground = true;
ground_snap = true;

direction = 0;
gravity_direction = 0;
local_direction = 0;
mask_direction = 0;

cliff_sign = 0;

tilemaps =
[
	layer_tilemap_get_id("TilesMain")
];

if (layer_exists("TilesLayer0"))
{
    array_push(tilemaps, layer_tilemap_get_id("TilesLayer0"));
    collision_layer = 0;
}

semisolid_tilemap = layer_tilemap_get_id("TilesSemisolid");

solid_objects = [];

// Input
input_axis_x = 0;
input_axis_y = 0;

/// @function button(verb)
/// @description Creates a new button.
/// @param {Enum.INPUT_VERB} verb Verb to check.
function button(_verb) constructor
{
    verb = _verb;
    check = false;
    pressed = false;
    released = false;
}

input_button =
{
    jump : new button(INPUT_VERB.JUMP),
    aux : new button(INPUT_VERB.AUX),
    swap : new button(INPUT_VERB.SWAP),
    extra : new button(INPUT_VERB.EXTRA),
    tag : new button(INPUT_VERB.TAG),
    alt : new button(INPUT_VERB.ALT),
    start : new button(INPUT_VERB.START),
    select : new button(INPUT_VERB.SELECT)
};

/// @method player_reset_input()
/// @description Resets all player input.
player_reset_input = function()
{
	input_axis_x = 0;
	input_axis_y = 0;
	
	struct_foreach(input_button, function(name, value)
	{
	    var verb = value.verb;
	    value.check = false;
	    value.pressed = false;
	    value.released = false;
	});
};

// CPU
input_cpu_state = 0;
input_cpu_history = array_create(CPU_INPUT.MAX);
for (var i = 0; i < array_length(input_cpu_history); i++) input_cpu_history[i] = array_create(16);

/// @method player_record_cpu_input(cpu_input)
/// @description Records the given CPU input.
/// @param {Enum.CPU_INPUT} CPU input to record.
player_record_cpu_input = function(cpu_input)
{
	var input;
	switch (cpu_input)
	{
		case CPU_INPUT.X:
		{
			input = input_axis_x;
			break;
		}
		case CPU_INPUT.Y:
		{
			input = input_axis_y;
			break;
		}
		case CPU_INPUT.JUMP:
		{
			input = input_button.jump.check;
			break;
		}
		case CPU_INPUT.JUMP_PRESSED:
		{
			input = input_button.jump.pressed;
			break;
		}
	}
	
	array_shift(input_cpu_history[cpu_input]);
	array_push(input_cpu_history[cpu_input], input);
};

// Animation
animation_data = new animation_core();
//animation_history = array_create(16);

// Effects
/// @function player_effect()
/// @description Creates a new player effect.
function player_effect() constructor
{
    x = 0;
    y = 0;
    sprite_index = -1;
    image_index = 0;
    image_xscale = 1;
    image_yscale = 1;
    image_angle = 0;
    animation_data = new animation_core();
    static draw = function()
    {
        if (sprite_index != -1) draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
    };
}

spin_dash_effect = new player_effect();

// Camera
camera = noone;
camera_offset_x = 0;
camera_offset_y = 0;
camera_padding_x = 0;
camera_padding_y = 0;

// Misc.
player_index = -1;

/// @method player_perform(action, [enter])
/// @description Sets the given function as the player's current state.
/// @param {Function} action State function to set.
/// @param {Bool} enter Whether to perform the enter phase.
player_perform = function(action, enter = true)
{
	state(PHASE.EXIT);
	state = action;
	state_changed = true;
	if (enter) state(PHASE.ENTER);
};

/// @method player_try_jump()
/// @description Sets the player's current state to jumping, if applicable.
/// @returns {Bool}
player_try_jump = function()
{
    if (input_button.jump.pressed)
    {
        player_perform(player_is_jumping);
        animation_init(object_index == objAmy ? PLAYER_ANIMATION.SPRING : PLAYER_ANIMATION.JUMP);
        return true;
    }
    return false;
};

/// @method player_try_trick([time])
/// @desctiption Sets the player's current state to tricking, if applicable.
/// @param [time] Time to check (optional, defaults to trick_time).
/// @returns {Bool}
player_try_trick = function(time = trick_time)
{
	if (time == 0 and input_button.tag.pressed)
	{
		trick_index = TRICK.BACK;
		if (input_axis_y == -1) trick_index = TRICK.UP;
		else if (input_axis_y == 1) trick_index = TRICK.DOWN;
		else if (input_axis_x == image_xscale) trick_index = TRICK.FRONT;
        score += 100;
		player_perform(player_is_trick_preparing);
        if (not ((object_index == objSonic or object_index == objKnuckles or object_index == objAmy) and trick_index == TRICK.DOWN)) audio_play_single(sfxTrick);
		return true;
	}
	return false;
};

/// @method player_rotate_mask()
/// @description Rotates the player's virtual mask, if applicable.
player_rotate_mask = function()
{
	static rotation_lock_time = 0;
	if (rotation_lock_time > 0) then --rotation_lock_time;
	
	var new_rotation = (round(direction / 90) mod 4) * 90;
	if (mask_direction != new_rotation and (landed or rotation_lock_time == 0))
	{
		mask_direction = new_rotation;
		rotation_lock_time = (not landed) * max(16 - abs(x_speed * 2) div 1, 0);
	}
};

/// @method player_resist_slope(force)
/// @description Applies slope friction to the player's horizontal speed, if appropriate.
/// @param {Real} force Friction value to use.
player_resist_slope = function(force)
{
	// Abort if...
	if (x_speed == 0 and control_lock_time == 0) exit; // Not moving
	if (local_direction < 22.5 or local_direction > 337.5) exit; // Moving along a shallow slope
	if (local_direction >= 135 and local_direction <= 225) exit; // Attached to a ceiling
	
	// Apply
	x_speed -= dsin(local_direction) * force;
};

/// @method player_animate()
/// @description Sets the player's current animation.
player_animate = function() {};

/// player_set_animation(ani, [ang])
/// @description Sets the given animation as the player's current animation.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
/// @param {Real} [ang] Angle to set (optional, defaults to gravity_direction).
player_set_animation = function(ani, ang = gravity_direction)
{
	animation_set(ani);
	image_angle = ang;
};

/// player_animate_teeter(ani)
/// @description Sets the given animation as the player's current teeter animation.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_teeter = function(ani)
{
	animation_data.variant = (cliff_sign != image_xscale);
    player_set_animation(ani);
};

/// player_animate_run(ani)
/// @description Sets the given animation as the player's current run animation.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
/// @param {Real} [ang] Angle to set (optional, defaults to direction).
player_animate_run = function(ani, ang = direction)
{
    var variant = animation_data.variant;
    if (on_ground)
    {
    	var abs_speed = abs(x_speed);
        variant = 5;
    	if (abs_speed <= 1.25) variant = 0;
	    else if (abs_speed <= 2.5) variant = 1;
	    else if (abs_speed <= 4.0) variant = 2;
	    else if (abs_speed <= 9.0) variant = 3;
	    else if (abs_speed <= 10.0) variant = 4;
    }
    player_set_animation(ani, ang);
    animation_data.variant = variant;
    if (on_ground) animation_data.speed = clamp((abs(x_speed) / 3) + (abs(x_speed) / 4), 0.5, 8);
};

/// player_animate_fall(ani)
/// @description Sets the given animation as the player's current fall animation.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_fall = function(ani)
{
	if (animation_data.variant == 0 and animation_is_finished()) animation_data.variant = 1;
    player_set_animation(ani, rotate_towards(direction, image_angle));
};

/// player_animate_jump(ani)
/// @description Sets the given animation as the player's current jump animation.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_jump = function(ani)
{
	switch (animation_data.variant)
    {
        case 0:
        {
            if (animation_is_finished()) animation_data.variant = 1;
            break;
        }
        case 1:
        {
            if (y_speed > 0 and not is_undefined(player_find_floor(y_radius + 32))) animation_data.variant = 2;
            break;
        }
    }
    player_set_animation(ani);
};

/// player_animate_spring(ani)
/// @description Sets the given animation as the player's current spring animation.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_spring = function(ani)
{
	switch (animation_data.variant)
    {
        case 0:
        {
            if (y_speed > 0) animation_data.variant = 1;
            break;
        }
        case 1:
        {
            if (animation_is_finished()) animation_data.variant = 2;
            break;
        }
    }
    player_set_animation(ani);
};

/// @method player_set_radii(xrad, yrad)
/// @description Sets the given radii as the player's virtual mask.
/// @param {Real} xrad Horizontal radius to use.
/// @param {Real} yrad Vertical radius to use.
player_set_radii = function(xrad, yrad)
{
    // Abort if radii already match
    if (x_radius == xrad and y_radius == yrad) exit;
    
    var old_x_radius = x_radius;
    var old_y_radius = y_radius;
    var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
    x_radius = xrad;
    x_wall_radius = x_radius + 2;
    y_radius = yrad;
    x += sine * (old_y_radius - y_radius);
    y += cosine * (old_y_radius - y_radius);
};

/// @method player_draw_before()
/// @description Draws player effects behind the character sprite.
player_draw_before = function() {};

/// @method player_draw_after()
/// @description Draws player effects in front of the character sprite.
player_draw_after = function() {};

/// @method player_gain_rings(num)
/// @description Increases the player's ring count by the given amount.
/// @param {Real} num Amount of rings to give.
player_gain_rings = function(num)
{
	global.rings = min(global.rings + num, 999);
	audio_play_single(sfxRing);
	
	// Gain lives
	static ring_life_threshold = 99;
	if (global.rings > ring_life_threshold)
	{
		var change = global.rings div 100;
		player_gain_lives(change - ring_life_threshold div 100);
		ring_life_threshold = change * 100 + 99;
	}
};

/// @method player_gain_lives(num)
/// @description Increases the player's life count by the given amount.
/// @param {Real} num Amount of lives to give.
player_gain_lives = function(num)
{
	lives = min(lives + num, 99);
	audio_play_life();
};

/// @method player_damage([inst])
/// @description Sets the player to be either hurt or dead. Set inst to self to instantly kill the player.
/// @param {Id.Instance} [inst] Instance to check (optional, defaults to the player).
player_damage = function(inst = self)
{
    if (state == player_is_dead or ((state == player_is_hurt or invincibility_time > 0 or invulnerability_time > 0) and inst != self)) exit;
    
    if (inst == self)
    {
        return player_perform(player_is_dead);
    }
    else
    {
    	var hurt_speed = -2;
        animation_init(PLAYER_ANIMATION.HURT);
        if (abs(x_speed) <= 2.5)
        {
            if (abs(x_speed) > 0.625) x_speed = sign(x_speed) * hurt_speed;
            else x_speed = image_xscale * hurt_speed;
            animation_data.variant = 0;
        }
        else
        {
            x_speed = sign(x_speed) * -hurt_speed;
            animation_data.variant = 1;
        }
        y_speed = -4;
        return player_perform(player_is_hurt);
    }
};