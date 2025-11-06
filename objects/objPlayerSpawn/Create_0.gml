/// @description Initialize
var player_objects = [objSonic, objMiles, objKnuckles, objAmy, objCream];
global.players = array_create(INPUT_MAX_PLAYERS, noone);
for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
    var character_index = db_read(global.save_database, CHARACTER.NONE, "character", i);
    if (character_index != CHARACTER.NONE)
    {
        var player_inst = instance_create_depth(x - 32 * i, y, DEPTH_PLAYER + i, player_objects[character_index]);
        with (player_inst) player_index = i;
        array_set(global.players, i, player_inst);
    }
}
global.players[0].camera = global.main_camera;
instance_destroy();