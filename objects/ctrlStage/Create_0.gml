/// @description Initialize
image_speed = 0;
stage_players = [];

// Timing
stage_time = 0;
time_limit = time_to_frames(10, 0);
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

// Setup tilemaps; delist invalid ones
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
        for (var i = 0; i < array_length(tilemaps); i++)
        {
            layer_tilemap_set_colmask(tilemaps[i], sprSunsetHillCollision);
        }
        break;
    }
}

// Create UI elements
instance_create_layer(0, 0, "Display", objHUD);