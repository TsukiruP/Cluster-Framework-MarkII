/// @description Setup
if (global.character_reset)
{
    global.stage_characters = array_create(INPUT_MAX_PLAYERS);
    for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
    {
        global.stage_characters[i] = db_read(global.save_database, CHARACTER.NONE, "character", i);
    }
}

var player_objects = [objSonic, objMiles, objKnuckles, objAmy, objCream];
global.players = array_create(INPUT_MAX_PLAYERS, noone);
for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
    var character_index = global.stage_characters[i];
    if (character_index != CHARACTER.NONE)
    {
        var player_inst = instance_create_depth(x - i * 32, y, depth - i + DEPTH_OFFSET_PLAYER, player_objects[character_index]);
        with (player_inst) player_index = i;
        global.players[i] = player_inst;
    }
}
global.character_reset = true;
global.players[0].camera = global.main_camera;
instance_destroy();