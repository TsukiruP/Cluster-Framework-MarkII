/// @description Render
var hud = db_read(global.config_database, HUD.CLUSTER, "hud");
var time = ctrlStage.stage_time;
var time_flash = (((ctrlStage.time_limit - time) / 60) < 60);
var time_over = (time == ctrlStage.time_limit);
var flash = ctrlGame.game_time mod 32 < 16;
var minutes = time div 3600;
var seconds = (time div 60) mod 60;
var centiseconds = floor(time / 0.6) mod 100;

switch (hud)
{
    case HUD.ADVENTURE:
    {
        // Text
        draw_set_font(global.font_hud_adventure);
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        
        // Time
        draw_sprite(sprHUDAdventureTime, 0, 10, 13);
        draw_set_color(time_flash and flash ? c_red : c_white);
        draw_text(43, 13, time_over ? "09:59:99" : $"{string_pad(minutes, 2)}:{string_pad(seconds, 2)}.{string_pad(centiseconds, 2)}");
        draw_set_color(c_white);
        
        // Rings
        draw_sprite(sprHUDAdventureRing, 0, 10, 22);
        draw_set_color(global.ring_count == 0 and flash ? c_red : c_white);
        draw_text(27, 26, string_pad(global.ring_count, 3));
        draw_set_color(c_white);
        break;
    }
    case HUD.ADVENTURE_2:
    {
        // Text
        draw_set_font(global.font_hud_adventure_2);
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        
        // Score
        var score_max = 99999999;
        draw_text(8, 8, $"{global.score_count > score_max ? score_max : string_pad(global.score_count, 6)}");
        
        // Time
        draw_set_color(time_flash and flash ? c_red : c_white);
        draw_text(8, 21, $"{time_over ? "09" : string_pad(minutes, 2)}");
        draw_text(24, 21, ":");
        draw_text(32, 21, time_over ? "59" : string_pad(seconds, 2));
        draw_text(48, 21, ".");
        draw_text(56, 21, time_over ? "99" : string_pad(centiseconds, 2));
        draw_set_color(c_white);
        
        // Rings
        draw_sprite(sprHUDAdventure2Ring, 0, 5, 33);
        draw_set_color(global.ring_count == 0 and flash ? c_red : c_white);
        draw_text(16, 38, string_pad(global.ring_count, 3));
        draw_set_color(c_white);
        break;
    }
    case HUD.ADVANCE_2:
    {
        // Text
        draw_set_font(global.font_hud_advance_2);
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        
        // Rings
        var pla_speed = ctrlStage.stage_players[0].x_speed;
        if (not ctrlGame.game_paused) image_index += (pla_speed / 8) + 0.25;
        image_index = image_index mod 256;
        draw_sprite(sprHUDAdvance2, 0, 0, 0);
        draw_sprite(sprHUDAdvance2Ring, image_index, 7, 8);
        draw_set_color(global.ring_count == 0 and flash ? c_red : c_white);
        draw_text(28, 0, string_pad(global.ring_count, 3));
        draw_set_color(c_white);
        
        // Score
        var score_max = 999999;
        draw_text(28, 14, $"{global.score_count > score_max ? score_max : string_pad(global.score_count, 6)}");
        
        // Time
        var center_x = (CAMERA_WIDTH / 2);
        draw_text(center_x - 21, 0, ":");
        draw_text(center_x + 3, 0, ":");
        draw_set_color(time_flash and flash ? c_red : c_white);
        draw_text(center_x - 28, 0, $"{time_over ? "9" : minutes}");
        draw_text(center_x - 12, 0, time_over ? "59" : string_pad(seconds, 2));
        draw_text(center_x + 12, 0, time_over ? "99" : string_pad(centiseconds, 2));
        draw_set_color(c_white);
        break;
    }
    case HUD.ADVANCE_3:
    {
        // Text
        draw_set_font(global.font_hud_advance_3);
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        
        // Type
        var type = 2;
        if (array_contains(global.characters, CHARACTER.SONIC)) type = 0;
        else if (array_contains(global.characters, CHARACTER.MILES) or array_contains(global.characters, CHARACTER.CREAM)) type = 1;
        draw_sprite(sprHUDAdvance3Type, type, 8, 0);
        
        // Rings
        draw_set_color(global.ring_count == 0 and flash ? c_red : c_white);
        draw_text(36, 2, string_pad(global.ring_count, 3));
        draw_set_color(c_white);
        
        // Time
        var center_x = (CAMERA_WIDTH / 2);
        draw_sprite(sprHUDAdvance3Time, 0, center_x - 32, 7);
        draw_text(center_x - 7, 1, "'");
        draw_text(center_x + 13, 1, "\"");
        draw_set_color(time_flash and flash ? c_red : c_white);
        draw_text(center_x - 14, 2, $"{time_over ? "9" : minutes}");
        draw_text(center_x - 2, 2, time_over ? "59" : string_pad(seconds, 2));
        draw_text(center_x + 20, 2, time_over ? "99" : string_pad(centiseconds, 2));
        draw_set_color(c_white);
        break;
    }
    case HUD.EPISODE_II:
    {
        // Text
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        
        // Score
        var score_max = 999999999;
        draw_sprite(sprHUDEpisodeII, 0, 25, 26);
        draw_set_font(global.font_hud_episode_ii_score);
        draw_text(62, 29, $"{global.score_count > score_max ? score_max : string_pad(global.score_count, 9)}");
        
        // Time
        draw_sprite_ext(sprHUDEpisodeII, 1, 25, 26, 1, 1, 0, time_flash and flash ? c_red : c_white, 1);
        draw_set_font(global.font_hud_episode_ii_time);
        draw_set_color(time_flash and flash ? c_red : c_white);
        draw_text(83, 44, $"{time_over ? "9" : minutes}");
        draw_text(91, 44, "'");
        draw_text(99, 44, time_over ? "59" : string_pad(seconds, 2));
        draw_text(117, 44, "\"");
        draw_text(127, 44, time_over ? "99" : string_pad(centiseconds, 2));
        draw_set_color(c_white);
        break;
    }
}

// Lives
if (ctrlGame.game_mode != GAME_MODE.TIME_ATTACK)
{
    switch (hud)
    {
        case HUD.ADVENTURE:
        {
            var pla_character = global.characters[0];
            draw_set_font(global.font_hud_adventure);
            draw_sprite(sprHUDAdventureLifeIcon, pla_character, 11, CAMERA_HEIGHT - 26);
            draw_text(28, CAMERA_HEIGHT - 19, $"{global.life_count > 99 ? "99" : string_pad(global.life_count, 2)}");
            break;
        }
        case HUD.ADVENTURE_2:
        {
            var pla_character = global.characters[0];
            draw_set_font(global.font_hud_adventure_2_lives);
            draw_sprite(sprHUDAdvance3LifeIcon, pla_character, 12, CAMERA_HEIGHT - 20);
            draw_text(29, CAMERA_HEIGHT - 14, $"{global.life_count > 99 ? "99" : string_pad(global.life_count, 2)}");
            break;
        }
        case HUD.ADVANCE_2:
        {
            var pla_character = global.characters[0];
            draw_set_font(global.font_hud_advance_2);
            draw_sprite(sprHUDAdvance2LifeIcon, pla_character, 6, CAMERA_HEIGHT - 18);
            draw_text(30, CAMERA_HEIGHT - 20, $"{global.life_count > 9 ? "9" : global.life_count}");
            break;
        }
        case HUD.ADVANCE_3:
        {
            draw_set_font(global.font_hud_advance_3);
            for (var i = array_length(global.characters) - 1; i >= 0; --i)
            {
                var pla_character = global.characters[i];
                draw_sprite(sprHUDAdvance3LifeIcon, pla_character, 5 + i * 10, CAMERA_HEIGHT - 20);
            }
            if (array_length(global.characters) == 1) draw_text(22, CAMERA_HEIGHT - 20, "x");
            draw_text(32, CAMERA_HEIGHT - 20, $"{global.life_count > 9 ? "9" : global.life_count}");
            break;
        }
    }
}

draw_reset();
draw_set_font(-1);

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */