////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_webhb:
// Cannon Web Ammo HB script
////////////////////////////
// Added in 1.1
#include "X0_I0_SPELLS"


void main()
{

    //Declare major variables
    effect eWeb = EffectEntangle();
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
    object oTarget;
    //Spell resistance check
    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) &&(GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )
        {
        //Make a Fortitude Save to avoid the effects of the entangle.
        if(!/*Reflex Save*/ MySavingThrow(SAVING_THROW_REFLEX, oTarget, GetSpellSaveDC()))
        {
            //Entangle effect and Web VFX impact
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWeb, oTarget, RoundsToSeconds(1));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(1));
        }
        }
        oTarget = GetNextInPersistentObject();
    }
}
