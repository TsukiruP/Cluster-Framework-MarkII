/// @description Initialize
global.player = instance_create_depth(x, y, 0, objKnuckles);
global.main_camera.follow = global.player;
instance_destroy();