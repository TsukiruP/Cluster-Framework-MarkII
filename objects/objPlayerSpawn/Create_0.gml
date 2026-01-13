/// @description Setup
if (not (ctrlGame.game_flags & GAME_FLAG_KEEP_CHARACTERS))
{
    global.characters = [];
    for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
    {
        var character_index = db_read(DATABASE_SAVE, CHARACTER.NONE, "character", i);
        if (character_index == CHARACTER.NONE) break;
        global.characters[i] = character_index;
    }
}

var player_objects = [objSonic, objMiles, objKnuckles, objAmy, objCream];
ctrlStage.stage_players = array_create(INPUT_MAX_PLAYERS, noone);
for (var i = 0; i < array_length(global.characters); i++)
{
    var character_index = global.characters[i];
    if (character_index == CHARACTER.NONE) break;
    var player = instance_create_depth(x - i * 32, y, depth + i - DEPTH_OFFSET_PLAYER, player_objects[character_index]);
    with (player) player_index = i;
    ctrlStage.stage_players[i] = player;
}
ctrlGame.game_flags &= ~GAME_FLAG_KEEP_CHARACTERS;
ctrlStage.stage_players[0].camera = instance_create_depth(x, y, depth - DEPTH_OFFSET_PLAYER, objCamera);
instance_destroy();