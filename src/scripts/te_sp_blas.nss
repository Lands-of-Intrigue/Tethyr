//::///////////////////////////////////////////////
//:: Name te_blasphemy
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spell effects any nonevil creature within the area of effect.
    There is no saving throw against the effects.
    Equal Caster Level: Dazed
    Up to Caster Level -1: Weakened, Dazed
    Up to Caster Level -5: Paralyzed, Weakened, Dazed
    Up to Caster Level -10: Killed, Paralyzed, Weakened, Dazed

    Dazed: Daze for 1 round.
    Weakened: 2d6 STR damage for 2d4 Rounds.
    Paralyzed: Paralyzed and helpless for 1d10 Turns.
    Killed: Instant death for living and undead creatures.
    Automatic dismissal. (Will save)

    Targets with hit dice greater than caster hit dice are not affected.
*/
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: 11-10-2017
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "te_functions"
#include "te_afflic_func"
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

    object oPC = OBJECT_SELF;
    location lLoc = GetLocation(oPC);
    int nCaster = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nTarget;
    int nDiff;
    effect eDaze = EffectDazed();
    effect eSTR;
    effect ePara = EffectParalyze();
    effect eDeath = EffectDeath();
    effect eVis1 = EffectVisualEffect(VFX_IMP_DAZED_S);
    effect eVis2 = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eVis3 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eVis4 = EffectVisualEffect(VFX_IMP_DEATH);
    float fStr, fPara;

    object oMaster;
    effect eVis = EffectVisualEffect(VFX_IMP_UNSUMMON);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    int nSpellDC = TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()) + 6;


    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE,lLoc,FALSE, OBJECT_TYPE_CREATURE);


    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                nTarget = GetHitDice(oTarget);
                nDiff = nCaster - nTarget;
                if(nDiff < 0)
                {
                //Nothing happens.
                }
                else if(nDiff >= 0 && nDiff < 1)
                {
                //Daze.
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDaze,oTarget,RoundsToSeconds(1));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis1,oTarget,RoundsToSeconds(1));
                }
                else if(nDiff >= 1 && nDiff < 5)
                {
                    fStr = TurnsToSeconds(d4(2));
                    eSTR = EffectAbilityDecrease(ABILITY_STRENGTH,d6(2));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDaze,oTarget,RoundsToSeconds(1));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSTR,oTarget,fStr);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis1,oTarget,RoundsToSeconds(1));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis2,oTarget,fStr);
                }
                else if(nDiff >= 5 && nDiff < 10)
                {
                    fStr = TurnsToSeconds(d4(2));
                    fPara = TurnsToSeconds(d10(1));
                    eSTR = EffectAbilityDecrease(ABILITY_STRENGTH,d6(2));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDaze,oTarget,RoundsToSeconds(1));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSTR,oTarget,fStr);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis1,oTarget,RoundsToSeconds(1));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis2,oTarget,fStr);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePara,oTarget,fPara);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis3,oTarget,fPara);
                }
                else if(nDiff >= 10)
                {
                    fStr = TurnsToSeconds(d4(2));
                    fPara = TurnsToSeconds(d10(1));
                    eSTR = EffectAbilityDecrease(ABILITY_STRENGTH,d6(2));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDaze,oTarget,RoundsToSeconds(1));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSTR,oTarget,fStr);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis1,oTarget,RoundsToSeconds(1));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis2,oTarget,fStr);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePara,oTarget,fPara);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis3,oTarget,fPara);

                    if(GetIsUndead(oPC) == TRUE)
                    {
                        effect eDmg = EffectDamage(GetCurrentHitPoints(oTarget),DAMAGE_TYPE_DIVINE,DAMAGE_POWER_ENERGY);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis4,oTarget);
                    }
                    else
                    {
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis4,oTarget);
                    }
                }
            }
        }

        //does the creature have a master.
        oMaster = GetMaster(oTarget);
        //Is that master valid and is he an enemy
        if(GetIsObjectValid(oMaster) && spellsIsTarget(oMaster,SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF ))
        {
            //Is the creature a summoned associate
            if(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oMaster) == oTarget ||
               GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oMaster) == oTarget ||
               GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oMaster) == oTarget )
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DISMISSAL));
                //Determine correct save

                //Make SR and will save checks
                if (!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_WILL, oTarget, nSpellDC))
                {
                     //Apply the VFX and delay the destruction of the summoned monster so
                     //that the script and VFX can play.
                     ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                     DestroyObject(oTarget, 0.5);
                }
            }
        }



        oTarget = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE,lLoc,FALSE, OBJECT_TYPE_CREATURE);
    }

}
