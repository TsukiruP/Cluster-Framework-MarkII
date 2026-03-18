/// @description Initialize
event_inherited();
hitboxes[0].set_size(-24, -24, 24, 24);

reaction = function(_pla)
{
    if (collision_player(0, _pla))
    {
        with (objCamera)
        {
            target_left = other.x - CAMERA_WIDTH / 2;
            target_right = other.x + CAMERA_WIDTH / 2;
        }
    }
};