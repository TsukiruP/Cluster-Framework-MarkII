/// @description CPU

/// @description Resets the CPU.
player_refresh_cpu = function()
{
    var leader = ctrlStage.stage_players[0];
    x = leader.x div 1;
    y = leader.y div 1;
    xprevious = x;
    yprevious = y;
    gravity_direction = leader.gravity_direction;
    image_xscale = leader.image_xscale;
    image_angle = gravity_direction;
    boost_mode = leader.boost_mode;
    x_speed = leader.x_speed;
    y_speed = leader.y_speed;
    collision_layer = leader.collision_layer;
    tilemaps[1] = ctrlStage.tilemaps[collision_layer + 1];
    cpu_state = CPU_STATE.FOLLOW;
    player_ground(undefined);
    animation_play(PLAYER_ANIMATION.FALL);
    player_perform(player_is_falling, false);
    player_refresh_physics();
    player_refresh_boost_mode();
};

/// @description Respawns the CPU.
player_respawn_cpu = function()
{
    var can_respawn = (ctrlStage.stage_players[0].state != player_is_dead);
    if (can_respawn)
    {
        recovery_time = RECOVERY_DURATION;
        cpu_respawn_time = 0;
        player_refresh_cpu();
    }
};