/// @description Render
switch (index)
{
    case TRANSITION.FADE:
    {
        draw_set_color(c_black);
        draw_set_alpha(fade_alpha);
        draw_rectangle(0, 0, CAMERA_WIDTH, CAMERA_HEIGHT, false);
        draw_reset();
        break;
    }
    case TRANSITION.TITLE_CARD:
    {
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
            draw_sprite(sprTitleCardLoading, (transition_time div 15) - 1, 4, CAMERA_HEIGHT - 12);
        }
        
        draw_reset();
        draw_set_font(-1);
        break;
    }
    case TRANSITION.TRY_AGAIN:
    {
        // Curtains
        draw_sprite_tiled_extra(sprTitleCardCurtain, 1, curtain_scroll, curtain_y - curtain_height, 0, 1, 1, 1, 0, c_black);
        draw_sprite_tiled_extra(sprTitleCardCurtain, 1, 16 - curtain_scroll, CAMERA_HEIGHT - curtain_y + curtain_height, 0, 1, 1, -1, 0, c_black);
        
        // Try Again
        draw_set_font(global.font_title_card);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(try_again_x, CAMERA_HEIGHT / 2, try_again_text);
        
        draw_reset();
        draw_set_font(-1);
        break;
    }
    case TRANSITION.GAME_OVER:
    {
        // Game Over
        if (state < GAME_OVER_STATE.GOTO)
        {
            draw_set_font(global.font_title_card);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_text(game_over_x, CAMERA_HEIGHT / 2, game_over_text);
        }
        
        // Fade
        draw_set_color(c_white);
        draw_set_alpha(fade_alpha);
        draw_rectangle(0, 0, CAMERA_WIDTH, CAMERA_HEIGHT, false);
        draw_reset();
        
        draw_reset();
        draw_set_font(-1);
        break;
    }
}