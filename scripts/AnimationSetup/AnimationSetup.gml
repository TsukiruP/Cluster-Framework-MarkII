#region Explosions

global.ani_explosion_destroy_v0 = new animation(sprExplosionDestroy, [3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 6], -1);

#endregion

#region Interactables

global.ani_ring_sparkle_v0 = new animation(sprRingSparkle, 4, -1);

global.ani_spring_vertical_v0 = new animation(sprSpringVertical, 0);
global.ani_spring_vertical_v1 = new animation(sprSpringVertical, [2, 4, 2, 4, 2], -1, [1, 2, 3, 4, 5]);
global.ani_spring_vertical = [global.ani_spring_vertical_v0, global.ani_spring_vertical_v1];

global.ani_spring_horizontal_v0 = new animation(sprSpringHorizontal, 0);
global.ani_spring_horizontal_v1 = new animation(sprSpringHorizontal, [2, 4, 2, 4, 2], -1, [1, 2, 3, 4, 5]);
global.ani_spring_horizontal = [global.ani_spring_horizontal_v0, global.ani_spring_horizontal_v1];

global.ani_spring_diagonal_v0 = new animation(sprSpringDiagonal, 0);
global.ani_spring_diagonal_v1 = new animation(sprSpringDiagonal, [2, 4, 2, 4, 2], -1, [1, 2, 3, 4, 5]);
global.ani_spring_diagonal = [global.ani_spring_diagonal_v0, global.ani_spring_diagonal_v1];

global.ani_spring_diagonal_alt_v0 = new animation(sprSpringDiagonalAlt, 0);
global.ani_spring_diagonal_alt_v1 = new animation(sprSpringDiagonalAlt, [2, 4, 2, 4, 2], -1, [1, 2, 3, 4, 5]);
global.ani_spring_diagonal_alt = [global.ani_spring_diagonal_alt_v0, global.ani_spring_diagonal_alt_v1];

global.ani_item_balloon_v0 = new animation(sprItemBalloon, 12);

#endregion

#region Effects

global.ani_brake_dust_v0 = new animation(sprBrakeDust, 2, -1);

global.ani_spin_dash_dust_v0 = new animation(sprSpinDashDust0, 2);
global.ani_spin_dash_dust_v1 = new animation(sprSpinDashDust1, 2);
global.ani_spin_dash_dust = [global.ani_spin_dash_dust_v0, global.ani_spin_dash_dust_v1];

global.ani_miasma_v0 = new animation(sprMiasma, 7);

global.ani_speed_break_v0 = new animation(sprSpeedBreak, 2, 0, [0, 1]);
global.ani_speed_break_v1 = new animation(sprSpeedBreak, 2, -1);
global.ani_speed_break = [global.ani_speed_break_v0, global.ani_speed_break_v1];

global.ani_swap_cooldown_v0 = new animation(sprSwapCooldown0, 3);
global.ani_swap_cooldown_v1 = new animation(sprSwapCooldown1, 3);
global.ani_swap_cooldown_v2 = new animation(sprSwapCooldown2, 3);
global.ani_swap_cooldown_v3 = new animation(sprSwapCooldown3, 3);
global.ani_swap_cooldown_v4 = new animation(sprSwapCooldown4, 3);
global.ani_swap_cooldown = [global.ani_swap_cooldown_v0, global.ani_swap_cooldown_v1, global.ani_swap_cooldown_v2, global.ani_swap_cooldown_v3, global.ani_swap_cooldown_v4];

#endregion

#region Shields

global.ani_shield_basic_v0 = new animation(sprShieldBasic, 3);

global.ani_shield_magnetic_v0 = new animation(sprShieldMagnetic, 3);

global.ani_shield_aqua_wave_v0 = new animation(sprShieldAquaWave, 12);
global.ani_shield_aqua_bound_v0 = new animation(sprShieldAquaShell, 6, -1, [0]);
global.ani_shield_aqua_bound_v1 = new animation(sprShieldAquaBound, 0);
global.ani_shield_aqua_rebound_v0 = new animation(sprShieldAquaBound, [12, 6], -1, [1, 0]);
global.ani_shield_aqua = [global.ani_shield_aqua_wave_v0, global.ani_shield_aqua_bound_v0, global.ani_shield_aqua_bound_v1, global.ani_shield_aqua_rebound_v0];

global.ani_shield_flame_v0 = new animation(sprShieldFlame, 2);
global.ani_shield_flame_dash_v0 = new animation(sprShieldFlameDash, 2, -1, [0, 1, 2, 3, 2, 4, 0, 1, 2, 3, 2, 4]);
global.ani_shield_flame = [global.ani_shield_flame_v0, global.ani_shield_flame_dash_v0];

global.ani_shield_thunder_v0 = new animation(sprShieldThunder, [2, 2, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 2, 2], -1, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2]);
global.ani_shield_thunder_v1 = new animation(sprShieldThunder, 4, -1, [11, 10, 9, 8, 7, 6, 5, 4, 3]);
global.ani_shield_thunder = [global.ani_shield_thunder_v0, global.ani_shield_thunder_v1];
global.ani_shield_thunder_spark_v0 = new animation(sprShieldThunderSpark, 1);

global.ani_shield_invincibility_v0 = new animation(sprShieldInvincibility, 2);
global.ani_shield_invincibility_sparkle_v0 = new animation(sprShieldInvincibilitySparkle, 2, -1);

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

global.ani_sonic_hurt_v0 = new animation(sprSonicHurt0, [3, 8, 8, 8, 8], -1);
global.ani_sonic_hurt_v1 = new animation(sprSonicHurt1, 5, -1);
global.ani_sonic_hurt = [global.ani_sonic_hurt_v0, global.ani_sonic_hurt_v1];

global.ani_sonic_dead_v0 = new animation(sprSonicDead, [3, 3, 12, 2, 3, 3], 4);

global.ani_sonic_trick_up_v0 = new animation(sprSonicTrickUp0, [3, 6, 2], -1);
global.ani_sonic_trick_up_v1 = new animation(sprSonicTrickUp1, [1, 1, 3, 3, 3], 2);
global.ani_sonic_trick_up_v2 = new animation(sprSonicTrickUp2, [3, 3, 3, 2, 2, 2], 3);
global.ani_sonic_trick_up = [global.ani_sonic_trick_up_v0, global.ani_sonic_trick_up_v1, global.ani_sonic_trick_up_v2];

global.ani_sonic_trick_down_v0 = new animation(sprSonicTrickDown0, [3, 3, 6, 2, 2, 2, 2, 2], -1);
global.ani_sonic_trick_down_v2 = new animation(sprSonicTrickDown2, [2, 2, 2, 2, 3, 3, 3], 4);
global.ani_sonic_trick_down = [global.ani_sonic_trick_down_v0, global.ani_sonic_roll_v0, global.ani_sonic_trick_down_v2];

global.ani_sonic_trick_front_v0 = new animation(sprSonicTrickFront0, [2, 4, 1], -1);
global.ani_sonic_trick_front_v1 = new animation(sprSonicTrickFront1, 1);
global.ani_sonic_trick_front = [global.ani_sonic_trick_front_v0, global.ani_sonic_trick_front_v1];

global.ani_sonic_trick_back_v0 = new animation(sprSonicTrickBack, 1, -1, [0]);
global.ani_sonic_trick_back_v1 = new animation(sprSonicTrickBack, [5, 4, 3, 2, 2, 2, 2, 2, 3, 3, 3], 8);
global.ani_sonic_trick_back = [global.ani_sonic_trick_back_v0, global.ani_sonic_trick_back_v1];

global.ani_sonic_spring_v0 = new animation(sprSonicSpring0, 3, 1);
global.ani_sonic_spring_v1 = new animation(sprSonicSpring1, [2, 2, 2, 3, 3, 3], -1);
global.ani_sonic_spring_v2 = new animation(sprSonicSpring2, 3);
global.ani_sonic_spring = [global.ani_sonic_spring_v0, global.ani_sonic_spring_v1, global.ani_sonic_spring_v2];

global.ani_sonic_spring_twirl_v0 = new animation(sprSonicSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

global.ani_sonic_air_dash_v0 = new animation(sprSonicAirDash, 2, -1, [0, 1, 2, 3]);
global.ani_sonic_air_dash_v1 = new animation(sprSonicAirDash, 2, 0, [4, 5, 6]);
global.ani_sonic_air_dash = [global.ani_sonic_air_dash_v0, global.ani_sonic_air_dash_v1];

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
global.ani_miles_jump_v2 = new animation(sprMilesJump2, [1, 2, 2, 2, 2, 2], 3);
global.ani_miles_jump = [global.ani_miles_jump_v0, global.ani_miles_jump_v1, global.ani_miles_jump_v2];

global.ani_miles_hurt_v0 = new animation(sprMilesHurt0, [3, 8, 8, 8, 8], -1);
global.ani_miles_hurt_v1 = new animation(sprMilesHurt1, 5, -1);
global.ani_miles_hurt = [global.ani_miles_hurt_v0, global.ani_miles_hurt_v1];

global.ani_miles_dead_v0 = new animation(sprMilesDead, [3, 3, 12, 2, 3, 3], 4);

global.ani_miles_trick_up_v0 = new animation(sprMilesTrickUp0, [2, 1, 1, 8], -1);
global.ani_miles_trick_up_v1 = new animation(sprMilesTrickUp1, [3, 4, 4, 4, 4], 2);
global.ani_miles_trick_up_v2 = new animation(sprMilesTrickUp2, [2, 4, 4, 3, 3, 3], 3);
global.ani_miles_trick_up = [global.ani_miles_trick_up_v0, global.ani_miles_trick_up_v1, global.ani_miles_trick_up_v2];

global.ani_miles_trick_down_v0 = new animation(sprMilesTrickDown0, [2, 2, 4], -1);
global.ani_miles_trick_down_v1 = new animation(sprMilesTrickDown1, [2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3], 3);
global.ani_miles_trick_down = [global.ani_miles_trick_down_v0, global.ani_miles_trick_down_v1];

global.ani_miles_trick_front_v0 = new animation(sprMilesTrickFront0, [2, 2, 2, 2, 4], -1);
global.ani_miles_trick_front_v1 = new animation(sprMilesTrickFront1, [2, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3], 4);
global.ani_miles_trick_front_v2 = new animation(sprMilesTrickFront2, 3, 1);
global.ani_miles_trick_front = [global.ani_miles_trick_front_v0, global.ani_miles_trick_front_v1, global.ani_miles_trick_front_v2];

global.ani_miles_trick_back_v0 = new animation(sprMilesTrickBack0, [2, 2, 2, 4], -1);
global.ani_miles_trick_back_v1 = new animation(sprMilesTrickBack1, [2, 2, 2, 3, 3, 3, 3], 3);
global.ani_miles_trick_back_v2 = new animation(sprMilesTrickBack2, [4, 4, 4, 4, 3, 3, 3, 3, 3, 3], 7);
global.ani_miles_trick_back = [global.ani_miles_trick_back_v0, global.ani_miles_trick_back_v1, global.ani_miles_trick_back_v2];

global.ani_miles_spring_v0 = new animation(sprMilesSpring0, 2);
global.ani_miles_spring_v1 = new animation(sprMilesSpring1, [2, 3, 3, 4, 4, 4], -1);
global.ani_miles_spring_v2 = new animation(sprMilesSpring2, 3, 1);
global.ani_miles_spring = [global.ani_miles_spring_v0, global.ani_miles_spring_v1, global.ani_miles_spring_v2];

global.ani_miles_spring_twirl_v0 = new animation(sprMilesSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

global.ani_miles_flight_v0 = new animation(sprMilesFlight, 2);
global.ani_miles_flight_tired_v0 = new animation(sprMilesFlightTired, 2, 2);
global.ani_miles_flight_cancel_v0 = new animation(sprMilesFlightCancel, 3, 2);
global.ani_miles_flight_turn_v0 = new animation(sprMilesFlightTurn, 1, -1);

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

global.ani_knuckles_hurt_v0 = new animation(sprKnucklesHurt0, [3, 8, 8, 8, 8], -1);
global.ani_knuckles_hurt_v1 = new animation(sprKnucklesHurt1, 5, -1);
global.ani_knuckles_hurt = [global.ani_knuckles_hurt_v0, global.ani_knuckles_hurt_v1];

global.ani_knuckles_dead_v0 = new animation(sprKnucklesDead, [3, 3, 12, 2, 3, 3], 4);

global.ani_knuckles_trick_up_v0 = new animation(sprKnucklesTrickUp0, [1, 2, 1], -1);
global.ani_knuckles_trick_up_v1 = new animation(sprKnucklesTrickUp1, [4, 4, 8, 8, 8], -1);
global.ani_knuckles_trick_up_v2 = new animation(sprKnucklesTrickUp2, [7, 6, 3, 3, 3], 2);
global.ani_knuckles_trick_up = [global.ani_knuckles_trick_up_v0, global.ani_knuckles_trick_up_v1, global.ani_knuckles_trick_up_v2];

global.ani_knuckles_trick_down_v0 = new animation(sprKnucklesTrickDown0, [2, 3, 2, 2], -1);
global.ani_knuckles_trick_down_v1 = new animation(sprKnucklesTrickDown1, 2);
global.ani_knuckles_trick_down_v2 = new animation(sprKnucklesTrickDown2, [1, 1, 1, 1, 4, 2, 2], -1);
global.ani_knuckles_trick_down = [global.ani_knuckles_trick_down_v0, global.ani_knuckles_trick_down_v1, global.ani_knuckles_trick_down_v2];

global.ani_knuckles_trick_front_v0 = new animation(sprKnucklesTrickFront0, [2, 2, 2, 2, 4], -1);
global.ani_knuckles_trick_front_v1 = new animation(sprKnucklesTrickFront1, 2, 3);
global.ani_knuckles_trick_front_v2 = new animation(sprKnucklesTrickFront2, 2, -1);
global.ani_knuckles_trick_front = [global.ani_knuckles_trick_front_v0, global.ani_knuckles_trick_front_v1, global.ani_knuckles_trick_front_v2];

global.ani_knuckles_trick_back_v0 = new animation(sprKnucklesTrickBack0, [2, 2, 4], -1);
global.ani_knuckles_trick_back_v1 = new animation(sprKnucklesTrickBack1, [2, 2, 3, 3], 2);
global.ani_knuckles_trick_back = [global.ani_knuckles_trick_back_v0, global.ani_knuckles_trick_back_v1];

global.ani_knuckles_spring_v0 = new animation(sprKnucklesSpring0, 3, 1);
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

global.ani_amy_hurt_v0 = new animation(sprAmyHurt0, [3, 8, 8, 8], -1);
global.ani_amy_hurt_v1 = new animation(sprAmyHurt1, 5, -1);
global.ani_amy_hurt = [global.ani_amy_hurt_v0, global.ani_amy_hurt_v1];

global.ani_amy_dead_v0 = new animation(sprAmyDead, [6, 12, 2, 3, 3], 3);

global.ani_amy_trick_up_v0 = new animation(sprAmyTrickUp0, [3, 6], -1);
global.ani_amy_trick_up_v1 = new animation(sprAmyTrickUp1, [2, 1, 1, 3, 3, 3], 3);
global.ani_amy_trick_up_v2 = new animation(sprAmyTrickUp2, [2, 1, 1, 3, 3, 3], 3);
global.ani_amy_trick_up = [global.ani_amy_trick_up_v0, global.ani_amy_trick_up_v1, global.ani_amy_trick_up_v2];

global.ani_amy_trick_down_v0 = new animation(sprAmyTrickDown0, [2, 2, 4, 2], -1);
global.ani_amy_trick_down_v1 = new animation(sprAmyTrickDown1, 2);
global.ani_amy_trick_down_v2 = new animation(sprAmyTrickDown2, [2, 2, 2, 2, 3, 3, 3], 4);
global.ani_amy_trick_down = [global.ani_amy_trick_down_v0, global.ani_amy_trick_down_v1, global.ani_amy_trick_down_v2];

global.ani_amy_trick_front_v0 = new animation(sprAmyTrickFront0, [1, 2, 3, 1], -1);
global.ani_amy_trick_front_v1 = new animation(sprAmyTrickFront1, 2);
global.ani_amy_trick_front = [global.ani_amy_trick_front_v0, global.ani_amy_trick_front_v1];

global.ani_amy_trick_back_v0 = new animation(sprAmyTrickBack0, [1, 2, 2, 3], -1);
global.ani_amy_trick_back_v1 = new animation(sprAmyTrickBack1, [2, 2, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3], 14);
global.ani_amy_trick_back = [global.ani_amy_trick_back_v0, global.ani_amy_trick_back_v1];

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

global.ani_cream_hurt_v0 = new animation(sprCreamHurt0, [3, 8, 8, 8, 8], -1);
global.ani_cream_hurt_v1 = new animation(sprCreamHurt1, 5, -1);
global.ani_cream_hurt = [global.ani_cream_hurt_v0, global.ani_cream_hurt_v1];

global.ani_cream_dead_v0 = new animation(sprCreamDead, [6, 12, 2, 3, 3], 3);

global.ani_cream_trick_up_v0 = new animation(sprCreamTrickUp0, [1, 4, 4, 4, 2], -1);
global.ani_cream_trick_up_v1 = new animation(sprCreamTrickUp1, [2, 2, 2, 3, 3, 3], 3);
global.ani_cream_trick_up_v2 = new animation(sprCreamTrickUp2, [2, 2, 2, 2, 2, 3, 3, 3], 5);
global.ani_cream_trick_up = [global.ani_cream_trick_up_v0, global.ani_cream_trick_up_v1, global.ani_cream_trick_up_v2];

global.ani_cream_trick_down_v0 = new animation(sprCreamTrickDown0, [2, 2, 4, 6, 2], -1);
global.ani_cream_trick_down_v1 = new animation(sprCreamTrickDown1, [2, 2, 2, 3, 3, 3], 3);
global.ani_cream_trick_down = [global.ani_cream_trick_down_v0, global.ani_cream_trick_down_v1];

global.ani_cream_trick_front_v0 = new animation(sprCreamTrickFront0, [2, 2, 4, 1], -1);
global.ani_cream_trick_front_v1 = new animation(sprCreamTrickFront1, 2);
global.ani_cream_trick_front = [global.ani_cream_trick_front_v0, global.ani_cream_trick_front_v1];

global.ani_cream_trick_back_v0 = new animation(sprCreamTrickBack0, [2, 2, 4, 6, 2], -1);
global.ani_cream_trick_back_v1 = new animation(sprCreamTrickBack1, [2, 2, 3, 3, 3], 2);
global.ani_cream_trick_back_v2 = new animation(sprCreamTrickBack2, [2, 2, 2, 3, 3, 3], 3);
global.ani_cream_trick_back = [global.ani_cream_trick_back_v0, global.ani_cream_trick_back_v1, global.ani_cream_trick_back_v2];

global.ani_cream_spring_v0 = new animation(sprCreamSpring0, 3, 1);
global.ani_cream_spring_v1 = new animation(sprCreamSpring1, [2, 3, 3, 4, 4, 4], -1);
global.ani_cream_spring_v2 = new animation(sprCreamSpring2, 3);
global.ani_cream_spring = [global.ani_cream_spring_v0, global.ani_cream_spring_v1, global.ani_cream_spring_v2];

global.ani_cream_spring_twirl_v0 = new animation(sprCreamSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 3, 3, 3], 12);

#endregion