function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        //Add your own verbs here!
        UP,
        DOWN,
        LEFT,
        RIGHT,
        JUMP,
        AUX,
        SWAP,
        EXTRA,
        TAG,
        ALT,
        START,
        SELECT,
        CONFIRM,
        CANCEL,
        HIDE
    }
    
    enum INPUT_CLUSTER
    {
        //Add your own clusters here!
        //Clusters are used for two-dimensional checkers (InputDirection() etc.)
        NAVIGATION,
    }
    
    InputDefineVerb(INPUT_VERB.UP,      "up",          vk_up,       [-gp_axislv, gp_padu]);
    InputDefineVerb(INPUT_VERB.DOWN,    "down",        vk_down,     [ gp_axislv, gp_padd]);
    InputDefineVerb(INPUT_VERB.LEFT,    "left",        vk_left,     [-gp_axislh, gp_padl]);
    InputDefineVerb(INPUT_VERB.RIGHT,   "right",       vk_right,    [ gp_axislh, gp_padr]);
    InputDefineVerb(INPUT_VERB.JUMP,    "jump",        "A",           gp_face1);
    InputDefineVerb(INPUT_VERB.AUX,     "aux",         "S",           gp_face3);
    InputDefineVerb(INPUT_VERB.SWAP,    "swap",        "W",           gp_face4);
    InputDefineVerb(INPUT_VERB.EXTRA,   "extra",       "Q",           gp_face2);
    InputDefineVerb(INPUT_VERB.TAG,     "tag",         "D",           gp_shoulderr);
    InputDefineVerb(INPUT_VERB.ALT,     "alt",         vk_lshift,     gp_shoulderl);
    InputDefineVerb(INPUT_VERB.START,   "start",       vk_enter,      gp_start);
    InputDefineVerb(INPUT_VERB.HIDE,    "hide",        "W",           gp_face4);
    
    if (INPUT_ON_SWITCH)
    {
        //Flip A/B over on Switch
        InputDefineVerb(INPUT_VERB.CONFIRM, "confirm", undefined, gp_face2); // !!
        InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",  undefined, gp_face1); // !!
    }
    else
    {
        InputDefineVerb(INPUT_VERB.CONFIRM, "confirm", "A", gp_face1);
        InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",  "S", gp_face2);
    }
    
    if (INPUT_ON_PS5)
    {
        //`gp_select` is inaccessible on PS5
        InputDefineVerb(INPUT_VERB.SELECT, "select", vk_rshift, gp_touchpadbutton);
    }
    else
    {
        InputDefineVerb(INPUT_VERB.SELECT, "select", vk_rshift, gp_select);
    }
    
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}
