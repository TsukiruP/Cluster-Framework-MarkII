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
    for (var i = 88; i < 160; ++i)
    {
        draw_sprite_tiled_area(sprNeoGreenHillBackground, 0, (i - 86) * global.main_camera.get_x() div 256, i, 0, i, CAMERA_WIDTH, 1);
    }
}

/// @function draw_background_seaside_hill()
function draw_background_seaside_hill()
{
    var cam_x = global.main_camera.get_x();
    
    var sky_y = 160;
    var sky_height = sprite_get_height(sprSeasideHillBackgroundSky) - sky_y;
    //draw_sprite_tiled_area(sprSeasideHillBackgroundSky, 0, 0, sky_y, 0, 0, CAMERA_WIDTH, sky_height);
    
    var sea_height = sprite_get_height(sprSeasideHillBackgroundSea);
    //draw_sprite_tiled_area(sprSeasideHillBackgroundSea, 0, 0, 0, 0, sky_height, CAMERA_WIDTH, sea_height);
    
    var rock_height;
    rock_height[0] = sprite_get_height(sprSeasideHillBackgroundRock0);
    //draw_sprite_tiled_area(sprSeasideHillBackgroundRock0, 0, 0, 0, 0, 0, CAMERA_WIDTH, rock_height[0], 14, 78, 256);
    
    rock_height[1] = sprite_get_height(sprSeasideHillBackgroundRock1);
    draw_sprite_tiled_area(sprSeasideHillBackgroundRock1, 0, 0, 0, 0, 0, CAMERA_WIDTH, rock_height[1], cam_x + 232, 98, 256);
}