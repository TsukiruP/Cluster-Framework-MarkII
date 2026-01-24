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

/// @function room_get_scene([index])
/// @param {Asset.GMRoom} [index] Index of the room to check (optional, defaults to the current room).
/// @returns {Struct.scene}
function room_get_scene(index = room)
{
    switch (index)
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

/// @function transition_create(index, [override])
/// @description Creates a new transition.
/// @param {Asset.GMRoom} index Index of the room to go to.
/// @param {Enum.TRANSITION} [override] Transition to override with (optional, defaults to undefined).
/// @returns {Id.Instance}
function transition_create(index, override = undefined)
{
    var transition, inst;
    var room_scene = room_get_scene(index);
    var room_transition = (is_undefined(override) ? room_scene.transition : override);
    switch (room_transition)
    {
        case TRANSITION.TITLE_CARD:
        {
            transition = objTitleCard;
            break;
        }
        case TRANSITION.TRY_AGAIN:
        {
            transition = objTryAgain;
            break;
        }
        default:
        {
            transition = objFade;
        }
    }
    
    inst = instance_create_depth(0, 0, 0, transition);
    with (inst)
    {
        target = index;
        target_scene = room_scene;
    }
    
    with (ctrlMusic)
    {
        var room_music = room_get_scene(room).music;
        if (room_music != room_scene.music) audio_clear_music();
    }
    
    return inst;
}

/// @function stage_start()
/// @description Starts the stage.
function stage_start()
{
    with (ctrlStage) time_enabled = true;
    with (objPlayer) input_enabled = true;
    with (objHUD) hud_active = true;
}