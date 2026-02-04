/// @description Render
var hud_x = 25;
var hud_y = 26;

// Text
draw_set_halign(fa_left);
draw_set_color(c_white);

// Rings
draw_sprite(sprHUDEpisodeII, 0, hud_x, hud_y);
if (global.ring_count > 0 or flash)
{
    draw_set_color(global.ring_count == 0 ? c_red : c_white);
    draw_set_font(global.font_hud_episode_ii);
    draw_text(hud_x - 5, hud_y + 11, string_pad(global.ring_count, 3));
    draw_set_color(c_white);
}

// Score
var score_cap = 999999999;
draw_set_font(global.font_hud_episode_ii_score);
draw_text(hud_x + 37, hud_y + 3, $"{global.score_count > score_cap ? score_cap : string_pad(global.score_count, 9)}");

// Time
var time_x = hud_x + 58;
var time_y = 44;
draw_sprite_ext(sprHUDEpisodeII, 1, hud_x, hud_y, 1, 1, 0, time_alert and flash ? c_red : c_white, 1);
draw_set_font(global.font_hud_episode_ii_time);
draw_set_color(time_alert and flash ? c_red : c_white);
draw_text(time_x, time_y, $"{time_over ? "9" : minutes}");
draw_text(time_x + 8, time_y, "'");
draw_text(time_x + 16, time_y, time_over ? "59" : string_pad(seconds, 2));
draw_text(time_x + 34, time_y, "\"");
draw_text(time_x + 44, time_y, time_over ? "99" : string_pad(centiseconds, 2));
draw_set_color(c_white);

// Lives
if (LIVES_ENABLED)
{
    var lives_x = 36;
    var lives_y = CAMERA_HEIGHT - 45;
    var lives_cap = 999;
    if (array_length(global.characters) > 1)
    {
        for (var i = 0; i < array_length(global.characters); i++)
        {
            var character_index = global.characters[i];
            draw_sprite_ext(sprHUDAdvance3LifeIcon, character_index, lives_x + i * 10, lives_y + i * 4, -1, 1, 0, c_white, 1);
        }
    }
    else 
    {
        var character_index = global.characters[0];
        draw_sprite_ext(sprHUDAdvance3LifeIcon, character_index, lives_x + 10, lives_y + 4, -1, 1, 0, c_white, 1);
    }
    draw_set_font(global.font_hud_episode_ii);
    draw_text(lives_x + 11, lives_y + 6, $"x{global.life_count > lives_cap ? lives_cap : string_pad(global.life_count, 3)}");
}

draw_reset();
draw_set_font(-1);

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */