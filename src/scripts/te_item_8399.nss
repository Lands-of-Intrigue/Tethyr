//::///////////////////////////////////////////////
//:: Rage 1
//:: NW_S1_Rage1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Str and Con of the target increases
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 13, 2001
//:: Updated On: Jul 08, 2003, Georg
//:://////////////////////////////////////////////

#include "x2_i0_spells"

void main()
{
    object oPC = GetItemActivatedTarget();
    //Declare major variables
    int nDuration = 3;
    int nIncrease = 2;
    effect eDex = EffectAbilityIncrease(ABILITY_CONSTITUTION, nIncrease);
    effect eCon = EffectAbilityIncrease(ABILITY_STRENGTH, nIncrease);
    effect eWill = EffectSavingThrowIncrease(SAVING_THROW_WILL,1);
    effect eAC = EffectACDecrease(nIncrease,AC_DODGE_BONUS);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eCon, eDex);
    eLink = EffectLinkEffects(eLink, eWill);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDur);

    //Make effect extraordinary
    eLink = ExtraordinaryEffect(eLink);
    //effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oPC,RoundsToSeconds(1+nDuration));
}
