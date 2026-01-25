/// @description Initialize
image_speed = 0;
index = TRANSITION.FADE;
state = 0;

// Flags
debug = false;
ignore_pause = false;
skip_load = false;

// Target
target = room;
target_scene = global.scn_default;

// Timers
fade_time = 0;
title_card_time = 0;
try_again_time = 0;

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

zone_text = "";
zone_width = -1;
zone_padding = 9;

// Message
message_x = 0;
message_time = 0;
message_duration = 30;

message_text = "Try Again";
message_width = -1;
message_padding = 9;