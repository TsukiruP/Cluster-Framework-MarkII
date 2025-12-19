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
        draw_sprite(sprHUDRingAdvance2, image_index, 7, 8);
        
        draw_set_color(global.ring_count == 0 and flash ? c_red : c_white);
        draw_text(28, 0, string_pad(global.ring_count, 3));
        draw_reset();
        
        // Score
        draw_text(28, 14, (global.score_count >= 999999 ? "999999" : string_pad(global.score_count, 6)));
        
        // Time
        var center_x = (CAMERA_WIDTH / 2);
        draw_text(center_x - 21, 0, ":");
        draw_text(center_x + 3, 0, ":");
        
        draw_set_color(time_flash and flash ? c_red : c_white);
        draw_text(center_x - 28, 0, $"{time_over ? "9" : minutes}");
        draw_text(center_x - 12, 0, time_over ? "59" : string_pad(seconds, 2));
        draw_text(center_x + 12, 0, time_over ? "99" : string_pad(centiseconds, 2));
        draw_reset();
        
        // Lives
        if (ctrlGame.game_mode != GAME_MODE.TIME_ATTACK)
        {
            var pla_character = global.characters[0];
            draw_sprite(sprLifeIconAdvance2, pla_character, 6, CAMERA_HEIGHT - 18);
            draw_text(30, CAMERA_HEIGHT - 20, $"{global.life_count > 9 ? "9" : global.life_count}");
        }
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
        draw_sprite(sprHUDTypeAdvance3, type, 8, 0);
        
        // Rings
        draw_set_color(global.ring_count == 0 and flash ? c_red : c_white);
        draw_text(36, 2, string_pad(global.ring_count, 3));
        draw_reset();
        
        // Time
        var center_x = (CAMERA_WIDTH / 2);
        draw_sprite(sprHUDTimeAdvance3, 0, center_x - 32, 7);
        draw_text(center_x - 7, 1, "'");
        draw_text(center_x + 13, 1, "\"");
        
        draw_set_color(time_flash and flash ? c_red : c_white);
        draw_text(center_x - 14, 2, $"{time_over ? "9" : minutes}");
        draw_text(center_x - 2, 2, time_over ? "59" : string_pad(seconds, 2));
        draw_text(center_x + 20, 2, time_over ? "99" : string_pad(centiseconds, 2));
        draw_reset();
        
        // Lives
        if (ctrlGame.game_mode != GAME_MODE.TIME_ATTACK)
        {
            for (var i = array_length(global.characters) - 1; i >= 0; --i)
            {
                var pla_character = global.characters[i];
                draw_sprite(sprLifeIconAdvance3, pla_character, 5 + i * 10, CAMERA_HEIGHT - 20);
            }
            if (array_length(global.characters) == 1) draw_text(22, CAMERA_HEIGHT - 20, "x");
            draw_text(32, CAMERA_HEIGHT - 20, $"{global.life_count > 9 ? "9" : global.life_count}");
        }
        break;
    }
    case HUD.ADVENTURE:
    {
        // Text
        draw_set_font(global.font_hud_adventure);
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        
        // Time
        draw_sprite(sprHUDTimeAdventure, 0, 10, 13);
        
        draw_set_color(time_flash and flash ? c_red : c_white);
        draw_text(43, 13, time_over ? "09:59:99" : $"{string_pad(minutes, 2)}:{string_pad(seconds, 2)}.{string_pad(centiseconds, 2)}");
        draw_reset();
        
        // Rings
        draw_sprite(sprHUDRingAdventure, 0, 10, 22);
        
        draw_set_color(global.ring_count == 0 and flash ? c_red : c_white);
        draw_text(27, 26, string_pad(global.ring_count, 3));
        draw_reset();
        
        // Lives
        if (ctrlGame.game_mode != GAME_MODE.TIME_ATTACK)
        {
            var pla_character = global.characters[0];
            draw_sprite(sprLifeIconAdventure, pla_character, 11, CAMERA_HEIGHT - 26);
            draw_text(28, CAMERA_HEIGHT - 19, $"{global.life_count > 99 ? "99" : string_pad(global.life_count, 2)}");
        }
        break;
    }
    case HUD.ADVENTURE_2:
    {
        
        break;
    }
}

draw_reset();
draw_set_font(-1);

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */