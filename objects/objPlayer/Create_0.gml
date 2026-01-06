/// @description Setup
image_speed = 0;

character_index = CHARACTER.NONE;
player_index = -1;

// State machine
state = player_is_ready;
state_changed = false;

spin_dash_charge = 0;

fall_speed_reset = true;
jump_cap = true;

trick_index = TRICK.FRONT;
trick_speed = array_create(TRICK.BACK + 1);
for (var i = 0; i < array_length(trick_speed); i++)
{
    trick_speed[i] = array_create(2);
}

// Shield
shield = SHIELD.NONE;
shield_action = false;

// Timers
rotation_lock_time = 0;
control_lock_time = 0;
trick_time = 0;
invuln_time = 0;

invin_time = 0;
superspeed_time = 0;
confusion_time = 0;

camera_look_time = 0;

cpu_state_time = 0;
cpu_respawn_time = 0;
cpu_gamepad_time = 0;

// Physics
x_speed = 0;
y_speed = 0;

player_refresh_physics();

// Collision detection
x_radius = 8;
x_wall_radius = 10;

y_radius = 15;
y_tile_reach = 16;

hitboxes[0] = new hitbox(c_maroon);
hitboxes[1] = new hitbox(c_green);

landed = false;
on_ground = true;
//ground_snap = true;

direction = 0;
gravity_direction = 0;
local_direction = 0;
mask_direction = 0;

cliff_sign = 0;

collision_layer = 0;

// Copy the stage's tilemaps
tilemaps = variable_clone(ctrlStage.tilemaps, 0);
tilemap_count = array_length(tilemaps);

// Validate semisolid tilemap; if it exists, the tilemap count is even
semisolid_tilemap = -1;
if ((tilemap_count & 1) == 0)
{
	semisolid_tilemap = array_last(tilemaps);
	tilemap_count--;
}

// Discard the "TilesLayer1" layer tilemap, if it exists
if (tilemap_count >= 3)
{
    array_delete(tilemaps, 2, 1);
    tilemap_count--;
}

ground_id = noone;

// Input
input_axis_x = 0;
input_axis_y = 0;

/// @method button(verb)
/// @description Creates a new button.
/// @param {Enum.INPUT_VERB} verb Verb to check.
button = function(_verb) constructor
{
    verb = _verb;
    check = false;
    pressed = false;
    released = false;
};

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

// Animation
animation_data = new animation_core();
//animation_history = array_create(16);

// Stamps
spin_dash_stamp = new stamp();
shield_stamp = new stamp();

// Camera
camera = noone;

// CPU
cpu_state = 0;
cpu_axis_x = array_create(16);
cpu_axis_y = array_create(16);
cpu_input_jump = array_create(16);
cpu_input_jump_pressed = array_create(16);

// Misc.
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
        global.score_count += 100;
		player_perform(player_is_trick_preparing);
        if (not ((object_index == objSonic or object_index == objKnuckles or object_index == objAmy) and
            trick_index == TRICK.DOWN))
        {
            audio_play_single(sfxTrick);
        }
		return true;
	}
	return false;
};

/// @method player_rotate_mask()
/// @description Rotates the player's virtual mask, if applicable.
player_rotate_mask = function()
{
	if (rotation_lock_time > 0 and not landed)
	{
		rotation_lock_time--;
		exit;
	}
	
	var new_rotation = (round(direction / 90) mod 4) * 90;
	if (mask_direction != new_rotation)
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

/// @method player_set_animation(ani, [ang])
/// @description Sets the given animation within the player's animation core.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
/// @param {Real} [ang] Angle to set (optional, defaults to gravity_direction).
player_set_animation = function(ani, ang = gravity_direction)
{
	animation_set(ani);
	image_angle = ang;
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

/// @method player_animate_teeter(ani)
/// @description Sets the given animation within the player's animation core based on teeter conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_teeter = function(ani)
{
	animation_data.variant = (cliff_sign != image_xscale);
    player_set_animation(ani);
};

/// @method player_animate_run(ani)
/// @description Sets the given animation within the player's animation core based on running conditions.
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

/// @method player_animate_fall(ani)
/// @description Sets the given animation within the player's animation core based on falling conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_fall = function(ani)
{
	if (animation_data.variant == 0 and animation_is_finished()) animation_data.variant = 1;
    player_set_animation(ani, rotate_towards(direction, image_angle));
};

/// @method player_animate_jump(ani)
/// @description Sets the given animation within the player's animation core based on jumping conditions.
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

/// @method player_animate_spring(ani)
/// @description Sets the given animation within the player's animation core based on spring conditions.
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

/// @method player_gain_rings(num)
/// @description Increases the player's ring count by the given amount.
/// @param {Real} num Amount of rings to give.
player_gain_rings = function(num)
{
	global.ring_count = min(global.ring_count + num, 999);
	
	// Gain lives
    static ring_life_threshold = 99;
    if (global.ring_count > ring_life_threshold)
    {
        var change = global.ring_count div 100;
        player_gain_lives(change - ring_life_threshold div 100);
        ring_life_threshold = change * 100 + 99;
    }
};

/// @method player_lose_rings()
/// @description Creates up to 32 lost rings in circles of 16 at the player's position.
player_lose_rings = function()
{
    var total = min(global.ring_count, 32);
    var len = 4;
    var dir = 101.25;
    var flip = false;
    
    for (var ring = 0; ring < total; ring++)
    {
        if (ring == 16)
        {
            len = 2;
            dir = 101.25;
        }
        
        with (instance_create_layer(x div 1, y div 1, "Interactables", objRing))
        {
            gravity_direction = other.gravity_direction;
            x_speed = lengthdir_x(len, dir);
            y_speed = lengthdir_y(len, dir);
            lost = true;
            if (flip)
            {
                x_speed *= -1;
                dir += 22.5;
            }
        }
        flip = !flip;
    }
    
    global.ring_count = 0;
    audio_play_single(sfxLoseRings);
};

/// @method player_gain_lives(num)
/// @description Increases the player's life count by the given amount.
/// @param {Real} num Amount of lives to give.
player_gain_lives = function(num)
{
	if (LIVES_ENABLED)
    {
        global.life_count = min(global.life_count + num, 99);
        audio_play_life();
    }
};

/// @method player_obtain_item(item)
/// @description Gives the player the given item.
/// @param {Enum.ITEM} item Item to obtain.
player_obtain_item = function(item)
{
    switch (item)
    {
        case ITEM.LIFE:
        {
            player_gain_lives(1);
            break;
        }
        case ITEM.RING_BONUS:
        {
            player_gain_rings(5);
            break;
        }
        case ITEM.SUPER_RING_BONUS:
        {
            player_gain_rings(10);
            break;
        }
        case ITEM.RANDOM_RING_BONUS:
        {
            player_gain_rings(choose(1, 5, 10, 20, 30, 40));
            break;
        }
        case ITEM.BASIC:
        {
            shield = SHIELD.BASIC;
            audio_play_single(sfxItemBasic);
            break;
        }
        case ITEM.MAGNETIC:
        {
            shield = SHIELD.MAGNETIC;
            audio_play_single(sfxItemBasic);
            break;
        }
        case ITEM.FIRE:
        {
            shield = SHIELD.FIRE;
            audio_play_single(sfxItemFire);
            break;
        }
        case ITEM.BUBBLE:
        {
            shield = SHIELD.BUBBLE;
            audio_play_single(sfxItemBubble);
            break;
        }
        case ITEM.LIGHTNING:
        {
            shield = SHIELD.LIGHTNING;
            audio_play_single(sfxItemLightning);
            break;
        }
        case ITEM.INVINCIBILITY:
        {
            invin_time = INVIN_DURATION;
            if (superspeed_time < 0)
            {
                superspeed_time = 0;
                player_refresh_physics();
            }
            if (confusion_time > 0) confusion_time = 0;
            audio_play_jingle(bgmInvincibility);
            break;
        }
        case ITEM.SPEED_UP:
        {
            superspeed_time = SPEED_UP_DURATION;
            player_refresh_physics();
            audio_play_jingle(bgmSpeedUp);
            break;
        }
        case ITEM.SLOW_DOWN:
        {
            if (invin_time == 0)
            {
                superspeed_time = -DEBUFF_DURAION;
                player_refresh_physics();
                audio_stop_sound(bgmSpeedUp);
                audio_play_single(sfxItemDebuff);
            }
            break;
        }
        case ITEM.CONFUSION:
        {
            if (invin_time == 0)
            {
                confusion_time = DEBUFF_DURAION;
                audio_play_single(sfxItemDebuff);
            }
            break;
        }
        case ITEM.EGGMAN:
        {
            player_damage(noone);
            break;
        }
    }
};

/// @method player_damage(inst)
/// @description Sets the player to be either hurt or dead.
/// Setting inst to the player's id will force a death, while setting it to noone will just hurt the player.
/// @param {Id.Instance} inst Instance to check.
player_damage = function(inst)
{
    // Abort if the player is already dead or hurt
    if (state == player_is_dead or ((state == player_is_hurt or invin_time > 0 or invuln_time > 0) and inst != id)) exit;
    
    if (inst == id or (player_index == 0 and shield == SHIELD.NONE and global.ring_count == 0))
    {
        y_speed = -7;
        audio_play_single(inst != noone and inst.object_index == objSpikes ? sfxHurtSpikes : sfxHurt);
        return player_perform(player_is_dead);
    }
    else
    {
    	var hurt_speed = -2;
        var ring_loss = false;
        animation_init(PLAYER_ANIMATION.HURT);
        if (inst == noone or abs(x_speed) <= 2.5)
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
        if (player_index == 0)
        {
            if (shield != SHIELD.NONE)
            {
                shield = SHIELD.NONE;
            }
            else
            {
                ring_loss = true;
                player_lose_rings();
            }
        }
        if (not ring_loss) audio_play_single(inst != noone and inst.object_index == objSpikes ? sfxHurtSpikes : sfxHurt);
        return player_perform(player_is_hurt);
    }
};

/// @method player_animate()
/// @description Sets the player's current animation.
player_animate = function() {};

/// @method player_draw_before()
/// @description Draws player effects behind the character sprite.
player_draw_before = function() {};

/// @method player_draw_after()
/// @description Draws player effects in front of the character sprite.
player_draw_after = function() {};