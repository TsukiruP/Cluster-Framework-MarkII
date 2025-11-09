#region Effects

global.ani_brake_dust_v0 = new animation(sprBrakeDust, 2, -1);
global.ani_ring_sparkle_v0 = new animation(sprRingSparkle, 4, -1);

#endregion

#region Objects

global.ani_spring_vertical_v0 = new animation(sprSpringVertical, 0);
global.ani_spring_vertical_v1 = new animation(sprSpringVertical, [2, 4, 2, 4, 2], -1, [1, 2, 3, 4, 5]);
global.ani_spring_vertical = [global.ani_spring_vertical_v0, global.ani_spring_vertical_v1];

#endregion

#region Player

global.ani_spin_dash_v0 = new animation(sprSpinDash0, 2);
global.ani_spin_dash_v1 = new animation(sprSpinDash1, 2);
global.ani_spin_dash = [global.ani_spin_dash_v0, global.ani_spin_dash_v1];

#endregion

#region Sonic

global.ani_sonic_idle_v0 = new animation(sprSonicIdle, [6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 12, 6, 6, 6, 12, 8, 6, 6, 6, 6]);

global.ani_sonic_teeter_front_v0 = new animation(sprSonicTeeterFront, 3, 1);
global.ani_sonic_teeter_back_v0 = new animation(sprSonicTeeterBack, [3, 4, 4, 4, 4, 4, 4, 4, 4], 1);
global.ani_sonic_teeter = [global.ani_sonic_teeter_front_v0, global.ani_sonic_teeter_back_v0];

global.ani_sonic_turn_v0 = new animation(sprSonicTurn, 1, -1);
global.ani_sonic_turn_brake_v0 = new animation(sprSonicTurnBrake, 2, -1);
global.ani_sonic_turn = [global.ani_sonic_turn_v0, global.ani_sonic_turn_brake_v0];

global.ani_sonic_run_v0 = new animation(sprSonicRun0, 8);
global.ani_sonic_run_v1 = new animation(sprSonicRun1, 8);
global.ani_sonic_run_v2 = new animation(sprSonicRun2, 8);
global.ani_sonic_run_v3 = new animation(sprSonicRun3, 8);
global.ani_sonic_run_v4 = new animation(sprSonicRun4, 8);
global.ani_sonic_run = [global.ani_sonic_run_v0, global.ani_sonic_run_v1, global.ani_sonic_run_v2, global.ani_sonic_run_v3, global.ani_sonic_run_v4];

global.ani_sonic_brake_v0 = new animation(sprSonicBrake, [2, 4, 4], 1);
global.ani_sonic_brake_fast_v0 = new animation(sprSonicBrakeFast, [1, 1, 3, 3], 2);
global.ani_sonic_brake = [global.ani_sonic_brake_v0, global.ani_sonic_brake_fast_v0];

global.ani_sonic_look_v0 = new animation(sprSonicLook, [4, 4, 12, 12, 12, 12], 2);
global.ani_sonic_look_v1 = new animation(sprSonicLook, 2, -1, [1, 0]);
global.ani_sonic_look = [global.ani_sonic_look_v0, global.ani_sonic_look_v1];

global.ani_sonic_crouch_v0 = new animation(sprSonicCrouch, 1, -1);
global.ani_sonic_crouch_v1 = new animation(sprSonicCrouch, 1, -1, [1, 0]);
global.ani_sonic_crouch = [global.ani_sonic_crouch_v0, global.ani_sonic_crouch_v1];

global.ani_sonic_roll_v0 = new animation(sprSonicRoll, 2);

global.ani_sonic_spin_dash_v0 = new animation(sprSonicSpinDash0, 2);
global.ani_sonic_spin_dash_v1 = new animation(sprSonicSpinDash1, 2, -1);
global.ani_sonic_spin_dash = [global.ani_sonic_spin_dash_v0, global.ani_sonic_spin_dash_v1];

global.ani_sonic_fall_v0 = new animation(sprSonicSpring1, 2, -1, [4, 5]);
global.ani_sonic_fall_v1 = new animation(sprSonicSpring2, 2);
global.ani_sonic_fall = [global.ani_sonic_fall_v0, global.ani_sonic_fall_v1];

global.ani_sonic_jump_v0 = new animation(sprSonicJump0, [3, 2], -1);
global.ani_sonic_jump_v1 = new animation(sprSonicJump1, 2);
global.ani_sonic_jump_v2 = new animation(sprSonicJump2, [1, 2, 2, 2], 1);
global.ani_sonic_jump = [global.ani_sonic_jump_v0, global.ani_sonic_jump_v1, global.ani_sonic_jump_v2];

global.ani_sonic_spring_v0 = new animation(sprSonicSpring0, 3, 1);
global.ani_sonic_spring_v1 = new animation(sprSonicSpring1, [2, 2, 2, 3, 3, 3], -1);
global.ani_sonic_spring_v2 = new animation(sprSonicSpring2, 3);
global.ani_sonic_spring = [global.ani_sonic_spring_v0, global.ani_sonic_spring_v1, global.ani_sonic_spring_v2];

global.ani_sonic_spring_twirl_v0 = new animation(sprSonicSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

#endregion

#region Miles

global.ani_miles_idle_v0 = new animation(sprMilesIdle, 8);

global.ani_miles_teeter_front_v0 = new animation(sprMilesTeeterFront, 3, 1);
global.ani_miles_teeter_back_v0 = new animation(sprMilesTeeterBack, 4, 1);
global.ani_miles_teeter = [global.ani_miles_teeter_front_v0, global.ani_miles_teeter_back_v0];

global.ani_miles_turn_v0 = new animation(sprMilesTurn, 1, -1);
global.ani_miles_turn_brake_v0 = new animation(sprMilesTurnBrake, 2, -1);
global.ani_miles_turn = [global.ani_miles_turn_v0, global.ani_miles_turn_brake_v0];

global.ani_miles_run_v0 = new animation(sprMilesRun0, 8);
global.ani_miles_run_v1 = new animation(sprMilesRun1, 8);
global.ani_miles_run_v2 = new animation(sprMilesRun2, 8);
global.ani_miles_run_v3 = new animation(sprMilesRun3, 8);
global.ani_miles_run_v4 = new animation(sprMilesRun4, 8);
global.ani_miles_run_v5 = new animation(sprMilesRun5, 8);
global.ani_miles_run = [global.ani_miles_run_v0, global.ani_miles_run_v1, global.ani_miles_run_v2, global.ani_miles_run_v3, global.ani_miles_run_v4, global.ani_miles_run_v5];

global.ani_miles_brake_v0 = new animation(sprMilesBrake, [2, 4, 4, 4], 1);
global.ani_miles_brake_fast_v0 = new animation(sprMilesBrakeFast, [2, 3, 3], 1);
global.ani_miles_brake = [global.ani_miles_brake_v0, global.ani_miles_brake_fast_v0];

global.ani_miles_look_v0 = new animation(sprMilesLook, [4, 4, 10, 10, 10, 10], 2);
global.ani_miles_look_v1 = new animation(sprMilesLook, 2, -1, [1, 0]);
global.ani_miles_look = [global.ani_miles_look_v0, global.ani_miles_look_v1];

global.ani_miles_crouch_v0 = new animation(sprMilesCrouch, [1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6], 2);
global.ani_miles_crouch_v1 = new animation(sprMilesCrouch, 1, -1, [1, 0]);
global.ani_miles_crouch = [global.ani_miles_crouch_v0, global.ani_miles_crouch_v1];

global.ani_miles_roll_v0 = new animation(sprMilesRoll, 2);
global.ani_miles_tails_v0 = new animation(sprMilesTails, 2);

global.ani_miles_spin_dash_v0 = new animation(sprMilesSpinDash0, 2);
global.ani_miles_spin_dash_v1 = new animation(sprMilesSpinDash1, 2, -1);
global.ani_miles_spin_dash = [global.ani_miles_spin_dash_v0, global.ani_miles_spin_dash_v1];

global.ani_miles_fall_v0 = new animation(sprMilesSpring1, 2, -1, [4, 5]);
global.ani_miles_fall_v1 = new animation(sprMilesSpring2, 2);
global.ani_miles_fall = [global.ani_miles_fall_v0, global.ani_miles_fall_v1];

global.ani_miles_jump_v0 = new animation(sprMilesJump0, 3, -1);
global.ani_miles_jump_v1 = new animation(sprMilesJump1, 2);
global.ani_miles_jump_v2 = new animation(sprMilesJump2, [1, 2, 2, 2, 2, 2]);
global.ani_miles_jump = [global.ani_miles_jump_v0, global.ani_miles_jump_v1, global.ani_miles_jump_v2];

global.ani_miles_spring_v0 = new animation(sprMilesSpring0, 2);
global.ani_miles_spring_v1 = new animation(sprMilesSpring1, [2, 3, 3, 4, 4, 4], -1);
global.ani_miles_spring_v2 = new animation(sprMilesSpring2, 3, 1);
global.ani_miles_spring = [global.ani_miles_spring_v0, global.ani_miles_spring_v1, global.ani_miles_spring_v2];

global.ani_miles_spring_twirl_v0 = new animation(sprMilesSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

#endregion

#region Knuckles

global.ani_knuckles_idle_v0 = new animation(sprKnucklesIdle, [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 10, 5, 5, 5, 5, 5, 5, 5, 12, 6, 5, 5, 5, 5, 5, 5]);

global.ani_knuckles_teeter_front_v0 = new animation(sprKnucklesTeeterFront, 3, 1);
global.ani_knuckles_teeter_back_v0 = new animation(sprKnucklesTeeterBack, [3, 4, 4, 4, 4, 4, 4], 1);
global.ani_knuckles_teeter = [global.ani_knuckles_teeter_front_v0, global.ani_knuckles_teeter_back_v0];

global.ani_knuckles_turn_v0 = new animation(sprKnucklesTurn, 1, -1);
global.ani_knuckles_turn_brake_v0 = new animation(sprKnucklesTurnBrake, 1, -1);
global.ani_knuckles_turn = [global.ani_knuckles_turn_v0, global.ani_knuckles_turn_brake_v0];

global.ani_knuckles_run_v0 = new animation(sprKnucklesRun0, 8);
global.ani_knuckles_run_v1 = new animation(sprKnucklesRun1, 8);
global.ani_knuckles_run_v2 = new animation(sprKnucklesRun2, 8);
global.ani_knuckles_run_v3 = new animation(sprKnucklesRun3, 8);
global.ani_knuckles_run_v4 = new animation(sprKnucklesRun4, 8);
global.ani_knuckles_run = [global.ani_knuckles_run_v0, global.ani_knuckles_run_v1, global.ani_knuckles_run_v2, global.ani_knuckles_run_v3, global.ani_knuckles_run_v4];

global.ani_knuckles_brake_v0 = new animation(sprKnucklesBrake, 2, 1);
global.ani_knuckles_brake_fast_v0 = new animation(sprKnucklesBrakeFast, [1, 1, 3, 3], 2);
global.ani_knuckles_brake = [global.ani_knuckles_brake_v0, global.ani_knuckles_brake_fast_v0];

global.ani_knuckles_look_v0 = new animation(sprKnucklesLook, [4, 4, 2], -1);
global.ani_knuckles_look_v1 = new animation(sprKnucklesLook, 2, -1, [1, 0]);
global.ani_knuckles_look = [global.ani_knuckles_look_v0, global.ani_knuckles_look_v1];

global.ani_knuckles_crouch_v0 = new animation(sprKnucklesCrouch, 1, -1);
global.ani_knuckles_crouch_v1 = new animation(sprKnucklesCrouch, 1, -1, [1, 0]);
global.ani_knuckles_crouch = [global.ani_knuckles_crouch_v0, global.ani_knuckles_crouch_v1];

global.ani_knuckles_roll_v0 = new animation(sprKnucklesRoll, 2);

global.ani_knuckles_spin_dash_v0 = new animation(sprKnucklesSpinDash0, 2);
global.ani_knuckles_spin_dash_v1 = new animation(sprKnucklesSpinDash1, 2, -1);
global.ani_knuckles_spin_dash = [global.ani_knuckles_spin_dash_v0, global.ani_knuckles_spin_dash_v1];

global.ani_knuckles_fall_v0 = new animation(sprKnucklesSpring1, 2, -1, [4, 5]);
global.ani_knuckles_fall_v1 = new animation(sprKnucklesSpring2, 2);
global.ani_knuckles_fall = [global.ani_knuckles_fall_v0, global.ani_knuckles_fall_v1];

global.ani_knuckles_jump_v0 = new animation(sprKnucklesJump0, [3, 2], -1);
global.ani_knuckles_jump_v1 = new animation(sprKnucklesJump1, 2);
global.ani_knuckles_jump_v2 = new animation(sprKnucklesJump2, [1, 2, 2, 2], 1);
global.ani_knuckles_jump = [global.ani_knuckles_jump_v0, global.ani_knuckles_jump_v1, global.ani_knuckles_jump_v2];

global.ani_knuckles_spring_v0 = new animation(sprKnucklesSpring0, 3);
global.ani_knuckles_spring_v1 = new animation(sprKnucklesSpring1, 3, -1);
global.ani_knuckles_spring_v2 = new animation(sprKnucklesSpring2, 3);
global.ani_knuckles_spring = [global.ani_knuckles_spring_v0, global.ani_knuckles_spring_v1, global.ani_knuckles_spring_v2];

global.ani_knuckles_spring_twirl_v0 = new animation(sprKnucklesSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

#endregion

#region Amy

global.ani_amy_idle_v0 = new animation(sprAmyIdle, 7);
global.ani_amy_idle_alt_v0 = new animation(sprAmyIdleAlt, 6);

global.ani_amy_teeter_front_v0 = new animation(sprAmyTeeterFront, [5, 4, 3, 20, 6, 8, 6], 3);
global.ani_amy_teeter_back_v0 = new animation(sprAmyTeeterBack, [3, 4, 5, 15, 5, 5, 5], 3);
global.ani_amy_teeter = [global.ani_amy_teeter_front_v0, global.ani_amy_teeter_back_v0];

global.ani_amy_turn_v0 = new animation(sprAmyTurn, 1, -1);
global.ani_amy_turn_brake_v0 = new animation(sprAmyTurnBrake, 2, -1);
global.ani_amy_turn = [global.ani_amy_turn_v0, global.ani_amy_turn_brake_v0];

global.ani_amy_run_v0 = new animation(sprAmyRun0, 8);
global.ani_amy_run_v1 = new animation(sprAmyRun1, 8);
global.ani_amy_run_v2 = new animation(sprAmyRun2, 8);
global.ani_amy_run_v3 = new animation(sprAmyRun3, 8);
global.ani_amy_run_v4 = new animation(sprAmyRun4, 8);
global.ani_amy_run = [global.ani_amy_run_v0, global.ani_amy_run_v1, global.ani_amy_run_v2, global.ani_amy_run_v3, global.ani_amy_run_v4];

global.ani_amy_run_alt_v0 = new animation(sprAmyRunAlt0, 8);
global.ani_amy_run_alt_v1 = new animation(sprAmyRunAlt1, 8);
global.ani_amy_run_alt_v2 = new animation(sprAmyRunAlt2, 8);
global.ani_amy_run_alt_v3 = new animation(sprAmyRunAlt3, 8);
global.ani_amy_run_alt = [global.ani_amy_run_alt_v0, global.ani_amy_run_alt_v1, global.ani_amy_run_alt_v2, global.ani_amy_run_alt_v3];

global.ani_amy_brake_v0 = new animation(sprAmyBrake, 2, 1);
global.ani_amy_brake_fast_v0 = new animation(sprAmyBrakeFast, [1, 1, 3, 3, 3], 2);
global.ani_amy_brake = [global.ani_amy_brake_v0, global.ani_amy_brake_fast_v0];

global.ani_amy_look_v0 = new animation(sprAmyLook0, [3, 3, 3, 60, 6, 8, 6], 3);
global.ani_amy_look_v1 = new animation(sprAmyLook1, 2, -1);
global.ani_amy_look = [global.ani_amy_look_v0, global.ani_amy_look_v1];

global.ani_amy_crouch_v0 = new animation(sprAmyCrouch0, [1, 1, 10, 6, 8, 6, 60, 6, 8, 6], 6);
global.ani_amy_crouch_v1 = new animation(sprAmyCrouch1, 1, -1);
global.ani_amy_crouch = [global.ani_amy_crouch_v0, global.ani_amy_crouch_v1];

global.ani_amy_roll_v0 = new animation(sprAmyRoll, 2);

global.ani_amy_spin_dash_v0 = new animation(sprAmySpinDash, 3);

global.ani_amy_fall_v0 = new animation(sprAmySpring1, 2, -1, [4, 5]);
global.ani_amy_fall_v1 = new animation(sprAmySpring2, 2);
global.ani_amy_fall = [global.ani_amy_fall_v0, global.ani_amy_fall_v1];

global.ani_amy_jump_v0 = new animation(sprAmyJump0, [3, 2], -1);
global.ani_amy_jump_v1 = new animation(sprAmyJump1, 2);
global.ani_amy_jump_v2 = new animation(sprAmyJump2, [1, 2, 2, 2, 2], 2);
global.ani_amy_jump = [global.ani_amy_jump_v0, global.ani_amy_jump_v1, global.ani_amy_jump_v2];

global.ani_amy_spring_v0 = new animation(sprAmySpring0, 3);
global.ani_amy_spring_v1 = new animation(sprAmySpring1, [3, 3, 3, 4, 4, 4], -1);
global.ani_amy_spring_v2 = new animation(sprAmySpring2, 3, 1);
global.ani_amy_spring = [global.ani_amy_spring_v0, global.ani_amy_spring_v1, global.ani_amy_spring_v2];

global.ani_amy_spring_twirl_v0 = new animation(sprAmySpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

#endregion

#region Cream

global.ani_cream_idle_v0 = new animation(sprCreamIdle, [5, 5, 7, 10, 3, 3, 3, 7, 5, 5, 7, 10, 3, 3, 3, 7]);

global.ani_cream_teeter_front_v0 = new animation(sprCreamTeeterFront, 3);
global.ani_cream_teeter_back_v0 = new animation(sprCreamTeeterBack, 4);
global.ani_cream_teeter = [global.ani_cream_teeter_front_v0, global.ani_cream_teeter_back_v0];

global.ani_cream_turn_v0 = new animation(sprCreamTurn, 1, -1);
global.ani_cream_turn_brake_v0 = new animation(sprCreamTurnBrake, 2, -1);
global.ani_cream_turn = [global.ani_cream_turn_v0, global.ani_cream_turn_brake_v0];

global.ani_cream_run_v0 = new animation(sprCreamRun0, 8);
global.ani_cream_run_v1 = new animation(sprCreamRun1, 8);
global.ani_cream_run_v2 = new animation(sprCreamRun2, 8);
global.ani_cream_run_v3 = new animation(sprCreamRun3, 8);
global.ani_cream_run_v4 = new animation(sprCreamRun4, 8);
global.ani_cream_run = [global.ani_cream_run_v0, global.ani_cream_run_v1, global.ani_cream_run_v2, global.ani_cream_run_v3, global.ani_cream_run_v4];

global.ani_cream_brake_v0 = new animation(sprCreamBrake, [2, 4, 4], 1);
global.ani_cream_brake_fast_v0 = new animation(sprCreamBrakeFast, 2);
global.ani_cream_brake = [global.ani_cream_brake_v0, global.ani_cream_brake_fast_v0];

global.ani_cream_look_v0 = new animation(sprCreamLook, [3, 3, 3, 60, 6, 6, 6], 3);
global.ani_cream_look_v1 = new animation(sprCreamLook, 2, -1, [3, 2, 1, 0]);
global.ani_cream_look = [global.ani_cream_look_v0, global.ani_cream_look_v1];

global.ani_cream_crouch_v0 = new animation(sprCreamCrouch, 1, -1);
global.ani_cream_crouch_v1 = new animation(sprCreamCrouch, 1, -1, [1, 0]);
global.ani_cream_crouch = [global.ani_cream_crouch_v0, global.ani_cream_crouch_v1];

global.ani_cream_roll_v0 = new animation(sprCreamRoll, 2);
global.ani_cream_ears_v0 = new animation(sprCreamEars, 2);

global.ani_cream_spin_dash_v0 = new animation(sprCreamSpinDash, 2);

global.ani_cream_fall_v0 = new animation(sprCreamSpring1, 2, -1, [4, 5]);
global.ani_cream_fall_v1 = new animation(sprCreamSpring2, 2);
global.ani_cream_fall = [global.ani_cream_fall_v0, global.ani_cream_fall_v1];

global.ani_cream_jump_v0 = new animation(sprCreamJump0, 3, -1);
global.ani_cream_jump_v1 = new animation(sprCreamJump1, 2);
global.ani_cream_jump_v2 = new animation(sprCreamJump2, [1, 2, 2, 2], 1);
global.ani_cream_jump = [global.ani_cream_jump_v0, global.ani_cream_jump_v1, global.ani_cream_jump_v2];

global.ani_cream_spring_v0 = new animation(sprCreamSpring0, 3, 1);
global.ani_cream_spring_v1 = new animation(sprCreamSpring1, [2, 3, 3, 4, 4, 4], -1);
global.ani_cream_spring_v2 = new animation(sprCreamSpring2, 3);
global.ani_cream_spring = [global.ani_cream_spring_v0, global.ani_cream_spring_v1, global.ani_cream_spring_v2];

global.ani_cream_spring_twirl_v0 = new animation(sprCreamSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 3, 3, 3], 12);

#endregion