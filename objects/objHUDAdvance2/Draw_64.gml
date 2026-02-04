/// @description Render
var time = ctrlStage.stage_time;
var time_over = ctrlStage.time_over;
var time_alert = (ctrlStage.time_limit - time) < time_to_frames(1, 0);
var flash = ctrlGame.game_time mod 32 < 16;
var minutes = time div 3600;
var seconds = time div 60 mod 60;
var centiseconds = floor(time / 0.6) mod 100;

var hud_x = 1;
var hud_y = 3;

// Text
draw_set_font(global.font_hud_advance_2);
draw_set_halign(fa_left);
draw_set_color(c_white);

// Rings
var pla_speed = ctrlStage.stage_players[0].x_speed;
if (not ctrlGame.game_paused) image_index += (pla_speed / 8) + 0.25;
image_index = image_index mod 256;
draw_sprite(sprHUDAdvance2, 0, hud_x, hud_y);
draw_sprite(sprHUDAdvance2Ring, image_index, hud_x + 6, hud_y + 5);
draw_set_color(global.ring_count == 0 and flash ? c_red : c_white);
draw_text(hud_x + 27, 0, string_pad(global.ring_count, 3));
draw_set_color(c_white);

// Score
var score_cap = 999999;
draw_text(hud_x + 27, hud_y + 11, $"{global.score_count > score_cap ? score_cap : string_pad(global.score_count, 6)}");

// Time
var time_x = (CAMERA_WIDTH / 2);
var time_y = 0;
draw_text(time_x - 21, time_y, ":");
draw_text(time_x + 3, time_y, ":");
draw_set_color(time_alert and flash ? c_red : c_white);
draw_text(time_x - 28, time_y, $"{time_over ? "9" : minutes}");
draw_text(time_x - 12, time_y, time_over ? "59" : string_pad(seconds, 2));
draw_text(time_x + 12, time_y, time_over ? "99" : string_pad(centiseconds, 2));
draw_set_color(c_white);

// Lives
if (LIVES_ENABLED)
{
    var lives_x = 6;
    var lives_y = CAMERA_HEIGHT - 18;
    var lives_cap = 9;
    var character_index = global.characters[0];
    draw_sprite(sprHUDAdvance2LifeIcon, character_index, lives_x, lives_y);
    draw_set_font(global.font_hud_advance_2);
    draw_text(lives_x + 24, lives_y - 2, $"{global.life_count > lives_cap ? lives_cap : global.life_count}");
}

draw_reset();
draw_set_font(-1);

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */