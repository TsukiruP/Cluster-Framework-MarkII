/// @description Render
var time = ctrlStage.stage_time;
var time_over = ctrlStage.time_over;
var time_alert = (ctrlStage.time_limit - time) < time_to_frames(1, 0);
var flash = ctrlGame.game_time mod 32 < 16;
var minutes = time div 3600;
var seconds = time div 60 mod 60;
var centiseconds = floor(time / 0.6) mod 100;

// HUD
switch (hud_config)
{
    case CONFIG_HUD.CLUSTER:
    {
        var hud_xstart = -sprite_get_width(sprHUDCluster);
        var hud_xend = 4;
        hud_x = interpolate(hud_xstart, hud_xend, active_time / active_duration, EASE_SMOOTHSTEP);
        
        // Text
        draw_set_font(global.font_hud_cluster);
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        
        // Time
        draw_sprite(sprHUDCluster, 0, hud_x, hud_y);
        if (not time_alert or (time_alert and flash))
        {
            var time_y = hud_y + 5;
            draw_text(hud_x + 29, time_y, time_over ? "09" : string_pad(minutes, 2));
            draw_text(hud_x + 54, time_y, time_over ? "59" : string_pad(seconds, 2));
            draw_text(hud_x + 79, time_y, time_over ? "99" : string_pad(centiseconds, 2));
        }
        
        // Rings
        draw_sprite(sprHUDCluster, 1, hud_x, hud_y + 26);
        if (global.ring_count > 0 or flash) draw_text(hud_x + 29, hud_y + 31, string_pad(global.ring_count, 3));
        break;
    }
    case CONFIG_HUD.ADVENTURE:
    {
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
        draw_set_color(c_white);
        break;
    }
    case CONFIG_HUD.ADVENTURE_2:
    {
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
        break;
    }
    case CONFIG_HUD.ADVANCE_2:
    {
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
        break;
    }
    case CONFIG_HUD.ADVANCE_3:
    {
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
        break;
    }
    case CONFIG_HUD.EPISODE_II:
    {
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
        break;
    }
}

// Lives
if (LIVES_ENABLED)
{
    switch (hud_config)
    {
        case CONFIG_HUD.CLUSTER:
        {
            var lives_xstart = CAMERA_WIDTH;
            var lives_xend = CAMERA_WIDTH - 60;
            var lives_x = interpolate(lives_xstart, lives_xend, active_time / active_duration, EASE_SMOOTHSTEP);
            var lives_y = hud_y;
            var lives_cap = 99;
            var character_index = global.characters[0];
            draw_sprite(sprHUDCluster, 2, lives_x, lives_y);
            draw_sprite_ext(sprHUDAdvance3LifeIcon, character_index, lives_x + 18, lives_y + 4, -1, 1, 0, c_black, 1);
            draw_sprite_ext(sprHUDAdvance3LifeIcon, character_index, lives_x + 19, lives_y + 3, -1, 1, 0, c_white, 1);
            draw_text(lives_x + 29, lives_y + 5, $"{global.life_count > lives_cap ? lives_cap : string_pad(global.life_count, 2)}");
            break;
        }
        case CONFIG_HUD.ADVENTURE:
        {
            var lives_x = 11;
            var lives_y = CAMERA_HEIGHT - 26;
            var lives_cap = 99;
            var character_index = global.characters[0];
            draw_sprite(sprHUDAdventureLifeIcon, character_index, lives_x, lives_y);
            draw_set_font(global.font_hud_adventure);
            draw_text(lives_x + 17, lives_y + 7, $"{global.life_count > lives_cap ? lives_cap : string_pad(global.life_count, 2)}");
            break;
        }
        case CONFIG_HUD.ADVENTURE_2:
        {
            var lives_x = 22;
            var lives_y = CAMERA_HEIGHT - 20;
            var lives_cap = 99;
            var character_index = global.characters[0];
            draw_sprite_ext(sprHUDAdvance3LifeIcon, character_index, lives_x, lives_y, -1, 1, 0, c_white, 1);
            draw_set_font(global.font_hud_adventure_2_lives);
            draw_text(lives_x + 4, lives_y + 6, $"{global.life_count > lives_cap ? lives_cap : string_pad(global.life_count, 2)}");
            break;
        }
        case CONFIG_HUD.ADVANCE_2:
        {
            var lives_x = 6;
            var lives_y = CAMERA_HEIGHT - 18;
            var lives_cap = 9;
            var character_index = global.characters[0];
            draw_sprite(sprHUDAdvance2LifeIcon, character_index, lives_x, lives_y);
            draw_set_font(global.font_hud_advance_2);
            draw_text(lives_x + 24, lives_y - 2, $"{global.life_count > lives_cap ? lives_cap : global.life_count}");
            break;
        }
        case CONFIG_HUD.ADVANCE_3:
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
            break;
        }
        case CONFIG_HUD.EPISODE_II:
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
            break;
        }
    }
}

// Status Bar
if (hud_config == CONFIG_HUD.CLUSTER and status_bar_config != CONFIG_STATUS_BAR.OFF)
{
    var status_bar_xstart = CAMERA_WIDTH + ITEM_WIDTH * status_bar_count;
    var status_bar_xend = CAMERA_WIDTH - 16;
    var status_bar_x = interpolate(status_bar_xstart, status_bar_xend, active_time / active_duration, EASE_SMOOTHSTEP);
    var status_bar_y = hud_y + (LIVES_ENABLED ? 36 : 8);
    for (var i = 0; i < status_bar_count; i++)
    {
        var status_index = status_bar[i];
        var status_active = status_index.active;
        if (status_bar_config == CONFIG_STATUS_BAR.ALL or status_active)
        {
            if (status_index.visible)
            {
                var icon_index = status_index.icon;
                draw_sprite_ext(sprHUDItemIcon, icon_index, status_bar_x - 1, status_bar_y + 1, 1, 1, 0, c_black, 1);
                draw_sprite_ext(sprHUDItemIcon, icon_index, status_bar_x, status_bar_y, 1, 1, 0, status_bar_config == CONFIG_STATUS_BAR.ALL and not status_active ? c_gray : c_white, 1);
            }
            status_bar_x -= ITEM_WIDTH;
        }
    }
}

// Item Feed
if (item_feed_config)
{
    for (var i = 0; i < array_length(item_feed); i++)
    {
        var popup_index = item_feed[i];
        var popup_x = popup_index.x;
        var icon_index = popup_index.icon;
        if (item_feed_time > 30 or item_feed_time mod 4 < 2)
        {
            draw_sprite(sprHUDItemIcon, icon_index, popup_x, CAMERA_HEIGHT - 33);
        }
    }
}

draw_reset();
draw_set_font(-1);

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */