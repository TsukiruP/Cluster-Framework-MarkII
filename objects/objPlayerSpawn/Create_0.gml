/// @description Initialize
global.player = instance_create_depth(x, y, DEPTH_PLAYER, objCream);
global.main_camera.follow = global.player;
instance_destroy();