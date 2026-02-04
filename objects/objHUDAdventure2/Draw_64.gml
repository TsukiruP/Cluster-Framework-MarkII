/// @description Render
var hud_x = 8;
var hud_y = 8;

// Text
draw_set_font(global.font_hud_adventure_2);
draw_set_halign(fa_left);
draw_set_color(c_white);

// Score
var score_cap = 99999999;
draw_text(hud_x, hud_y, $"{global.score_count > score_cap ? score_cap : string_pad(global.score_count, 8)}");

// Time
var time_y = hud_y + 13;
draw_set_color(time_alert and flash ? c_red : c_white);
draw_text(hud_x, time_y, $"{time_over ? "09" : string_pad(minutes, 2)}");
draw_text(hud_x + 16, time_y, ":");
draw_text(hud_x + 24, time_y, time_over ? "59" : string_pad(seconds, 2));
draw_text(hud_x + 40, time_y, ".");
draw_text(hud_x + 48, time_y, time_over ? "99" : string_pad(centiseconds, 2));
draw_set_color(c_white);

// Rings
draw_sprite(sprHUDAdventure2Ring, 0, hud_x - 3, hud_y + 25);
draw_set_color(global.ring_count == 0 and flash ? c_red : c_white);
draw_text(hud_x + 8, hud_y + 30, string_pad(global.ring_count, 3));
draw_set_color(c_white);

// Lives
if (LIVES_ENABLED)
{
    var lives_x = 22;
    var lives_y = CAMERA_HEIGHT - 20;
    var lives_cap = 99;
    var character_index = global.characters[0];
    draw_sprite_ext(sprHUDAdvance3LifeIcon, character_index, lives_x, lives_y, -1, 1, 0, c_white, 1);
    draw_set_font(global.font_hud_adventure_2_lives);
    draw_text(lives_x + 4, lives_y + 6, $"{global.life_count > lives_cap ? lives_cap : string_pad(global.life_count, 2)}");
}

draw_reset();
draw_set_font(-1);

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */