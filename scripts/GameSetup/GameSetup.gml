// Constants
#macro CAMERA_WIDTH 426
#macro CAMERA_HEIGHT 240
#macro CAMERA_PADDING 64

#macro MUTE_MUSIC 1
#macro MUTE_JINGLE 2
#macro MUTE_DROWN 4

#macro PRIORITY_SOUND 0 
#macro PRIORITY_MUSIC 1
#macro PRIORITY_JINGLE 2
#macro PRIORITY_DROWN 3 

#macro DEPTH_OFFSET_AFTERIMAGE 25
#macro DEPTH_OFFSET_PLAYER 50
#macro DEPTH_OFFSET_PARTICLE 75

#macro COLL_ANY 0xC0000
#macro COLL_TOP 0x10000
#macro COLL_BOTTOM 0x20000
#macro COLL_RIGHT 0x40000
#macro COLL_LEFT 0x80000
#macro COLL_VERTICAL 0x30000

#macro PLAYER_HEIGHT 14

enum CHARACTER
{
    NONE = -1,
    SONIC,
    MILES,
    KNUCKLES,
    AMY,
    CREAM
}

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

// Volumes
volume_sound = 1;
volume_music = 1;

// Music
audio_loop_points(bgmExtraBattle1, 14.2224, 128.0002);

// Player values
players = -1;
score = 0;
lives = 3;
rings = 0;

// Fonts
font_hud = font_add_sprite(sprFontHUD, ord("0"), false, 1);
font_lives = font_add_sprite(sprFontLives, ord("0"), false, 0);

// Misc.
surface_depth_disable(true);
InputPartySetParams(INPUT_VERB.CONFIRM, 1, INPUT_MAX_PLAYERS, false, INPUT_VERB.CANCEL, undefined);
randomize();

// Create global controllers
call_later(1, time_source_units_frames, function()
{
	instance_create_layer(0, 0, "Controllers", ctrlWindow);
	instance_create_layer(0, 0, "Controllers", ctrlMusic);
});

/* AUTHOR NOTE: this must be done one frame later as the first room will not have loaded yet.
 * also, while the manual recommends variables declared in scripts to have a global prefix, this is not done here.
 */