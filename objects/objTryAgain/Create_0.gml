/// @description Initialize
// Inherit the parent event
event_inherited();

try_again_time = 0;

// Curtain
curtain_y = 0;
curtain_time = 0;
curtain_duration = 20;

curtain_scroll = 0;
curtain_speed = 1;

curtain_width = sprite_get_width(sprTitleCardCurtain);
curtain_height = sprite_get_height(sprTitleCardCurtain);

// Message
message_x = 0;
message_time = 0;
message_duration = 30;

message_text = "Try Again";
message_width = -1;
message_padding = 9;