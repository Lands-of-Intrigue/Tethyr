//::///////////////////////////////////////////////
//:: Scorching Ray
//:: te_sp_scorch
//:: Copyright (c) 2018 www.tethyrknighs.com
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

    int nDamage;
    int nRay, i;
    int nTouch = TouchAttackRanged(oTarget,TRUE);

    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M );
    effect eRay;

    if(nCasterLevel < 7)
    {

        if (nTouch > 0)
        {
            if (nTouch == 2)
            {
              nDamage = d6(8);
            }
            else
            {
                nDamage = d6(4);
            }

            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                if (nTouch == 2)
                {
                    nDamage = 6 * 8;//Damage is at max
                }
                else
                {
                    nDamage = 6 * 4;//Damage is at max
                }
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
            }

            eRay = EffectBeam(VFX_BEAM_FIRE, OBJECT_SELF, BODY_NODE_HAND,FALSE);
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 992));
                if (!MyResistSpell(OBJECT_SELF, oTarget)|| GetTag(oTarget) == "te_gol_iron")
                {
                    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    //Apply the VFX impact and effects
                    //DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                }
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }
        else
        {
            eRay = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND,TRUE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }
    }
    else if (nCasterLevel >= 7 && nCasterLevel < 11)
    {
        if (nTouch > 0)
        {
            if (nTouch == 2)
            {
              nDamage = d6(8);
            }
            else
            {
                nDamage = d6(4);
            }

            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                if (nTouch == 2)
                {
                    nDamage = 6 * 8;//Damage is at max
                }
                else
                {
                    nDamage = 6 * 4;//Damage is at max
                }
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
            }

            eRay = EffectBeam(VFX_BEAM_FIRE, OBJECT_SELF, BODY_NODE_HAND,FALSE);
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 992));
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    //Apply the VFX impact and effects
                    //DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                }
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }
        else
        {
            eRay = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND,TRUE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }

        nTouch = TouchAttackRanged(oTarget,TRUE);
        if (nTouch > 0)
        {
            if (nTouch == 2)
            {
              nDamage = d6(8);
            }
            else
            {
                nDamage = d6(4);
            }

            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                if (nTouch == 2)
                {
                    nDamage = 6 * 8;//Damage is at max
                }
                else
                {
                    nDamage = 6 * 4;//Damage is at max
                }
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
            }

            eRay = EffectBeam(VFX_BEAM_FIRE, OBJECT_SELF, BODY_NODE_HAND,FALSE);
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 992));
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    //Apply the VFX impact and effects
                    //DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                }
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }
        else
        {
            eRay = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND,TRUE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }
    }
    else
    {
        if (nTouch > 0)
        {
            if (nTouch == 2)
            {
              nDamage = d6(8);
            }
            else
            {
                nDamage = d6(4);
            }

            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                if (nTouch == 2)
                {
                    nDamage = 6 * 8;//Damage is at max
                }
                else
                {
                    nDamage = 6 * 4;//Damage is at max
                }
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
            }

            eRay = EffectBeam(VFX_BEAM_FIRE, OBJECT_SELF, BODY_NODE_HAND,FALSE);
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 992));
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    //Apply the VFX impact and effects
                    //DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                }
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }
        else
        {
            eRay = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND,TRUE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }

        nTouch = TouchAttackRanged(oTarget,TRUE);
        if (nTouch > 0)
        {
            if (nTouch == 2)
            {
              nDamage = d6(8);
            }
            else
            {
                nDamage = d6(4);
            }

            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                if (nTouch == 2)
                {
                    nDamage = 6 * 8;//Damage is at max
                }
                else
                {
                    nDamage = 6 * 4;//Damage is at max
                }
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
            }

            eRay = EffectBeam(VFX_BEAM_FIRE, OBJECT_SELF, BODY_NODE_HAND,FALSE);
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 992));
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    //Apply the VFX impact and effects
                    //DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                }
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }
        else
        {
            eRay = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND,TRUE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }

        nTouch = TouchAttackRanged(oTarget,TRUE);
        if (nTouch > 0)
        {
            if (nTouch == 2)
            {
              nDamage = d6(8);
            }
            else
            {
                nDamage = d6(4);
            }

            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                if (nTouch == 2)
                {
                    nDamage = 6 * 8;//Damage is at max
                }
                else
                {
                    nDamage = 6 * 4;//Damage is at max
                }
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
            }

            eRay = EffectBeam(VFX_BEAM_FIRE, OBJECT_SELF, BODY_NODE_HAND,FALSE);
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 992));
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    //Apply the VFX impact and effects
                    //DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                }
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }
        else
        {
            eRay = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND,TRUE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
        }
    }


}
