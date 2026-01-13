/// @description Render
var time = ctrlGame.game_time;
var cam_x = camera_get_view_x(CAMERA_ID);
var cam_y = camera_get_view_y(CAMERA_ID);

// Sky
draw_sprite_tiled_area(sprSeasideHillBackgroundSky, 0, (time >> 4), sky_y, cam_x, cam_y, CAMERA_WIDTH, sky_height);

// Sea
var sea_y1 = cam_y + sky_height;
var sea_x2 = cam_x + CAMERA_WIDTH;
var sea_y2 = cam_y + CAMERA_HEIGHT;
draw_rectangle_colour(cam_x, sea_y1, sea_x2, sea_y2, sea_color, sea_color, sea_color, sea_color, false);
for (var i = 0; i < sea_height; i++)
{
    draw_sprite_tiled_area(sprSeasideHillBackgroundSea, 0, ((i + 2) * time div 256) + cam_x div 512, i, cam_x, cam_y + i + sky_height, CAMERA_WIDTH, 1);
}

// Rocks
for (var i = 0; i < array_length(rock_index); i++)
{
    draw_sprite_tiled_area(rock_index[i], 0, 0, 0, cam_x, cam_y + rock_oy[i], CAMERA_WIDTH, sprite_get_height(rock_index[i]), rock_hsep[i], 0, (-cam_x >> 7 - i) + rock_xoffset[i]);
}