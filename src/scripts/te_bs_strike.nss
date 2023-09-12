//::///////////////////////////////////////////////
//:: Sword Style
//:: TE_bs_sword.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: David Novotny
//:: Modified On: May 29, 2016
//:://////////////////////////////////////////////
#include "te_functions"
#include "x0_i0_spells"

void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nCL1 = GetLevelByClass(53, oPC);
    int nCL2 = GetLevelByClass(55, oPC);
    int nCL = (nCL1 + nCL2);
    int nSTR = GetAbilityModifier(ABILITY_STRENGTH, oPC);

    int nLevel = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());

    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eDamage1 = EffectDamageIncrease(d4(4),DAMAGE_TYPE_MAGICAL);
    effect eAttBonus = EffectAttackIncrease(4,ATTACK_BONUS_ONHAND);
    effect eLink = EffectLinkEffects(eDamage1, eDur);
    eLink = EffectLinkEffects(eLink,eAttBonus);
    eLink = SupernaturalEffect(eLink);

    // * Do not allow this to stack
    RemoveEffectsFromSpell(oTarget, GetSpellId());

    //Apply Link and VFX effects to the target
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, RoundsToSeconds(1));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
}
