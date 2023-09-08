////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_weba:
// Cannon Web ammo OnEnter script
////////////////////////////
// Added in v1.1

#include "X0_I0_SPELLS"
#include "siege_include"

void main()
{

    //Declare major variables
    effect eWeb = EffectEntangle();
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
    effect eLink = EffectLinkEffects(eWeb, eVis);
    object oTarget = GetEnteringObject();

    // * the lower the number the faster you go
    int nSlow = 65 - (GetAbilityScore(oTarget, ABILITY_STRENGTH)*2);
    if (nSlow <= 0)
    {
        nSlow = 1;
    }

    if (nSlow > 99)
    {
        nSlow = 99;
    }

    effect eSlow = EffectMovementSpeedDecrease(nSlow);
    if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) && (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) != TRUE))
    {
       //Make a Fortitude Save to avoid the effects of the entangle.
       if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, GetSpellSaveDC()))
       {
            //Entangle effect and Web VFX impact
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1));
       }
       //Slow down the creature within the Web
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, CANNON_WEB_TIME);
   }
}
