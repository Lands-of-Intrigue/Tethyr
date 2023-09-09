//::///////////////////////////////////////////////
//:: ZEP_TORCHSPAWN3.nss
//:://////////////////////////////////////////////
/*
    This function is called on heartbeat and designed to exert minimal
    drag on the system except during module load.  This function is used
    to initialize light-emitting placeables.  Since there is no OnSpawn
    event handler for placeables, the OnHeartbeat handler is used instead.
    As long as the total number of lighting placeables is kept to a reasonable
    number, the CPU impact will be minimal.

    This is used to initialize a light-emitting placeable where ambient light
    is missing on the model.

    The following local variables are used on light-emitting placeables:

    CEP_L_LIGHTCONST: this localstring holds the name of the lighting constant
    used to put a colored light on a lit light-emitting placeable. For example,
    if a torch is supposed to emit a 20 foot diameter yellow light, CEP_L_LIGHTCONST
    should contain "YELLOW_20". The function ColorInit in the zep_inc_main
    library converts this string into a number which can be used by the game
    engine.
    The following color names are available (case-sensitive):
    WHITE, YELLOW, ORANGE, RED, GREEN, BLUE and PURPLE  (note that Green actually
    calls a GREY lighting effect which is green for some inscrutible reason)
    5, 10, 15, 20 are the available radii.  Note that some light colors are
    brighter than others. Consult the CEP Builder's guide for more information.

    Note: the ColorInit function only looks at the first two and last two
    characters of the string so YELLOW_5 could be called by YE_5 and RED_20
    with RE20 but for readability, the user is encouraged to use the full names.
    Note: changing this string only causes the lighting color to change when a
    a cycling light-emitter switches states, a light-emitter is switched on or
    off with zep_torch or when a zep_torchupdate is called on a light-emitter.

    CEP_L_LIGHTINITIALIZED: this localint is 0 if the placeable hasn't been
    initialized yet, 1 if it has. This localint is defined at runtime. NEVER
    CHANGE THIS VARIABLE.

    CEP_L_AMION: this is a localint that holds the present on-off state of the
    placeable. If the light constant was valid, it is set to 1 (=on), else to
    0 (=off). NEVER CHANGE THIS VARIABLE.
*/

#include "zep_inc_main"

void main()
{
    // run once
    if (!GetLocalInt(OBJECT_SELF, "CEP_L_LIGHTINITIALIZED")) {
        SetLocalInt(OBJECT_SELF, "CEP_L_LIGHTINITIALIZED", TRUE);

        // determine light VFX constant
        string lightConst = GetLocalString(OBJECT_SELF, "CEP_L_LIGHTCONST");
        int vfx;
        if (lightConst != "")
            vfx = ColorInit(lightConst);
        if (vfx != VFX_DUR_LIGHT) {
            // apply light VFX
            effect e = SupernaturalEffect(EffectVisualEffect(vfx));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, e, OBJECT_SELF);
            SetLocalInt(OBJECT_SELF, "CEP_L_AMION", TRUE);
        } else {
            DeleteLocalInt(OBJECT_SELF, "CEP_L_AMION");
        }
    }
}

