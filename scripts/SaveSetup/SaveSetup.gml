global.save_database = db_create();
db_write(DATABASE_SAVE, "", "name");
db_write(DATABASE_SAVE, 0, "playtime");
db_write(DATABASE_SAVE, room_get_name(rmTest), "stage");
db_write(DATABASE_SAVE, true, "boost");
db_write(DATABASE_SAVE, true, "trick");
db_write(DATABASE_SAVE, true, "tag");
db_write(DATABASE_SAVE, true, "swap");

for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
{
    db_write(DATABASE_SAVE, CHARACTER.NONE, "character", i);
}

db_write(DATABASE_SAVE, CHARACTER.SONIC, "character", 0);