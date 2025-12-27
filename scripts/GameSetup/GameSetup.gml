// Constants
#macro GAME_FLAG_KEEP_CHARACTERS 1
#macro GAME_FLAG_KEEP_SCORE 2
#macro GAME_FLAG_HIDE_PAUSE 4 
#macro GAME_FLAG_HIDE_HUD 8

#macro PAUSE_FLAG_TEXT 1
#macro PAUSE_FLAG_TRANSITION 2
#macro PAUSE_FLAG_MENU 4

#macro CAMERA_WIDTH 426
#macro CAMERA_HEIGHT 240
#macro CAMERA_PADDING 64

#macro MUTE_FLAG_MUSIC 1
#macro MUTE_FLAG_JINGLE 2
#macro MUTE_FLAG_DROWN 4

#macro PRIORITY_SOUND 0 
#macro PRIORITY_MUSIC 1
#macro PRIORITY_JINGLE 2
#macro PRIORITY_DROWN 3 

#macro DEPTH_OFFSET_AFTERIMAGE 25
#macro DEPTH_OFFSET_PLAYER 50
#macro DEPTH_OFFSET_PARTICLE 75

#macro COLL_FLAG_TOP 0x10000
#macro COLL_FLAG_BOTTOM 0x20000
#macro COLL_FLAG_LEFT 0x40000
#macro COLL_FLAG_RIGHT 0x80000

#macro LIVES_ENABLED db_read(global.config_database, true, "lives") and ctrlGame.game_mode != GAME_MODE.TIME_ATTACK 

#macro PLAYER_HEIGHT 14

enum GAME_MODE
{
    SINGLE,
    MARATHON,
    TIME_ATTACK
}

enum CHARACTER
{
	NONE = -1,
	SONIC,
	MILES,
	KNUCKLES,
	AMY,
	CREAM
}

enum SHIELD
{
	NONE,
	BASIC,
	MAGNETIC,
	BUBBLE,
	FIRE,
	LIGHTNING
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

enum CPU_STATE
{
	FOLLOW,
	CROUCH,
	SPIN_DASH
}

// Volumes
global.volume_sound = 1;
global.volume_music = 1;

// Music
audio_loop_points(bgmExtraBattle1, 14.2224, 128.0002);

// Player values
global.characters = [];
global.score_count = 0;
global.ring_count = 0;
global.life_count = 3;

// Fonts
global.font_hud_cluster = font_add_sprite_ext(sprFontHUDCluster, "0123456789", false, 1);

global.font_hud_adventure = font_add_sprite_ext(sprFontHUDAdventure, "0123456789:.", false, -1);

global.font_hud_adventure_2 = font_add_sprite_ext(sprFontHUDAdventure2, "0123456789:.", false, -1);
global.font_hud_adventure_2_lives = font_add_sprite_ext(sprFontHUDAdventure2Lives, "0123456789", false, 0);

global.font_hud_advance_2 = font_add_sprite(sprFontHUDAdvance2, ord("!"), false, 0);

global.font_hud_advance_3 = font_add_sprite(sprFontHUDAdvance3, ord("!"), false, 0);

global.font_hud_episode_ii = font_add_sprite_ext(sprFontHUDEpisodeII, "0123456789x", false, 1);
global.font_hud_episode_ii_score = font_add_sprite(sprFontHUDEpisodeIIScore, ord("0"), false, 1);
global.font_hud_episode_ii_time = font_add_sprite_ext(sprFontHUDEpisodeIITime, "0123456789'\"", false, 1);

// Misc.
surface_depth_disable(true);
InputPartySetParams(INPUT_VERB.CONFIRM, 1, INPUT_MAX_PLAYERS, false, INPUT_VERB.CANCEL, undefined);
randomize();

// Create global controllers
call_later(1, time_source_units_frames, function()
{
    instance_create_layer(0, 0, "Controllers", ctrlGame);
    instance_create_layer(0, 0, "Controllers", ctrlWindow);
    instance_create_layer(0, 0, "Controllers", ctrlMusic);
});