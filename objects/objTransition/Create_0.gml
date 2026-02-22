/// @description Initialize
image_speed = 0;
index = TRANSITION.FADE;
transition_time = 0;
state = 0;

// Flags
debug = false;
ignore_pause = false;
skip_load = false;

// Target
target = room;
target_scene = global.scn_default;

// Fade
fade_alpha = 0;
fade_speed = 0.02;

// Curtain
curtain_y = 0;
curtain_time = 0;
curtain_duration = 20;

curtain_scroll = 0;
curtain_speed = 1;

curtain_width = sprite_get_width(sprTitleCardCurtain);
curtain_height = sprite_get_height(sprTitleCardCurtain);

// Banner
banner_x = 0;
banner_time = 0;
banner_duration = 20;

banner_scroll = 0;
banner_speed = 1;

banner_width = sprite_get_width(sprTitleCardBanner);
banner_height = sprite_get_height(sprTitleCardBanner);

// Zone
zone_x = 0;
zone_time = 0;
zone_duration = 30;

// Try Again
try_again_x = 0;
try_again_time = 0;
try_again_duration = 30;

// Game Over
game_over_x = 0;
game_over_time = 0;
game_over_duration = 30;

// Text
zone_text = "";
try_again_text = "Try Again";
game_over_text = "Game Over";

text_width = -1;
text_padding = 9;