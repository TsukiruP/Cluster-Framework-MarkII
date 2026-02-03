/// @description Render
var time = ctrlStage.stage_time;
var time_over = ctrlStage.time_over;
var time_alert = (ctrlStage.time_limit - time) < time_to_frames(1, 0);
var flash = ctrlGame.game_time mod 32 < 16;
var minutes = time div 3600;
var seconds = time div 60 mod 60;
var centiseconds = floor(time / 0.6) mod 100;

var hud_x = 10;
var hud_y = 13;

// Text
draw_set_font(global.font_hud_adventure);
draw_set_halign(fa_left);
draw_set_color(c_white);

// Time
draw_sprite(sprHUDAdventureTime, 0, hud_x, hud_y);
draw_set_color(time_alert and flash ? c_red : c_white);
draw_text(hud_x + 33, hud_y, time_over ? "09:59:99" : $"{string_pad(minutes, 2)}:{string_pad(seconds, 2)}.{string_pad(centiseconds, 2)}");
draw_set_color(c_white);

// Rings
draw_sprite(sprHUDAdventureRing, 0, hud_x, hud_y + 9);
draw_set_color(global.ring_count == 0 and flash ? c_red : c_white);
draw_text(hud_x + 17, hud_y + 13, string_pad(global.ring_count, 3));

// Lives
if (LIVES_ENABLED)
{
    var lives_x = 11;
    var lives_y = CAMERA_HEIGHT - 26;
    var lives_cap = 99;
    var character_index = global.characters[0];
    draw_sprite(sprHUDAdventureLifeIcon, character_index, lives_x, lives_y);
    draw_set_font(global.font_hud_adventure);
    draw_text(lives_x + 17, lives_y + 7, $"{global.life_count > lives_cap ? lives_cap : string_pad(global.life_count, 2)}");
}

draw_reset();
draw_set_font(-1);

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */