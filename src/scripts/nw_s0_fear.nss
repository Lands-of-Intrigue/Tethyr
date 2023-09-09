//::///////////////////////////////////////////////
//:: [Fear]
//:: [NW_S0_Fear.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Causes an area of fear that reduces Will Saves
//:: and applies the frightened effect.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 23, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: Update Pass By: Preston W, On: July 30, 2001

#include "x0_i0_spells"
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
A panicked character must flee. They take a -2 penalty to all saving throws, skill checks, and ability checks.
Can use any special abilities to flee and must use any such means.
*/

    //Declare major variables
    int nCasterLevel = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nMetaMagic = GetMetaMagicFeat();
    float fDuration = RoundsToSeconds(nCasterLevel);
    int nDamage;
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);

    //Panick state:
    effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
    effect ePanick = EffectMissChance(75, MISS_CHANCE_TYPE_NORMAL);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    //Shaken State:
    effect eSave = EffectSavingThrowDecrease(SAVING_THROW_WILL, 2, SAVING_THROW_TYPE_MIND_SPELLS);
    effect eDamagePenalty = EffectDamageDecrease(2);
    effect eAttackPenalty = EffectAttackDecrease(2);
    effect eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, 2);

    float fDelay;
    //Link the fear and mind effects
    effect eLink = EffectLinkEffects(eVis, ePanick);
 eLink = EffectLinkEffects(eLink, eMind);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eLink2 = EffectLinkEffects(eSave, eDur);
    eLink2 = EffectLinkEffects(eLink2, eDamagePenalty);
    eLink2 = EffectLinkEffects(eLink2, eAttackPenalty);
    eLink2 = EffectLinkEffects(eLink2, eSkill);


    object oTarget;

    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND) {
        fDuration = fDuration * 2.0;    //Duration is +100%
    }

    //Apply Impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    //Get first target in the spell cone
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation(), TRUE);

    while (GetIsObjectValid(oTarget)) {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            fDelay = GetRandomDelay();
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FEAR));

            if(GetLevelByClass(CLASS_TYPE_PALADIN,oTarget) >= 1)
            {

            }
            else
            {

                //Make SR Check
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    //Make a will save
                    if (!MySavingThrow(SAVING_THROW_WILL, oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()), SAVING_THROW_TYPE_FEAR, OBJECT_SELF, fDelay))
                    {
                        //Apply linked effects and VFX impact
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, fDuration);
                    }
                    else
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, RoundsToSeconds(1));
                    }
                }
            }
        }

        //Get next target in the spell cone
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation(), TRUE);
    }
}
