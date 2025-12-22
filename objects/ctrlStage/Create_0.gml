/// @description Setup
image_speed = 0;
stage_players = [];

// Boundary
bound_left = 0;
bound_top = 0;
bound_right = room_width;
bound_bottom = room_height;

// Timing
stage_time = 0;
time_limit = 36000;
time_over = false;
time_enabled = true;

// alarm[0] = 5;

// Identify stage
switch (room)
{
	case rmTest:
	{
		name = "DEMONSTRATION";
		act = 1;
		break;
	}
}

// Setup tilemaps; discard invalid ones
tilemaps =
[
    layer_tilemap_get_id("TilesMain"),
    layer_tilemap_get_id("TilesLayer0"),
    layer_tilemap_get_id("TilesLayer1"),
    layer_tilemap_get_id("TilesSemisolid")
]

if (tilemaps[3] == -1) array_pop(tilemaps);
if (tilemaps[1] == -1) array_delete(tilemaps, 1, 2); 

// Set collision masks
switch (room)
{
    case rmTestNew:
    {
        for (var i = 0; i < array_length(tilemaps); ++i)
        {
            layer_tilemap_set_colmask(tilemaps[i], sprSunsetHillCollision);
        }
        break;
    }
}

// Create UI elements
instance_create_layer(0, 0, "Display", objHUD);