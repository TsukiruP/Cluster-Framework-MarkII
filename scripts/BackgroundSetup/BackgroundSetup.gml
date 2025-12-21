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