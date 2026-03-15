/// @description Initialize
image_speed = 0;
player_index = -1;
character_index = CHARACTER.NONE;

// State machine
state = player_is_ready;
state_previous = state;
state_changed = false;

cliff_sign = 0;

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

flight_ride = noone;
glide_ride = noone;

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

// Movement and collision
x_speed = 0;
y_speed = 0;

x_radius = 8;
x_wall_radius = 10;

y_radius = 15;
y_tile_reach = 16;

hitboxes[0] = new hitbox(c_maroon);
hitboxes[1] = new hitbox(c_green);

landed = false;
on_ground = true;

solid_id = noone;
ground_id = noone;

direction = 0;
gravity_direction = 0;
local_direction = 0;
mask_direction = 0;

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

// Boost Mode
boost_mode = false;
boost_index = 0;
boost_speed = 0;
boost_thresholds = [8.0, 7.96875, 6.5625, 5.625, 4.21875];

// Status
shield = new stamp();
miasma = new stamp();

// Input
input_enabled = false;
input_axis_x = 0;
input_axis_y = 0;

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

/// @description Creates a new animation record.
animation_record = function() constructor
{
    x = 0;
    y = 0;
    image_xscale = 1;
    image_yscale = 1;
    image_angle = 0;
    ani = undefined;
    ani_speed = 1;
};

animation_history_index = 0;
animation_history = array_create(ANIMATION_RECORD_COUNT);
for (var i = 0; i < ANIMATION_RECORD_COUNT; i++)
{
    animation_history[i] = new animation_record();
}

// Afterimage

/// @description Creates a new afterimage.
afterimage = function() constructor 
{
    time = 0;
    sprite_index = -1;
    image_index = 0;
    image_xscale = 1;
    image_yscale = 1;
    image_angle = 0;
    image_blend = c_white;
    image_alpha = 1;
    animation_data = new animation_core();
};

afterimage_visible = false;
afterimage_trail = array_create(AFTERIMAGE_COUNT);
for (var i = 0; i < AFTERIMAGE_COUNT; i++)
{
    afterimage_trail[i] = new afterimage();
}

// Speed Break
speed_break =
{
    x : 0,
    y : 0,
    visible : false,
    positions : array_create(SPEED_BREAK_COUNT),
    accelerations : array_create(SPEED_BREAK_COUNT),
    unkE2 : 128,
    unkE4 : 0,
    time : 0,
    sprite_index : -1,
    image_index : 0,
    image_angle : 0,
    animation_data : new animation_core()
};

with (speed_break)
{
    for (var i = 0; i < SPEED_BREAK_COUNT; i++)
    {
        positions[i] = array_create(2);
        accelerations[i] = array_create(2);
    }
}

// CPU
cpu_state = CPU_STATE.FOLLOW;
cpu_axis_x = array_create(CPU_RECORD_COUNT);
cpu_axis_y = array_create(CPU_RECORD_COUNT);
cpu_input_jump = array_create(CPU_RECORD_COUNT);
cpu_input_jump_pressed = array_create(CPU_RECORD_COUNT);

// Methods
var n = 0;
repeat (16) event_user(n++);

// Misc.
player_refresh_physics();
player_refresh_status();

/// @description Increases the player's score count by the given amount.
/// @param {Real} num Amount of points to give.
player_gain_score = function(_num)
{
    var previous_count = global.score_count div 50000;
    global.score_count = min(global.score_count + _num, SCORE_CAP);
    
    // Gain lives
    var count = global.score_count div 50000;
    if (count != previous_count) player_gain_lives(count - previous_count);
};

/// @description Increases the player's ring count by the given amount.
/// @param {Real} num Amount of rings to give.
player_gain_rings = function(_num)
{
    global.ring_count = min(global.ring_count + _num, RING_CAP);
    
    // Gain lives
    if (global.ring_count > global.ring_life_threshold)
    {
        var change = global.ring_count div 100;
        player_gain_lives(change - global.ring_life_threshold div 100);
        global.ring_life_threshold = change * 100 + RING_LIFE_BASE_THRESHOLD;
    }
};

/// @description Spawns up to 32 dropped rings in circles of 16 at the player's position, and resets their ring count.
player_drop_rings = function()
{
    var spd = 3;
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

/// @description Increases the player's life count by the given amount.
/// @param {Real} num Amount of lives to give.
player_gain_lives = function(_num)
{
    if (LIVES_ENABLED)
    {
        global.life_count = min(global.life_count + _num, LIVES_CAP);
        audio_play_life();
    }
};

/// @description Gives the player the given item.
/// @param {Enum.ITEM} item Item to obtain.
player_obtain_item = function(_item)
{
    switch (_item)
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
            array_push(item_feed, new popup(_item));
            item_feed_time = item_feed_duration;
        }
    }
};

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
        for (var i = 0; i < SPEED_BREAK_COUNT; i++)
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

/// @description Draws player effects behind the character sprite.
player_draw_before = function() {};

/// @description Draws player effects in front of the character sprite.
player_draw_after = function() {};
