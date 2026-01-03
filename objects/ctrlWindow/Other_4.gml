/// @description Enable
view_enabled = true;
view_visible[0] = true;
camera_set_view_size(CAMERA_ID, CAMERA_WIDTH, CAMERA_HEIGHT);

switch (room)
{
    case rmTestNew:
    {
        background = draw_background_seaside_hill;
    }
}