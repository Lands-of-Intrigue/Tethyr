//::///////////////////////////////////////////////
//:: Aura of Fear On Enter
//:: NW_S1_AuraFearA.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Upon entering the aura of the creature the player
    must make a will save or be struck with fear because
    of the creatures presence.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 25, 2001
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    //Declare major variables
    object oTarget = GetEnteringObject();

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



    int nHD = GetHitDice(GetAreaOfEffectCreator());
    int nDC = 10 + GetHitDice(GetAreaOfEffectCreator())/3;
    int nDuration = GetScaledDuration(nHD, oTarget);
    float fDuration = IntToFloat(nDuration);
    if(GetIsEnemy(oTarget, GetAreaOfEffectCreator()))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELLABILITY_AURA_FEAR));

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
}
