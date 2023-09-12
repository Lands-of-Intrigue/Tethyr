//::///////////////////////////////////////////////
//:: Maelstrom of Fire
//:: TE_SC_Maelstrom
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a zone of destruction around the caster
    within which all living creatures are pummeled
    with fire and divine damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 11, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 21, 2001

//EDITED ON 4/15/22 FOR SPELLPLAGUE

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    //Declare major variables
    int nDamage;
    int nDamage2 = d10(2);
    int nCHA = GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);
    effect eFireStorm = EffectVisualEffect(VFX_FNF_ICESTORM);
    float fDelay;

    //Apply Fire and Forget Visual in the area;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage2, DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL), OBJECT_SELF);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        //This spell smites everyone who is more than 2 meters away from the caster.
        //if (GetDistanceBetween(oTarget, OBJECT_SELF) > 2.0)
        //{
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
            {
                fDelay = GetRandomDelay(1.5, 2.5);
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIRE_STORM));
                //Make SR check, and appropriate saving throw(s).
                //if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                //{
                      //Roll Damage
                      nDamage = d3(25);
                      //Save versus both holy and fire damage
                      nDamage = GetReflexAdjustedDamage(nDamage/2, oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()), SAVING_THROW_TYPE_COLD);
                    if(nDamage > 0)
                    {
                          // Apply effects to the currently selected target.  For this spell we have used
                          //both Divine and Fire damage.
                          effect eDivine = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                          effect eFire = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDivine, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                //}
            //}
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

