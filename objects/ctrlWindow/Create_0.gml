/// @description Setup
image_speed = 0;
scale = (os_type == os_linux ? 1 : 2);
event_perform(ev_keypress, vk_f4);
display_set_gui_size(CAMERA_WIDTH, CAMERA_HEIGHT);