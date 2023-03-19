//::///////////////////////////////////////////////
//:: Fireball
//:: NW_S0_Fireball
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// A fireball is a burst of flame that detonates with
// a low roar and inflicts 1d6 points of damage per
// caster level (maximum of 10d6) to all creatures
// within the area. Unattended objects also take
// damage. The explosion creates almost no pressure.
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18 , 2000
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 6, 2001
//:: Last Updated By: AidanScanlan, On: April 11, 2001
//:: Last Updated By: Preston Watamaniuk, On: May 25, 2001

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "te_functions"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
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
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetLevelByClass(CLASS_TYPE_BARD,oCaster)+(GetLevelByClass(CLASS_TYPE_CLERIC,oCaster)/2)+(GetLevelByClass(CLASS_TYPE_DRUID,oCaster)/2)+GetLevelByClass(CLASS_TYPE_SHADOW_ADEPT,oCaster)+GetLevelByClass(CLASS_TYPE_PALE_MASTER,oCaster)+GetLevelByClass(CLASS_TYPE_SORCERER,oCaster)+GetLevelByClass(CLASS_TYPE_SPELLFIRE,oCaster)+GetLevelByClass(CLASS_TYPE_WARLOCK,oCaster)+GetLevelByClass(CLASS_TYPE_WIZARD,oCaster)+GetLevelByClass(48,oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(62);
    effect eVis = EffectVisualEffect(211);
    effect eDam;
    effect eBeam = EffectBeam(VFX_BEAM_HOLY,oCaster,BODY_NODE_HAND,TRUE);
    //Get the spell target location as opposed to the spell target.
    object oTarg1 = GetSpellTargetObject();
    location lTarget = GetSpellTargetLocation();

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarg1, 1.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplode, oTarg1);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIREBALL));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            //Roll damage for each target
            int nDamF = d6(nCasterLvl);
            int nDamM = d6(nCasterLvl);

            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            nDamF = GetReflexAdjustedDamage(nDamF, oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()), SAVING_THROW_TYPE_COLD);
            //Set the damage effect
            effect eDamF = EffectDamage(nDamF, DAMAGE_TYPE_COLD);
            effect eDamM = EffectDamage(nDamM, DAMAGE_TYPE_MAGICAL);

            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamF, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamM, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));

        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

