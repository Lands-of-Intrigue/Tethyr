//::///////////////////////////////////////////////
//:: Heroism
//:: te_sp_heroism.nss
//:://////////////////////////////////////////////
/*
    Spell summons a mount.
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Function(D20), LLC
//:: Created By: David Novotny
//:: Created On: April 12, 2017
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nDuration = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nMetaMagic = GetMetaMagicFeat();
    //effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
    effect eAC = EffectAttackIncrease(4, ATTACK_BONUS_MISC);
    //Change the effects so that it only applies when the target is evil
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL,4);
    effect eImmune = EffectSkillIncrease(SKILL_ALL_SKILLS,4);
    effect eDur = EffectVisualEffect(150);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int iTHP = nDuration;

    if (iTHP >= 20)
    {
        iTHP = 20;
    }

    effect eTHP = EffectTemporaryHitpoints(iTHP);


    effect eLink = EffectLinkEffects(eImmune, eSave);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eTHP);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;    //Duration is +100%
    }

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PROTECTION_FROM_GOOD, FALSE));

    //Apply the VFX impact and effects
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}

