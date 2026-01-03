/// @description Setup
image_speed = 0;
scale = (os_type == os_linux ? 1 : 2);
background = draw_background_none;

/* AUTHOR NOTE: scale is increased on creation. */
event_perform(ev_keypress, vk_f4);