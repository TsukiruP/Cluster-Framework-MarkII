/// @description Setup
scale = (os_type == os_linux ? 1 : 2);

// STANNcam
stanncam_init(CAMERA_WIDTH, CAMERA_HEIGHT, CAMERA_WIDTH * scale, CAMERA_HEIGHT * scale);
global.main_camera = new stanncam();
global.main_camera.room_constrain = true;
global.main_camera.bounds_w = 8;
global.main_camera.bounds_h = 32;
//global.main_camera.debug_draw = true;
stanncam_debug_set_draw_zones(true);

/* AUTHOR NOTE: scale is increased on creation. */
event_perform(ev_keypress, vk_f4);