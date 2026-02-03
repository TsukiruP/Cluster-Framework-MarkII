/// @description Render
var time = ctrlStage.stage_time;
var time_over = ctrlStage.time_over;
var time_alert = (ctrlStage.time_limit - time) < time_to_frames(1, 0);
var flash = ctrlGame.game_time mod 32 < 16;
var minutes = time div 3600;
var seconds = time div 60 mod 60;
var centiseconds = floor(time / 0.6) mod 100;

var hud_xstart = -sprite_get_width(sprHUDCluster);
var hud_xend = 4;
var hud_x = interpolate(hud_xstart, hud_xend, active_time / active_duration, EASE_SMOOTHSTEP);
var hud_y = 6;

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

// Lives
if (LIVES_ENABLED)
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
}


// Status Bar
if (status_bar_config != CONFIG_STATUS_BAR.OFF)
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

draw_reset();
draw_set_font(-1);

/* AUTHOR NOTE: for obvious reasons, the divisions for the timestamp do not respect the game framerate. */