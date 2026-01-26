/// @function scene(transition, [music])
/// @description Creates a new scene.
/// @param {Enum.TRANSITION} transition Transition of the scene.
/// @param {Asset.GMSound} [music] Music of the scene (optional, defaults to undefined).
function scene(_transition, _music = undefined) constructor
{
    transition = _transition;
    music = _music;
}

/// @function stage([music], [zone], [act])
/// @description Creates a new stage scene.
/// @param {Asset.GMSound} [music] Music of the stage (optional, defaults to undefined).
/// @param {String} [zone] Zone of the stage (optional, defaults to "").
/// @param {Real} [act] Act of the stage (optional, defaults to 0).
function stage(_music = undefined, _zone = "", _act = 0) : scene(TRANSITION.TITLE_CARD, _music) constructor
{
    zone = _zone;
    act = _act;
}

/// @function room_get_scene([rm])
/// @param {Asset.GMRoom} [rm] Room to check (optional, defaults to the current room).
/// @returns {Struct.scene}
function room_get_scene(rm = room)
{
    switch (rm)
    {
        case rmTest:
        {
            return global.stg_test;
        }
        case rmTestNew:
        {
            return global.stg_test_new;
        }
        default:
        {
            return global.scn_default;
        }
    }
}

/// @function transition_create(rm, [override])
/// @description Creates a new transition.
/// @param {Asset.GMRoom} rm Room to go to.
/// @param {Enum.TRANSITION} [override] Transition to override with (optional, defaults to undefined).
/// @returns {Id.Instance}
function transition_create(rm, override = undefined)
{
    var transition;
    var room_scene = room_get_scene(rm);
    var room_transition = (override == undefined ? room_scene.transition : override);
    
    transition = instance_create_depth(0, 0, 0, objTransition);
    with (transition)
    {
        index = room_transition;
        target = rm;
        target_scene = room_scene;
    }
    
    with (ctrlMusic)
    {
        var room_music = room_scene.music;
        if (room_music == undefined or not audio_is_playing(room_music)) audio_clear_music();
    }
    
    return transition;
}

/// @function stage_start()
/// @description Starts the stage.
function stage_start()
{
    with (ctrlStage) time_enabled = true;
    with (objPlayer) input_enabled = true;
    with (objHUD) hud_active = true;
}