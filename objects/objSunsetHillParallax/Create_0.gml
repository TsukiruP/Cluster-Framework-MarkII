/// @description Setup
image_speed = 0;

// Sky
sky_y = 160;
sky_height = sprite_get_height(sprSeasideHillBackgroundSky) - sky_y;

// Sea
sea_color = make_colour_rgb(63, 138, 223);
sea_height = sprite_get_height(sprSeasideHillBackgroundSea);

// Rocks
rock_index = [sprSeasideHillBackgroundRock0, sprSeasideHillBackgroundRock1, sprSeasideHillBackgroundRock2];
rock_oy = [78, 98, 94];
rock_hsep = [94, 215, 155];
rock_xoffset = [15, 232, 153];