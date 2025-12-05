global.save_database = db_create();
db_write(global.save_database, "", "name");
db_write(global.save_database, 0, "playtime");
db_write(global.save_database, room_get_name(rmTest), "stage");
db_write(global.save_database, true, "boost");
db_write(global.save_database, true, "trick");
db_write(global.save_database, true, "tag");
db_write(global.save_database, true, "swap");

for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
    db_write(global.save_database, CHARACTER.NONE, "character", i);
}

db_write(global.save_database, CHARACTER.SONIC, "character", 0);