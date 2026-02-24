/// @description Initialize
if (not (ctrlGame.game_flags & GAME_FLAG_KEEP_CHARACTERS))
{
    global.characters = [];
    for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
    {
        var character_index = db_read(DATABASE_SAVE, CHARACTER.NONE, "character", i);
        if (character_index != CHARACTER.NONE) array_push(global.characters, character_index);
    }
}

var player_objects = [objSonic, objMiles, objKnuckles, objAmy, objCream];
with (ctrlStage) stage_players = [];
for (var i = 0; i < array_length(global.characters); i++)
{
    var character_index = global.characters[i];
    var player = instance_create_depth(x - i * 32, y, depth + i, player_objects[character_index]);
    with (player) player_index = i;
    with (ctrlStage) array_push(stage_players, player);
}
with (ctrlGame) game_flags &= ~GAME_FLAG_KEEP_CHARACTERS;
instance_create_layer(x, y, layer, objCamera);
instance_destroy();