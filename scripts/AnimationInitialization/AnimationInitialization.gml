#region Effects

global.ani_brake_dust_v0 = new animation(sprBrakeDust, 2, -1);
global.ani_ring_sparkle_v0 = new animation(sprRingSparkle, 4, -1);

#endregion

#region Player

global.ani_spin_dash_v0 = new animation(sprSpinDash0, 2);
global.ani_spin_dash_v1 = new animation(sprSpinDash1, 2);

#endregion

#region Sonic

global.ani_sonic_idle_v0 = new animation(sprSonicIdle, [6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 12, 6, 6, 6, 12, 8, 6, 6, 6, 6]);

global.ani_sonic_teeter_front_v0 = new animation(sprSonicTeeterFront, 3, 1);
global.ani_sonic_teeter_back_v0 = new animation(sprSonicTeeterBack, [3, 4, 4, 4, 4, 4, 4, 4, 4], 1);

global.ani_sonic_turn_v0 = new animation(sprSonicTurn, 1, -1);
global.ani_sonic_turn_brake_v0 = new animation(sprSonicTurnBrake, 2, -1);

global.ani_sonic_run_v0 = new animation(sprSonicRun0, 8);
global.ani_sonic_run_v1 = new animation(sprSonicRun1, 8);
global.ani_sonic_run_v2 = new animation(sprSonicRun2, 8);
global.ani_sonic_run_v3 = new animation(sprSonicRun3, 8);
global.ani_sonic_run_v4 = new animation(sprSonicRun4, 8);

global.ani_sonic_brake_v0 = new animation(sprSonicBrake, [2, 4, 4], 1);
global.ani_sonic_brake_fast_v0 = new animation(sprSonicBrakeFast, [1, 1, 3, 3], 2);

global.ani_sonic_look_v0 = new animation(sprSonicLook, [4, 4, 12, 12, 12, 12], 2);
global.ani_sonic_look_v1 = new animation(sprSonicLook, 2, -1, -0, [1, 0]);

global.ani_sonic_crouch_v0 = new animation(sprSonicCrouch, 1, -1);
global.ani_sonic_crouch_v1 = new animation(sprSonicCrouch, 1, -1, 0, [1, 0]);

global.ani_sonic_roll_v0 = new animation(sprSonicRoll, 2);

global.ani_sonic_spin_dash_v0 = new animation(sprSonicSpinDash0, 2);
global.ani_sonic_spin_dash_v1 = new animation(sprSonicSpinDash1, 2, -1);

global.ani_sonic_fall_v0 = new animation(sprSonicSpring1, 2, -1, 0, [4, 5]);
global.ani_sonic_fall_v1 = new animation(sprSonicSpring2, 2);

global.ani_sonic_jump_v0 = new animation(sprSonicJump0, [3, 2], -1);
global.ani_sonic_jump_v1 = new animation(sprSonicJump1, 2);
global.ani_sonic_jump_v2 = new animation(sprSonicJump2, [1, 2, 2, 2], 1);

global.ani_sonic_spring_v0 = new animation(sprSonicSpring0, 3, 1);
global.ani_sonic_spring_v1 = new animation(sprSonicSpring1, [2, 2, 2, 3, 3, 3], -1);
global.ani_sonic_spring_v2 = new animation(sprSonicSpring2, 3);

global.ani_sonic_spring_twirl_v0 = new animation(sprSonicSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

#endregion

#region Miles

global.ani_miles_idle_v0 = new animation(sprMilesIdle, 8);

global.ani_miles_teeter_front_v0 = new animation(sprMilesTeeterFront, 3, 1);
global.ani_miles_teeter_back_v0 = new animation(sprMilesTeeterBack, 4, 1);

global.ani_miles_turn_v0 = new animation(sprMilesTurn, 1, -1);
global.ani_miles_turn_brake_v0 = new animation(sprMilesTurnBrake, 2, -1);

global.ani_miles_run_v0 = new animation(sprMilesRun0, 8);
global.ani_miles_run_v1 = new animation(sprMilesRun1, 8);
global.ani_miles_run_v2 = new animation(sprMilesRun2, 8);
global.ani_miles_run_v3 = new animation(sprMilesRun3, 8);
global.ani_miles_run_v4 = new animation(sprMilesRun4, 8);
global.ani_miles_run_v5 = new animation(sprMilesRun5, 8);

global.ani_miles_brake_v0 = new animation(sprMilesBrake, [2, 4, 4, 4], 1);
global.ani_miles_brake_fast_v0 = new animation(sprMilesBrakeFast, [2, 3, 3], 1);

global.ani_miles_look_v0 = new animation(sprMilesLook, [4, 4, 10, 10, 10, 10], 2);
global.ani_miles_look_v1 = new animation(sprMilesLook, 2, -1, 0, [1, 0]);

global.ani_miles_crouch_v0 = new animation(sprMilesCrouch, [1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6], 2);
global.ani_miles_crouch_v1 = new animation(sprMilesCrouch, 1, -1, 0, [1, 0]);

global.ani_miles_roll_v0 = new animation(sprMilesRoll, 2);

global.ani_miles_spin_dash_v0 = new animation(sprMilesSpinDash0, 2);
global.ani_miles_spin_dash_v1 = new animation(sprMilesSpinDash1, 2, -1);

global.ani_miles_fall_v0 = new animation(sprMilesSpring1, 2, -1, 0, [4, 5]);
global.ani_miles_fall_v1 = new animation(sprMilesSpring2, 2);

global.ani_miles_jump_v0 = new animation(sprMilesJump0, 3, -1);
global.ani_miles_jump_v1 = new animation(sprMilesJump1, 2);
global.ani_miles_jump_v2 = new animation(sprMilesJump2, [1, 2, 2, 2, 2, 2]);

global.ani_miles_spring_v0 = new animation(sprMilesSpring0, 2);
global.ani_miles_spring_v1 = new animation(sprMilesSpring1, [2, 3, 3, 4, 4, 4], -1);
global.ani_miles_spring_v2 = new animation(sprMilesSpring2, 3, 1);

global.ani_miles_spring_twirl_v0 = new animation(sprMilesSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

#endregion

#region Amy

global.ani_amy_idle_v0 = new animation(sprAmyIdle, 7);

global.ani_amy_teeter_front_v0 = new animation(sprAmyTeeterFront, [5, 4, 3, 20, 6, 8, 6], 3);
global.ani_amy_teeter_back_v0 = new animation(sprAmyTeeterBack, [3, 4, 5, 15, 5, 5, 5], 3);

global.ani_amy_turn_v0 = new animation(sprAmyTurn, 1, -1);
global.ani_amy_turn_brake_v0 = new animation(sprAmyTurnBrake, 2, -1);

global.ani_amy_run_v0 = new animation(sprAmyRun0, 8);
global.ani_amy_run_v1 = new animation(sprAmyRun1, 8);
global.ani_amy_run_v2 = new animation(sprAmyRun2, 8);
global.ani_amy_run_v3 = new animation(sprAmyRun3, 8);
global.ani_amy_run_v4 = new animation(sprAmyRun4, 8);

global.ani_amy_brake_v0 = new animation(sprAmyBrake, 2, 1);
global.ani_amy_brake_fast_v0 = new animation(sprAmyBrakeFast, [1, 1, 3, 3, 3], 2);

global.ani_amy_look_v0 = new animation(sprAmyLook0, [3, 3, 3, 60, 6, 8, 6], 3);
global.ani_amy_look_v1 = new animation(sprAmyLook1, 2, -1);

global.ani_amy_crouch_v0 = new animation(sprAmyCrouch0, [1, 1, 10, 6, 8, 6, 60, 6, 8, 6], 6);
global.ani_amy_crouch_v1 = new animation(sprAmyCrouch1, 1, -1);

global.ani_amy_roll_v0 = new animation(sprAmyRoll, 2);

global.ani_amy_spin_dash_v0 = new animation(sprAmySpinDash, 3);

global.ani_amy_fall_v0 = new animation(sprAmySpring1, 2, -1, 0, [4, 5]);
global.ani_amy_fall_v1 = new animation(sprAmySpring2, 2);

global.ani_amy_jump_v0 = new animation(sprAmyJump0, [3, 2], -1);
global.ani_amy_jump_v1 = new animation(sprAmyJump1, 2);
global.ani_amy_jump_v2 = new animation(sprAmyJump2, [1, 2, 2, 2, 2], 2);

global.ani_amy_spring_v0 = new animation(sprAmySpring0, 3);
global.ani_amy_spring_v1 = new animation(sprAmySpring1, [3, 3, 3, 4, 4, 4], -1);
global.ani_amy_spring_v2 = new animation(sprAmySpring2, 3, 1);

global.ani_amy_spring_twirl_v0 = new animation(sprAmySpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

#endregion