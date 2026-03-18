/// @description Initialize
if (not (ctrlGame.game_flags & GAME_FLAG_KEEP_CHARACTERS))
{
    global.characters = [];
    for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
    {
        var character_element = db_read(SAVE_DATABASE, CHARACTER.NONE, "character", i);
        if (character_element != CHARACTER.NONE) array_push(global.characters, character_element);
    }
}

var player_objects = [objSonic, objMiles, objKnuckles, objAmy, objCream];
with (ctrlStage) stage_players = [];

for (var i = 0; i < array_length(global.characters); i++)
{
    var character_element = global.characters[i];
    var player_element = instance_create_depth(x - i * 32, y, depth + i, player_objects[character_element]);
    with (player_element) player_index = i;
    with (ctrlStage) array_push(stage_players, player_element);
    with (ctrlDebug) debug_watch_player(player_element);
}

with (ctrlGame) game_flags &= ~GAME_FLAG_KEEP_CHARACTERS;
instance_create_layer(x, y, layer, objCamera);
instance_destroy();