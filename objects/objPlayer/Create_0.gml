/// @description Initialize
image_speed = 0;

character_index = CHARACTER.NONE;
player_index = -1;

// State machine
state = player_is_ready;
state_changed = false;

spin_dash_charge = 0;
spin_dash_dust = new stamp();

aerial_flags = 0;

jump_cap = true;
jump_alternate = 0;

trick_index = TRICK.FRONT;
trick_speed = array_create(TRICK.BACK + 1);
for (var i = 0; i < array_length(trick_speed); i++)
{
    trick_speed[i] = array_create(2);
}

// Status
shield = new stamp();
shield.index = SHIELD.NONE;
miasma = new stamp();

/// @method player_refresh_status()
/// @description Resets the player's status.
player_refresh_status = function()
{
    shield.index = SHIELD.NONE;
    aerial_flags &= ~AERIAL_FLAG_SHIELD_ACTION;
    recovery_time = 0;
    invincibility_time = 0;
    superspeed_time = 0;
    confusion_time = 0;
};

// Timers
rotation_lock_time = 0;
control_lock_time = 0;
swap_time = 0;
state_time = 0;

recovery_time = 0;
invincibility_time = 0;
superspeed_time = 0;
confusion_time = 0;

cpu_state_time = 0;
cpu_respawn_time = CPU_RESPAWN_DURATION;
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

/* AUTHOR NOTE: "down" is treated as 0 degrees instead of 270. */

cliff_sign = 0;

collision_layer = 0;

// Copy the stage's tilemaps
tilemaps = variable_clone(ctrlStage.tilemaps, 0);
tilemap_count = array_length(tilemaps);

// Validate semisolid tilemap; if it exists, the tilemap count is even
semisolid_tilemap = -1;
if (tilemap_count & 1 == 0)
{
    semisolid_tilemap = array_last(tilemaps);
    tilemap_count--;
}

// Delist the "TilesLayer1" layer tilemap, if it exists
if (tilemap_count == 3)
{
    array_delete(tilemaps, 2, 1);
    tilemap_count--;
}

ground_id = noone;

// Input
input_enabled = false;
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

/// @method player_refresh_inputs()
/// @description Resets the player's inputs.
player_refresh_inputs = function()
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

/// @method player_refresh_records()
/// @description Resets the player's input records.
player_refresh_records = function()
{
    array_foreach(cpu_axis_x, function(element, index) { element = 0; });
    array_foreach(cpu_axis_y, function(element, index) { element = 0; });
    array_foreach(cpu_input_jump, function(element, index) { element = false; });
    array_foreach(cpu_input_jump_pressed, function(element, index) { element = false; });
};

// Animation
animation_data = new animation_core();

// Speed Break
speed_break =
{
    x : 0,
    y : 0,
    positions : array_create(SONIC_BOOM_COUNT),
    accelerations : array_create(SONIC_BOOM_COUNT),
    unkE2 : 128,
    unkE4 : 0,
    time : 0,
    sprite_index : -1,
    image_index : 0,
    image_angle : 0,
    animation_data : new animation_core(),
    visible : false
};

with (speed_break)
{
    for (var i = 0; i < SONIC_BOOM_COUNT; i++)
    {
        positions[i] = array_create(2);
        accelerations[i] = array_create(2);
    }
}

// Afterimage
/// @method afterimage_record()
/// @description Creates a new afterimage record.
afterimage_record = function() constructor
{
    x = 0;
    y = 0;
    image_xscale = 1;
    image_yscale = 1;
    image_angle = 0;
    ani = undefined;
    ani_speed = 1;
};

/// @method afterimage()
/// @description Creates a new afterimage.
afterimage = function() constructor 
{
    time = 0;
    sprite_index = -1;
    image_index = 0;
    image_alpha = 1;
    record = undefined;
    animation_data = new animation_core();
}

afterimage_index = 0;
afterimage_visible = false;
afterimage_history = array_create(AFTERIMAGE_RECORD_COUNT);
for (var i = 0; i < AFTERIMAGE_RECORD_COUNT; i++)
{
    afterimage_history[i] = new afterimage_record();
}

boost_afterimages = array_create(AFTERIMAGE_COUNT);
for (var i = 0; i < AFTERIMAGE_COUNT; i++)
{
    boost_afterimages[i] = new afterimage();
}

// Camera
camera = noone;

// CPU
cpu_state = CPU_STATE.FOLLOW;
cpu_axis_x = array_create(CPU_RECORD_COUNT);
cpu_axis_y = array_create(CPU_RECORD_COUNT);
cpu_input_jump = array_create(CPU_RECORD_COUNT);
cpu_input_jump_pressed = array_create(CPU_RECORD_COUNT);

/// @method player_refresh_cpu()
/// @description Resets the CPU.
player_refresh_cpu = function()
{
    var leader = ctrlStage.stage_players[0];
    x = leader.x div 1;
    y = leader.y div 1;
    xprevious = x;
    yprevious = y;
    gravity_direction = leader.gravity_direction;
    image_xscale = leader.image_xscale;
    image_angle = gravity_direction;
    x_speed = leader.x_speed;
    y_speed = leader.y_speed;
    collision_layer = leader.collision_layer;
    tilemaps[1] = ctrlStage.tilemaps[collision_layer + 1];
    cpu_state = CPU_STATE.FOLLOW;
    player_ground(undefined);
    animation_play(PLAYER_ANIMATION.FALL);
    player_perform(player_is_falling, false);
    player_refresh_physics();
};


/// @method player_respawn_cpu()
/// @description Respawns the CPU.
player_respawn_cpu = function()
{
    var can_respawn = (ctrlStage.stage_players[0].state != player_is_dead);
    if (can_respawn)
    {
        player_refresh_cpu();
        recovery_time = RECOVERY_DURATION;
        cpu_respawn_time = 0;
    }
};

// Misc.
/// @method player_perform(action, [enter])
/// @description Sets the given function as the player's current state.
/// @param {Function} action State function to set.
/// @param {Bool} enter Whether to perform the enter phase (optional, defaults to true).
player_perform = function(action, enter = true)
{
    var reset = (argument_count > 1);
    if (state != action or reset)
    { 
        state(PHASE.EXIT);
        state = action;
        state_changed = true;
        if (enter) state(PHASE.ENTER);
    }
};

/// @method player_try_jump()
/// @description Checks if the player performs a jump.
/// @returns {Bool}
player_try_jump = function()
{
    if (input_button.jump.pressed)
    {
        player_perform(player_is_jumping);
        animation_play(object_index == objAmy ? PLAYER_ANIMATION.SPRING : PLAYER_ANIMATION.JUMP);
        audio_play_single(sfxJump);
        return true;
    }
    return false;
};

/// @method player_try_trick([time])
/// @desctiption Checks if the player performs a Trick Action.
/// @param [time] Time to check (optional, defaults to state_time).
/// @returns {Bool}
player_try_trick = function(time = 0)
{
    if (time == 0 and input_button.tag.pressed)
    {
        trick_index = TRICK.BACK;
        if (input_axis_y == -1) trick_index = TRICK.UP;
        else if (input_axis_y == 1) trick_index = TRICK.DOWN;
        else if (input_axis_x == image_xscale) trick_index = TRICK.FRONT;
        player_gain_score(100);
        player_perform(player_is_trick_preparing);
        if (not ((object_index == objSonic or object_index == objKnuckles or object_index == objAmy) and
            trick_index == TRICK.DOWN))
        {
            audio_play_single(sfxTrickAction);
        }
        return true;
    }
    return false;
};

/// @method player_try_shield_action()
/// @description Checks if the player performs a Shield Action.
/// @returns {Bool}
player_try_shield_action = function()
{
    aerial_flags |= AERIAL_FLAG_SHIELD_ACTION;
    switch (shield.index)
    {
        case SHIELD.AQUA:
        {
            player_perform(player_is_aqua_bounding);
            jump_alternate = input_button.aux.pressed;
            with (shield)
            {
                if (animation_data.index == SHIELD.AQUA) animation_data.variant = 1;
            }
            return true;
        }
        case SHIELD.FLAME:
        {
            x_speed = 8 * image_xscale;
            y_speed = 0;
            camera_set_x_lag_time(16);
            player_perform(player_is_jumping, false);
            animation_play(PLAYER_ANIMATION.JUMP, 1);
            audio_play_single(sfxFlameDash);
            with (shield)
            {
                if (animation_data.index == SHIELD.FLAME)
                {
                    image_xscale = other.image_xscale;
                    animation_data.variant = 1;
                }
            }
            return true;
        }
        case SHIELD.THUNDER:
        {
            y_speed = -5.5;
            player_perform(player_is_jumping, false);
            animation_play(PLAYER_ANIMATION.JUMP, 1);
            audio_play_single(sfxThunderJump);
            for (var i = 45; i <= 315; i += 90)
            {
                var sine = dcos(i);
                var cosine = dsin(i);
                particle_create(x, y, global.ani_shield_thunder_spark_v0, gravity_direction, 20, sine * 2, -cosine * 2, 0, 0);
            }
            return true;
        }
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
    
    var new_rotation = round(direction / 90) mod 4 * 90;
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
    x_radius = xrad;
    x_wall_radius = x_radius + 2;
    y_radius = yrad;
    
    if (on_ground)
    {
        var sine = dsin(mask_direction);
        var cosine = dcos(mask_direction);
        x += sine * (old_y_radius - y_radius);
        y += cosine * (old_y_radius - y_radius);
    }
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
/// @description Plays the given animation based on running conditions.
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
/// @description Plays the given animation based on falling conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_fall = function(ani)
{
    if (animation_data.variant == 0 and animation_is_finished()) animation_data.variant = 1;
    player_set_animation(ani, rotate_towards(mask_direction, image_angle));
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
            if (y_speed > 0 and player_find_floor(y_radius + 32) != undefined) animation_data.variant = 2;
            break;
        }
    }
    player_set_animation(ani);
};

/// @method player_animate_spring(ani)
/// @description Plays the given animation based on spring conditions.
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

/// @method player_gain_score(num)
/// @description Increases the player's score count by the given amount.
/// @param {Real} num Amount of points to give.
player_gain_score = function(num)
{
    var previous_count = global.score_count div 50000;
    global.score_count = min(global.score_count + num, SCORE_CAP);
    
    // Gain lives
    var count = global.score_count div 50000;
    if (count != previous_count) player_gain_lives(count - previous_count);
};

/// @method player_gain_rings(num)
/// @description Increases the player's ring count by the given amount.
/// @param {Real} num Amount of rings to give.
player_gain_rings = function(num)
{
    global.ring_count = min(global.ring_count + num, RING_CAP);
    
    // Gain lives
    static ring_life_threshold = 99;
    if (global.ring_count > ring_life_threshold)
    {
        var change = global.ring_count div 100;
        player_gain_lives(change - ring_life_threshold div 100);
        ring_life_threshold = change * 100 + 99;
    }
};

/// @method player_drop_rings()
/// @description Spawns up to 32 dropped rings in circles of 16 at the player's position, and resets their ring count.
player_drop_rings = function()
{
    var spd = 4;
    var dir = 101.25;
    
    for (var n = min(global.ring_count, 32); n > 0; --n)
    {
        with (instance_create_layer(x, y, ctrlStage.stage_depth, objRing))
        {
            gravity_direction = other.gravity_direction;
            image_angle = gravity_direction;
            
            lost = true;
            x_speed = lengthdir_x(spd, dir);
            y_speed = lengthdir_y(spd, dir);
            
            if (n & 1 != 0)
            {
                x_speed *= -1;
                dir += 22.5;
            }
        }
        
        if (n == 16)
        {
            spd = 2;
            dir = 101.25;
        }
    }
    
    global.ring_count = 0;
    audio_play_single(sfxDropRings);
};

/// @method player_gain_lives(num)
/// @description Increases the player's life count by the given amount.
/// @param {Real} num Amount of lives to give.
player_gain_lives = function(num)
{
    if (LIVES_ENABLED)
    {
        global.life_count = min(global.life_count + num, LIVES_CAP);
        audio_play_life();
    }
};

/// @method player_damage(inst)
/// @description Evaluates the player's condition after taking a hit.
/// Setting inst to the player's id will force a death, while setting it to noone will just hurt the player.
/// @param {Id.Instance} inst Instance to check.
player_damage = function(inst)
{
    // Abort if the player is already dead or hurt
    if (state == player_is_dead or ((state == player_is_hurt or recovery_time > 0 or invincibility_time > 0) and inst != id)) exit;
    
    if (inst == id or (player_index == 0 and shield.index == SHIELD.NONE and global.ring_count == 0))
    {
        y_speed = -7;
        audio_play_single(inst != noone and inst.object_index == objSpikes ? sfxHurtSpikes : sfxHurt);
        return player_perform(player_is_dead);
    }
    else
    {
        var hurt_speed = -2;
        var ring_loss = false;
        animation_play(PLAYER_ANIMATION.HURT);
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
            if (shield.index != SHIELD.NONE)
            {
                shield.index = SHIELD.NONE;
            }
            else
            {
                ring_loss = true;
                player_drop_rings();
            }
        }
        if (not ring_loss) audio_play_single(inst != noone and inst.object_index == objSpikes ? sfxHurtSpikes : sfxHurt);
        return player_perform(player_is_hurt);
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
            shield.index = SHIELD.BASIC;
            audio_play_single(sfxItemBasic);
            break;
        }
        case ITEM.MAGNETIC:
        {
            shield.index = SHIELD.MAGNETIC;
            audio_play_single(sfxItemBasic);
            break;
        }
        case ITEM.AQUA:
        {
            shield.index = SHIELD.AQUA;
            audio_play_single(sfxItemAqua);
            break;
        }
        case ITEM.FLAME:
        {
            shield.index = SHIELD.FLAME;
            audio_play_single(sfxItemFlame);
            break;
        }
        case ITEM.THUNDER:
        {
            shield.index = SHIELD.THUNDER;
            audio_play_single(sfxItemThunder);
            break;
        }
        case ITEM.INVINCIBILITY:
        {
            invincibility_time = INVINCIBILITY_DURATION;
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
            if (invincibility_time == 0)
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
            if (invincibility_time == 0)
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
    
    with (objHUD)
    {
        if (item_feed_config)
        {
            array_push(item_feed, new popup(item));
            item_feed_time = item_feed_duration;
        }
    }
};

/// @method player_speed_break()
/// @description Creates a Speed Break effect.
player_speed_break = function()
{
    with (speed_break)
    {
        var x_scale = other.image_xscale;
        var rot = other.direction;
        time = 0;
        visible = true;
        animation_set(global.ani_speed_break);
        for (var i = 0; i < SONIC_BOOM_COUNT; i++)
        {
            var old_rot, accel;
            positions[i][1] = irandom(4) + 16;
            if (x_scale == -1)
            {
                old_rot = rot + 270;
                positions[i][0] = dcos(rot + 180) * positions[i][1];
                positions[i][1] = -dsin(rot + 180) * positions[i][1];
            }
            else
            {
                old_rot = rot + 90;
                positions[i][0] = dcos(rot) * positions[i][1];
                positions[i][1] = -dsin(rot) * positions[i][1];
            }
            
            accel = irandom(4) + 2;
            accelerations[i][0] = dcos(old_rot) * accel;
            accelerations[i][1] = -dsin(old_rot) * accel;
        }
    }
};

/// @method player_try_skill()
/// @description Checks if the player performs a character skill.
/// @returns {Bool}
player_try_skill = function() { return false; };

/// @method player_refresh_aerials()
/// @description Resets aerial character skills when grounded.
player_refresh_aerials = function() {};

/// @method player_animate()
/// @description Sets the player's current animation.
player_animate = function() {};

/// @method player_draw_before()
/// @description Draws player effects behind the character sprite.
player_draw_before = function() {};

/// @method player_draw_after()
/// @description Draws player effects in front of the character sprite.
player_draw_after = function() {};
