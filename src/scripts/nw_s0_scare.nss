//::///////////////////////////////////////////////
//:: [Scare]
//:: [NW_S0_Scare.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Will save or the target is scared for 1d4 rounds.
//:: NOTE THIS SPELL IS EQUAL TO **CAUSE FEAR** NOT SCARE.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 30, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: Modified March 2003 to give -2 attack and damage penalties

#include "x0_i0_spells"
#include "te_functions"
#include "x2_inc_spellhook"

void main()
{

    /*
      Spellcast Hook Code
      Added 2003-06-20 by Georg
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

    if (!X2PreSpellCastCode()) {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook
/*
A shaken character takes a -2 penalty to all attack rolls, saving throws, skill checks, and ability checks.
*/

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = d4();

    //Do metamagic checks
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }

    effect ePanick = EffectMissChance(50, MISS_CHANCE_TYPE_NORMAL);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);

    effect eSave = EffectSavingThrowDecrease(SAVING_THROW_WILL, 2, SAVING_THROW_TYPE_MIND_SPELLS);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDamagePenalty = EffectDamageDecrease(2);
    effect eAttackPenalty = EffectAttackDecrease(2);
    effect eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, 2);

    //Effect Panicked
    effect eLink = EffectLinkEffects(eMind, ePanick);

    //Effect Shaken
    effect eLink2 = EffectLinkEffects(eSave, eDur);
    eLink2 = EffectLinkEffects(eLink2, eDamagePenalty);
    eLink2 = EffectLinkEffects(eLink2, eAttackPenalty);
    eLink2 = EffectLinkEffects(eLink2, eSkill);

    //Check the Hit Dice of the creature
    if ((GetHitDice(oTarget) < 6) && GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    {
        // * added rep check April 2003
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) == TRUE)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SCARE));

            //Make SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Make Will save versus fear
                if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()), SAVING_THROW_TYPE_FEAR))
                {
                    //Apply linked effects and VFX impact
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, RoundsToSeconds(nDuration));
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, RoundsToSeconds(1));
                }
            }
        }
    }
}
