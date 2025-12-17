/// @description Render
var time = ctrlStage.stage_time;
var flash = time mod 32 < 16; // mod 16 < 8
var minutes = time div 3600;
var seconds = (time div 60) mod 60;
var centiseconds = floor(time / 0.6) mod 100;

// Text
draw_set_font(global.font_hud_advance_2);
draw_set_halign(fa_left);
draw_set_color(c_white);

// Rings
var pla_speed = global.players[0].x_speed;
image_index += (pla_speed / 8) + 0.25;
image_index = image_index mod 256;
draw_sprite(sprHUDAdvance2, 0, 0, 0);
draw_sprite(sprHUDRingAdvance2, image_index, 7, 8);
draw_set_color(global.rings == 0 and flash ? c_red : c_white);
draw_text(28, 0, string_pad(global.rings, 3));
draw_reset();

// Score
draw_text(28, 14, string_pad(score, 6));

// Time
var center_x = (CAMERA_WIDTH / 2);
draw_text(center_x - 28, 0, $"{minutes}");
draw_text(center_x - 21, 0, ":");
draw_text(center_x - 12, 0, string_pad(seconds, 2));
draw_text(center_x + 3, 0, ":");
draw_text(center_x + 12, 0, string_pad(centiseconds, 2));

// Lives
var pla_character = global.players[0].character_index;
draw_sprite(sprLivesAdvance2, pla_character, 6, CAMERA_HEIGHT - 18);
draw_text(30, CAMERA_HEIGHT - 20, $"{lives}");

draw_reset();

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */