/// @description Initialize
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-8, -8, 8, 8);
reaction = function(pla)
{
	if (collision_player(0, pla))
    {
        static coll_layer0 = layer_tilemap_get_id("TilesLayer0");
        static coll_layer1 = layer_tilemap_get_id("TilesLayer1");
        
        pla.collision_layer = index;
        pla.tilemaps[1] = (index == 0 ? coll_layer0 : coll_layer1);
    }
};