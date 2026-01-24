/// @description Render
// Fade
draw_set_color(c_black);
draw_set_alpha(fade_alpha);
draw_rectangle(0, 0, CAMERA_WIDTH, CAMERA_HEIGHT, false);
draw_reset();

// Curtain
draw_sprite(sprTitleCardCurtain, 0, 0, curtain_y);

// Banner
draw_sprite_tiled_extra(sprTitleCardBanner, 0, banner_x, banner_scroll, 1, 0);

// Zone
draw_set_font(global.font_title_card);
draw_set_valign(fa_bottom);
draw_text(zone_x, 126, zone_text);

// Act
if ((target_scene[$ "act"] ?? 0) != 0)
{
    draw_sprite(sprTitleCardAct, target_scene.act, zone_x + 5, 128);
}

// Loading
if (state == TITLE_CARD_STATE.GOTO and not skip_load)
{
    draw_sprite(sprTitleCardLoading, (title_card_time div 15) - 1, 4, CAMERA_HEIGHT - 12);
}

draw_reset();
draw_set_font(-1);