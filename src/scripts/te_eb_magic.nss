//:://////////////////////////////////////////////////
//:: Tethyr's Warlock Eldritch Blast Evocation
//:: Magic edition
//:: TE_EB_Magic
//:: Copyright (c) 2015 Function(D20)
//:///////////////////////////////////////////////////

/*
   Warlock uses eldritch blast feat to attack player
   Rolls ranged touch attack to see if hit.
   Attack does 1d6 damage per character level
*/
//:///////////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: October 17, 2015
//:///////////////////////////////////////////////////
#include "loi_functions"
#include "te_afflic_func"
#include "nw_i0_spells"
#include "x2_i0_spells"

void main()
{
    //Declare Major Variables
    object oTarget = GetSpellTargetObject();
    object oMyWeapon = IPGetTargetedOrEquippedMeleeWeapon();

    object oPC = OBJECT_SELF;
    int nHD = GetHitDice(oPC);
    int CLASS_TYPE_WAR = 47;
    int CL = GetLevelByClass(CLASS_TYPE_WAR, oPC);
    float fDuration = 1.0f;
    int SR = GetSpellResistance(oTarget);  //Spell Resistance
    int SP;                                //Spell Penetration value
    int SS;                                //Spell Success 1=yes 0=no
    float xDur = RoundsToSeconds(CL);

    //Effect Options

    effect eVis = EffectVisualEffect(VFX_IMP_DESTRUCTION);                    //Thing that appears on target when hit.
    effect xEff = EffectSpellResistanceDecrease(2);                           //Secondary effect for flavor.
    effect eBeamF = EffectBeam(VFX_BEAM_MIND,oPC, BODY_NODE_HAND, TRUE);
    effect eBeamS = EffectBeam(VFX_BEAM_MIND,oPC, BODY_NODE_HAND, FALSE);   //Beam Effect. Edit top beam effect as well.
    effect eFail1 = EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE);         //First effect if resisted with SR.
    effect eFail2 = EffectVisualEffect(VFX_DUR_GLOBE_MINOR);                  //Second effect if resisted with SR.
    //End Effect Options

    if (GetSpellTargetObject() != OBJECT_SELF)
    {
        //Roll for Touch Attack Success
        int nTouch = TouchAttackRanged(oTarget);
        int nDamage = (d6(CL/2) * nTouch);
        effect eDam;
        eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);

        if (nTouch >= 1)  //If successful...
        {
            SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_NEGATIVE_ENERGY_RAY, TRUE)); //Signal to the target it is being attacked.

            //If the target's spell resistance is zero, don't do anything.
            if (SR <= 0)
            {
                int SS = 1;
            }
            //If target's spell resistance is greater than zero, check for spell penetration feats and calculate whether they succeed or fail.
            else
            {
                //If they have all spell penetration feats, their spell penetration is +6
                if (GetHasFeat(FEAT_EPIC_SPELL_PENETRATION, oPC) && GetHasFeat(FEAT_GREATER_SPELL_PENETRATION, oPC)  && GetHasFeat(FEAT_SPELL_PENETRATION, oPC))
                {
                    int SP = 6;
                }
                //If they have all spell penetration feats, their spell penetration is +4
                else if (GetHasFeat(FEAT_GREATER_SPELL_PENETRATION, oPC) && GetHasFeat(FEAT_SPELL_PENETRATION, oPC))
                {
                    int SP = 4;
                }
                //If they have all spell penetration feats, their spell penetration is +2
                else if (GetHasFeat(FEAT_SPELL_PENETRATION, oPC))
                {
                    int SP = 2;
                }
                //If they have no spell penetration feats, their spell penetration modifier is 0.
                else
                {
                    int SP = 0;
                }

                if(GetHasFeat(1300,OBJECT_SELF) == TRUE)
                {
                    SP = (SP + 2);
                }

                //Calculate their spell penetration roll versus the creatures spell resistance. Spell penetration is 1d20 + Caster Level + Spell Penetration feat mods.
                if (SR < (SP + d20(1) + CL))
                {
                    int SS = 1;
                }
                if (SR >= (SP + d20(1) + CL))
                {
                    int SS = 0;
                }
            }

            //If the spell penetration was successful || the object or creature did not have spell resistance, then we fire our blast.
            if (SS = 1)
            {
                //Applies all damages and VFX.
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamS, oTarget, fDuration);
                DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, xEff, oTarget, xDur));
                AdjustReputation(oPC, oTarget, 0);
            }
            //If our penetration was unsuccessful, or any other weird case, the beam still hits - but a vis effect displaying the failure and a globe-effect displays as though it were blocked by a hidden force.
            else
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamS, oTarget, fDuration);
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFail1, oTarget));
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFail2, oTarget));
            }

        }
        //If the ranged touch attack failed, we cause beam to go off into the distance, harming nothing.
        else
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeamF, oTarget, fDuration);
        }
    }
    else
    {
        if(GetObjectType(GetSpellTargetObject()) == OBJECT_TYPE_ITEM)
        {
            oMyWeapon = GetSpellTargetObject();
        }

        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetItemPossessor(oMyWeapon));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE), GetItemPossessor(oMyWeapon), TurnsToSeconds(CL));
        IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonus(1), TurnsToSeconds(CL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        IPSafeAddItemProperty(oMyWeapon,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_2d6), TurnsToSeconds(CL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        IPSafeAddItemProperty(oMyWeapon,ItemPropertyVisualEffect(ITEM_VISUAL_SONIC), TurnsToSeconds(CL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
    }
}
