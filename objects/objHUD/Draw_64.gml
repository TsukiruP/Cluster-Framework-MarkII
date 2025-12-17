/// @description Render
var hud = db_read(global.config_database, HUD.DEFAULT, "HUD");
var time = ctrlStage.stage_time;
var time_over = (time == ctrlStage.time_limit);
var flash = time mod 32 < 16;
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
        var pla_speed = global.players[0].x_speed;
        image_index += (pla_speed / 8) + 0.25;
        image_index = image_index mod 256;
        draw_sprite(sprHUDAdvance2, 0, 0, 0);
        draw_sprite(sprHUDRingAdvance2, image_index, 7, 8);
        draw_set_color(global.rings == 0 and flash ? c_red : c_white);
        draw_text(28, 0, string_pad(global.rings, 3));
        draw_reset();
        
        // Score
        draw_text(28, 14, (score >= 999999 ? "999999" : string_pad(score, 6)));
        
        // Time
        var center_x = (CAMERA_WIDTH / 2);
        draw_text(center_x - 28, 0, $"{time_over ? "9" : minutes}");
        draw_text(center_x - 21, 0, ":");
        draw_text(center_x - 12, 0, time_over ? "59" : string_pad(seconds, 2));
        draw_text(center_x + 3, 0, ":");
        draw_text(center_x + 12, 0, time_over ? "99" : string_pad(centiseconds, 2));
        
        // Lives
        var pla_character = global.players[0].character_index;
        draw_sprite(sprLifeIconAdvance2, pla_character, 6, CAMERA_HEIGHT - 18);
        draw_text(30, CAMERA_HEIGHT - 20, $"{lives > 9 ? "9" : lives}");
        break;
    }
    case HUD.ADVANCE_3:
    {
        // Text
        draw_set_font(global.font_hud_advance_3);
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        
        // Type
        var type;
        if (instance_exists(global.players[1]))
        {
            if (instance_exists(objSonic)) type = 0;
            else if (instance_exists(objMiles) or instance_exists(objCream)) type = 1;
            else type = 2;
        }
        else
        {
            switch (global.players[0].character_index)
            {
                case objMiles:
                case objCream:
                {
                    type = 1;
                    break;
                }
                case objKnuckles:
                {
                    type = 2;
                    break;
                }
                default:
                {
                    type = 0;
                }
            }
        }
        draw_sprite(sprHUDTypeAdvance3, type, 8, 0);
        
        // Rings
        draw_set_color(global.rings == 0 and flash ? c_red : c_white);
        draw_text(36, 2, string_pad(global.rings, 3));
        draw_reset();
        
        // Time
        var center_x = (CAMERA_WIDTH / 2);
        draw_sprite(sprHUDTimeAdvance3, 0, center_x - 32, 7);
        draw_text(center_x - 14, 2, $"{time_over ? "9" : minutes}");
        draw_text(center_x - 7, 1, "'");
        draw_text(center_x - 2, 2, time_over ? "59" : string_pad(seconds, 2));
        draw_text(center_x + 13, 1, "\"");
        draw_text(center_x + 20, 2, time_over ? "99" : string_pad(centiseconds, 2));
        
        // Lives
        if (instance_exists(global.players[1]))
        {
            for (var i = INPUT_MAX_PLAYERS - 1; i >= 0; i--)
            {
                var pla_character = global.players[i].character_index;
                draw_sprite(sprLifeIconAdvance3, pla_character, 5 + i * 10, CAMERA_HEIGHT - 20);
            }
        }
        else
        {
        	var pla_character = global.players[0].character_index;
            draw_sprite(sprLifeIconAdvance3, pla_character, 5, CAMERA_HEIGHT - 20);
        }
        draw_text(32, CAMERA_HEIGHT - 20, $"{lives > 9 ? "9" : lives}");
        break;
    }
}

draw_reset();

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */