//::///////////////////////////////////////////////
//:: Ray of EnFeeblement
//:: [NW_S0_rayEnfeeb.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Target must make a Fort save or take ability
//:: damage to Strength equaling 1d6 +1 per 2 levels,
//:: to a maximum of +5.  Duration of 1 round per
//:: caster level.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 2, 2001
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "te_functions"
#include "te_afflic_func"
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
    int nBonus = nDuration / 2;
    int nTouch = TouchAttackRanged(oTarget,TRUE);
    //Limit bonus ability damage
    if (nBonus > 5)
    {
        nBonus = 5;
    }
    if(nBonus == 0)
    {
        nBonus = 1;
    }
    int nLoss = d6() + nBonus;
    if (nTouch == 2)
    {
         nLoss = d6(2) + nBonus*2;
    }
    int nMetaMagic = GetMetaMagicFeat();
    effect eFeeb;
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eRay;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    if (nTouch > 0)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAY_OF_ENFEEBLEMENT));
            eRay = EffectBeam(VFX_BEAM_ODD, OBJECT_SELF, BODY_NODE_HAND);
            //Make SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                if(!GetIsUndead(oTarget))
                {
                    //Enter Metamagic conditions
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nLoss = 6 + nBonus;
                        if (nTouch == 2)
                        {
                            nLoss = 12 + nBonus*2;
                        }
                    }
                    if (nMetaMagic == METAMAGIC_EMPOWER)
                    {
                        nLoss = nLoss + (nLoss/2);
                    }
                    if (nMetaMagic == METAMAGIC_EXTEND)
                    {
                            nDuration = nDuration * 2;
                    }
                    //Set ability damage effect
                    eFeeb = EffectAbilityDecrease(ABILITY_STRENGTH, nLoss);
                    effect eLink = EffectLinkEffects(eFeeb, eDur);
                    //Apply the ability damage effect and VFX impact
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget);
                }
            }
        }
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.0);
    }
    else
    {
        eRay = EffectBeam(VFX_BEAM_ODD, OBJECT_SELF, BODY_NODE_HAND,TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
    }
}
