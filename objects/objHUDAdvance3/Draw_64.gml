/// @description Render
var time = ctrlStage.stage_time;
var time_over = ctrlStage.time_over;
var time_alert = (ctrlStage.time_limit - time) < time_to_frames(1, 0);
var flash = ctrlGame.game_time mod 32 < 16;
var minutes = time div 3600;
var seconds = time div 60 mod 60;
var centiseconds = floor(time / 0.6) mod 100;

var hud_x = 8;
var hud_y = 0;

// Text
draw_set_font(global.font_hud_advance_3);
draw_set_halign(fa_left);
draw_set_color(c_white);

// Type
var type_index = 2;
if (array_contains(global.characters, CHARACTER.SONIC)) type_index = 0;
else if (array_contains(global.characters, CHARACTER.MILES) or array_contains(global.characters, CHARACTER.CREAM)) type_index = 1;
draw_sprite(sprHUDAdvance3Type, type_index, hud_x, hud_y);

// Rings
draw_set_color(global.ring_count == 0 and flash ? c_red : c_white);
draw_text(hud_x + 28, hud_y + 2, string_pad(global.ring_count, 3));
draw_set_color(c_white);

// Time
var time_x = (CAMERA_WIDTH / 2);
var time_y = 2;
draw_sprite(sprHUDAdvance3Time, 0, time_x - 32, 7);
draw_text(time_x - 7, time_y - 1, "'");
draw_text(time_x + 13, time_y - 1, "\"");
draw_set_color(time_alert and flash ? c_red : c_white);
draw_text(time_x - 14, time_y, $"{time_over ? "9" : minutes}");
draw_text(time_x - 2, time_y, time_over ? "59" : string_pad(seconds, 2));
draw_text(time_x + 20, time_y, time_over ? "99" : string_pad(centiseconds, 2));
draw_set_color(c_white);

// Lives
if (LIVES_ENABLED)
{
    var lives_x = 5;
    var lives_y = CAMERA_HEIGHT - 20;
    var lives_cap = 9;
    for (var i = array_length(global.characters) - 1; i >= 0; i--)
    {
        var character_index = global.characters[i];
        draw_sprite(sprHUDAdvance3LifeIcon, character_index, lives_x + i * 10, lives_y);
    }
    if (array_length(global.characters) <= 1) draw_text(lives_x + 17, lives_y, "x");
    draw_set_font(global.font_hud_advance_3);
    draw_text(lives_x + 27, lives_y, $"{global.life_count > lives_cap ? lives_cap : global.life_count}");
}

draw_reset();
draw_set_font(-1);

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */