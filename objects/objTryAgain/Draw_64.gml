/// @description Render
// Curtains
draw_sprite_tiled_extra(sprTitleCardCurtain, 1, curtain_scroll, curtain_y - curtain_height, 0, 1, 1, 1, 0, c_black);
draw_sprite_tiled_extra(sprTitleCardCurtain, 1, 16 - curtain_scroll - 1, CAMERA_HEIGHT - curtain_y + curtain_height, 0, 1, 1, -1, 0, c_black);

// Message
draw_set_font(global.font_title_card);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(message_x, CAMERA_HEIGHT / 2, message_text);

draw_reset();
draw_set_font(-1);