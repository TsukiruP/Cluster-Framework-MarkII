/// @description Initialize
global.player = instance_create_depth(x, y, DEPTH_PLAYER, objCream);
global.player.camera = global.main_camera;
instance_destroy();