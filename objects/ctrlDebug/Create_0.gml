/// @description Initialize
image_speed = 0;

// Global
global_view = dbg_view("Global", false);
game_seciton = dbg_section("Game");
dbg_watch(ref_create(ctrlGame, "game_time"));
dbg_text_input(ref_create(ctrlGame, "game_speed"), undefined, "r");
dbg_drop_down(ref_create(ctrlGame, "game_mode"), "Single,Marathon,Time Attack");
dbg_watch(ref_create(ctrlGame, "game_flags"));
dbg_watch(ref_create(ctrlGame, "game_paused"));

stage_section = dbg_section("Stage");
dbg_text_input(ref_create(global, "score_count"), undefined, "r");
dbg_text_input(ref_create(global, "ring_count"), undefined, "r");
dbg_text_input(ref_create(global, "life_count"), undefined, "r");
dbg_text_input(ref_create(global, "ring_life_threshold"), undefined, "r");
stage_time_control = undefined;
time_enabled_control = undefined;

// Player
player_views = [];

/// @description Watches the given player.
debug_watch_player = function(_pla)
{
    var character_names = ["Sonic", "Miles", "Knuckles", "Amy", "Cream"];
    var character_view = dbg_view(character_names[_pla.character_index], false);
    array_push(player_views, character_view);
    
    dbg_section("Metadata");
    dbg_watch(ref_create(_pla, "player_index"));
    dbg_watch(ref_create(_pla, "character_index"));
    
    dbg_section("State machine");
    dbg_watch(ref_create(_pla, "state"));
    dbg_watch(ref_create(_pla, "state_previous"));
    
    dbg_section("Movement and Collision");
    dbg_watch(ref_create(_pla, "x_speed"));
    dbg_watch(ref_create(_pla, "y_speed"));
    dbg_slider_int(ref_create(_pla, "gravity_direction"), 0, 360, undefined, 90);
    dbg_watch(ref_create(_pla, "direction"));
    dbg_watch(ref_create(_pla, "local_direction"));
    dbg_watch(ref_create(_pla, "mask_direction"));
    dbg_watch(ref_create(_pla, "control_lock_time"));
    
    var ref_to_animation_data = ref_create(_pla, "animation_data");
    dbg_section("Animation");
    dbg_watch(ref_create(ref_to_animation_data, "index"));
};