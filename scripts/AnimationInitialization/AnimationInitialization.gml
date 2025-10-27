#region Effects

global.ani_spin_dash_v0 = new animation(sprSpinDash0, 2);
global.ani_spin_dash_v1 = new animation(sprSpinDash1, 2);

#endregion

#region Sonic

global.ani_sonic_idle_v0 = new animation(sprSonicIdle, [6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 12, 6, 6, 6, 12, 8, 6, 6, 6, 6]);

global.ani_sonic_teeter_front_v0 = new animation(sprSonicTeeterFront, 3, 0, 1);
global.ani_sonic_teeter_back_v0 = new animation(sprSonicTeeterBack, [3, 4, 4, 4, 4, 4, 4, 4, 4], 0, 1);

global.ani_sonic_turn_v0 = new animation(sprSonicTurn, 1, 0, -1);
global.ani_sonic_turn_brake_v0 = new animation(sprSonicTurnBrake, 2, 0, -1);

global.ani_sonic_run_v0 = new animation(sprSonicRun0, 8);
global.ani_sonic_run_v1 = new animation(sprSonicRun1, 8);
global.ani_sonic_run_v2 = new animation(sprSonicRun2, 8);
global.ani_sonic_run_v3 = new animation(sprSonicRun3, 8);
global.ani_sonic_run_v4 = new animation(sprSonicRun4, 8);

global.ani_sonic_brake_v0 = new animation(sprSonicBrake, [2, 4, 4], 0, 1);
global.ani_sonic_brake_fast_v0 = new animation(sprSonicBrakeFast, [1, 1, 3, 3], 0, 2);

global.ani_sonic_look_v0 = new animation(sprSonicLook, [4, 4, 12, 12, 12, 12], 0, 2);
global.ani_sonic_look_v1 = new animation(sprSonicLook, 2, 0, -1, [1, 0]);

global.ani_sonic_crouch_v0 = new animation(sprSonicCrouch, 1, 0, -1);
global.ani_sonic_crouch_v1 = new animation(sprSonicCrouch, 1, 0, -1, [1, 0]);

global.ani_sonic_roll_v0 = new animation(sprSonicRoll, 2);

global.ani_sonic_spin_dash_v0 = new animation(sprSonicSpinDash0, 2);
global.ani_sonic_spin_dash_v1 = new animation(sprSonicSpinDash1, 2, 0, -1);

global.ani_sonic_fall_v0 = new animation(sprSonicSpring1, 2, 0, -1, [4, 5]);
global.ani_sonic_fall_v1 = new animation(sprSonicSpring2, 2);

global.ani_sonic_jump_v0 = new animation(sprSonicJump0, [3, 2], 0, -1);
global.ani_sonic_jump_v1 = new animation(sprSonicJump1, 2);
global.ani_sonic_jump_v2 = new animation(sprSonicJump2, [1, 2, 2, 2], 0, 1);

global.ani_sonic_spring_v0 = new animation(sprSonicSpring0, 3, 0, 1);
global.ani_sonic_spring_v1 = new animation(sprSonicSpring1, [2, 2, 2, 3, 3, 3], 0, -1);
global.ani_sonic_spring_v2 = new animation(sprSonicSpring2, 3);

global.ani_sonic_spring_twirl = new animation(sprSonicSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 0, 10);

#endregion