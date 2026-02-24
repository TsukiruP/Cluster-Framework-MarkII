// Constants
#macro GAME_FLAG_KEEP_CHARACTERS 1
#macro GAME_FLAG_KEEP_SCORE 2
#macro GAME_FLAG_HIDE_PAUSE 4 
#macro GAME_FLAG_HIDE_HUD 8

#macro PAUSE_FLAG_MENU 1
#macro PAUSE_FLAG_TEXT 2
#macro PAUSE_FLAG_TRANSITION 4

#macro CAMERA_ID view_camera[0]
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

#macro LIVES_ENABLED db_read(DATABASE_CONFIG, CONFIG_DEFAULT_LIVES, "lives") and ctrlGame.game_mode != GAME_MODE.TIME_ATTACK

#macro TEN_MILLISECONDS 1000

#macro PLAYER_HEIGHT 14
#macro ITEM_WIDTH 18

#macro SONIC_BOOM_COUNT 16
#macro AFTERIMAGE_RECORD_COUNT 16 
#macro AFTERIMAGE_COUNT 3
#macro CPU_RECORD_COUNT 16 

#macro SCORE_CAP 999999999
#macro RING_CAP 999
#macro LIVES_CAP 999 

enum GAME_MODE
{
    SINGLE,
    MARATHON,
    TIME_ATTACK
}

enum TRANSITION
{
    FADE,
    TITLE_CARD,
    TRY_AGAIN,
    GAME_OVER
}

enum FADE_STATE
{
    IN,
    WAIT,
    OUT
}

enum TITLE_CARD_STATE
{
    FADE,
    FADE_WAIT,
    ENTER,
    ENTER_WAIT,
    GOTO,
    RESET,
    EXIT
}

enum TRY_AGAIN_STATE
{
    ENTER,
    WAIT,
    RESET,
    CLOSE,
    GOTO,
    OPEN,
    EXIT
}

enum GAME_OVER_STATE
{
    ENTER,
    WAIT,
    JINGLE,
    FADE,
    GOTO,
    EXIT
}

enum CAMERA_STATE
{
    NULL = -1,
    FOLLOW,
    RETURN,
    KNUCKLES
}

enum ITEM
{
    LIFE,
    RING_BONUS,
    SUPER_RING_BONUS,
    RANDOM_RING_BONUS,
    BASIC,
    MAGNETIC,
    AQUA,
    FLAME,
    THUNDER,
    INVINCIBILITY,
    SPEED_UP,
    SLOW_DOWN,
    CONFUSION,
    EGGMAN
}

// Volumes
global.volume_sound = 1;
global.volume_music = 1;

// Stage
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

global.font_title_card = font_add_sprite(sprFontTitleCard, ord(" "), true, -5);

// Misc.
surface_depth_disable(true);
InputPartySetParams(INPUT_VERB.CONFIRM, 1, INPUT_MAX_PLAYERS, true, INPUT_VERB.CANCEL, undefined);
randomize();

// Start the game!
call_later(1, time_source_units_frames, room_goto_next);

/* AUTHOR NOTE: `room_goto_next` executes at the end of the function/event it was called in,
meaning calling it here would result in the global controllers not being created.
Thus, it is instead called 1 frame later.

Note, however, this means the initialization room will be shown for that 1 frame.
Calling `room_goto_next` in the room's Creation Code does not address this, either. */