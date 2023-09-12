//::///////////////////////////////////////////////
//:: Negative Energy Ray
//:: NW_S0_NegRay
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Fires a bolt of negative energy at the target
    doing 1d6 damage.  Does an additional 1d6
    damage for 2 levels after level 1 (3,5,7,9) to
    a maximum of 5d6 at level 9.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 13, 2001
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
    int nCasterLevel = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nMetaMagic = GetMetaMagicFeat();
    int nTouch = TouchAttackRanged(oTarget,TRUE);

    if(nCasterLevel > 9)
    {
        nCasterLevel = 9;
    }
    nCasterLevel = (nCasterLevel + 1) / 2;
    if (nTouch == 2)
    {
         nCasterLevel = nCasterLevel * 2;
    }
    int nDamage = d6(nCasterLevel);

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 6 * nCasterLevel;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
    }
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eRay;


    if (nTouch > 0)
    {
        if( GetIsUndead(oTarget) == TRUE)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NEGATIVE_ENERGY_RAY, FALSE));
            eRay = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND);
            effect eHeal = EffectHeal(nDamage);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        }
        else
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NEGATIVE_ENERGY_RAY));
                eRay = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND);
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    //Make a saving throw check
                    if(/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()), SAVING_THROW_TYPE_NEGATIVE))
                    {
                        nDamage = nDamage/2;
                    }
                    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                    //Apply the VFX impact and effects
                    //DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);

                }
            }
        }
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
    }
    else
    {
        eRay = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND,TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
    }
}

