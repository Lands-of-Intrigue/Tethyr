//::///////////////////////////////////////////////
//:: DMFI - OnClientEnter event handler
//:: dmfi_onclienter
//:://////////////////////////////////////////////
/*
  Event handler for the module-level OnClientEnter event. Initializes DMFI system.
*/
//:://////////////////////////////////////////////
//:: 2008.08.02 tsunami282 - created.

#include "dmfi_init_inc"

////////////////////////////////////////////////////////////////////////
void main()
{
    object oUser = GetEnteringObject();

    effect eGhost = SupernaturalEffect( EffectCutsceneGhost());
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eGhost,oUser);

    if(GetIsDM(oUser) == TRUE)
    {
        SetLocalInt(oUser,"cstrlvl",20);
    }

    // do any other module OnClientEnter work here
    ExecuteScript("x3_mod_def_enter", OBJECT_SELF);

    // initialize DMFI
    dmfiInitialize(oUser);
}
