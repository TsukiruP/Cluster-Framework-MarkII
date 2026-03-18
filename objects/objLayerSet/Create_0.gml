/// @description Initialize
event_inherited();
hitboxes[0].set_size(0, 0, sprite_width, sprite_height);

reaction = function(_pla)
{
	// Abort if layers already match
	if (_pla.collision_layer == index) exit;
	
	if (collision_player(0, _pla))
    {
        _pla.collision_layer = index;
        _pla.tilemaps[1] = ctrlStage.tilemaps[index + 1];
    }
};