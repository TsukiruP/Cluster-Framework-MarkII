/// @function draw_background_none()
function draw_background_none() {}

/// @function draw_background_neo_green_hill()
function draw_background_neo_green_hill()
{
    var time = ctrlGame.game_time;
    draw_sprite_tiled_area(sprNeoGreenHillBackground, 0, (time >> 4), 0, 0, 0, CAMERA_WIDTH, 16);
    draw_sprite_tiled_area(sprNeoGreenHillBackground, 0, (time >> 5), 16, 0, 16, CAMERA_WIDTH, 8);
    draw_sprite_tiled_area(sprNeoGreenHillBackground, 0, (time >> 6), 24, 0, 24, CAMERA_WIDTH, 16);
    draw_sprite_tiled_area(sprNeoGreenHillBackground, 0, 0, 40, 0, 40, CAMERA_WIDTH, 48);
    for (var i = 88; i < 256; ++i)
    {
        draw_sprite_tiled_area(sprNeoGreenHillBackground, 0, (i - 86) * global.main_camera.get_x() div 256, i, 0, i, CAMERA_WIDTH, 1);
    }
}

/// @function draw_background_seaside_hill()
function draw_background_seaside_hill()
{
    var time = ctrlGame.game_time;
    var cam_x = -global.main_camera.get_x();
    
    // Sky
    var sky_y = 160;
    var sky_height = sprite_get_height(sprSeasideHillBackgroundSky) - sky_y;
    draw_sprite_tiled_area(sprSeasideHillBackgroundSky, 0, (time >> 4), sky_y, 0, 0, CAMERA_WIDTH, sky_height);
    
    // Sea
    var sea_height = sprite_get_height(sprSeasideHillBackgroundSea);
    var sea_color = make_colour_rgb(63, 138, 223);
    draw_rectangle_colour(0, sky_height, CAMERA_WIDTH, CAMERA_HEIGHT, sea_color, sea_color, sea_color, sea_color, false);
    for (var i = 0; i < sea_height; ++i)
    {
        draw_sprite_tiled_area(sprSeasideHillBackgroundSea, 0, (i + 2) * time div 256, i, 0, i + sky_height, CAMERA_WIDTH, 1);
    }
    
    // Rocks
    var rock_index;
    var rock_height;
    var rock_oy;
    var rock_hsep;
    var rock_xoffset;
    
    rock_index[0] = sprSeasideHillBackgroundRock0;
    rock_oy[0] = 78;
    rock_hsep[0] = 94;
    rock_xoffset[0] = (cam_x >> 5) + 15;
    
    rock_index[1] = sprSeasideHillBackgroundRock1;
    rock_oy[1] = 98;
    rock_hsep[1] = 215;
    rock_xoffset[1] = (cam_x >> 6) + 232;
    
    rock_index[2] = sprSeasideHillBackgroundRock2;
    rock_oy[2] = 94;
    rock_hsep[2] = 155;
    rock_xoffset[2] = (cam_x >> 7) + 153;
    
    for (var i = 0; i < array_length(rock_index); ++i)
    {
        draw_sprite_tiled_area(rock_index[i], 0, 0, 0, 0, rock_oy[i], CAMERA_WIDTH, sprite_get_height(rock_index[i]), rock_hsep[i], 0, rock_xoffset[i]);
    }
}