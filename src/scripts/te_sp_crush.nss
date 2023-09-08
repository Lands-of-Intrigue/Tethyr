//::///////////////////////////////////////////////
//:: Stoneskin
//:: NW_S0_Stoneskin
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the creature touched 10/+5
    damage reduction.  This lasts for 1 hour per
    caster level or until 10 * Caster Level (100 Max)
    is dealt to the person.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 16 , 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
#include "nw_i0_spells"

#include "x2_inc_spellhook"
#include "nwnx_time"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "te_functions"

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

    effect eVis2 = EffectVisualEffect(1231);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eBad1 = EffectAttackDecrease(2,ATTACK_BONUS_MISC);
    effect eBad2 = EffectSavingThrowDecrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL);
    effect eBad3 = EffectDamageDecrease(2,DAMAGE_TYPE_BASE_WEAPON);
    location lTargetLocation = GetSpellTargetLocation();

    //Declare major variables
    int nAmount = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass()) * 10;
    int nDuration = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    float fDelay;

    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }

    effect eLink = EffectLinkEffects(eVis2,eDur);
    eLink = EffectLinkEffects(eBad1,eLink);
    eLink = EffectLinkEffects(eBad2,eLink);
    eLink = EffectLinkEffects(eBad3,eLink);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 11.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 1018));
            //Get the distance between the target and caster to delay the application of effects
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20.0;
            //Make SR check, and appropriate saving throw(s).
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay) && (oTarget != OBJECT_SELF))
            {
                if(!WillSave(oTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetLastSpell(),GetLastSpellCastClass()),SAVING_THROW_TYPE_MIND_SPELLS,OBJECT_SELF))
                {
                    RemoveEffectsFromSpell(oTarget,1018);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,TurnsToSeconds(nDuration));
                }
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 11.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE);
    }

}
