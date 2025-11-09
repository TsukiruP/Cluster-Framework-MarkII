/// @description Animate
// Inherit the parent event
event_inherited();

/*
switch (animation_data.variant)
{
    case 0:
    {
        hitboxes[0].set_size(-6, -2, 4, 8);
        break;
    }
    case 1:
    {
        switch (image_index)
        {
            case 1:
            {
                hitboxes[0].set_size(-10, -1, 0, 11);
                break;
            }
            case 2:
            {
                hitboxes[0].set_size(1, -10, 11, 0);
                break;
            }
            case 3:
            case 5:
            {
                hitboxes[0].set_size(-3, -6, 7, 4);
                break;
            }
            case 4:
            {
                hitboxes[0].set_size(0, -9, 10, 1);
                break;
            }
        }
        break;
    }
}