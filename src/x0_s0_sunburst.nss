//::///////////////////////////////////////////////
//:: Sunburst
//:: X0_S0_Sunburst
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
// Brilliant globe of heat
// All creatures in the globe are blinded and
// take 6d6 damage
// Undead creatures take 1d6 damage (max 25d6)
// The blindness is permanent unless cast to remove it
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 23 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs May 14, 2003
//:: Notes: Changed damage to non-undead to 6d6
//:: 2003-10-09: GZ Added Subrace check for vampire special case, bugfix

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "te_functions"
#include "te_afflic_func"

float nSize =  RADIUS_SIZE_COLOSSAL;



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
    if (GetHasFeat(1300, OBJECT_SELF))
    {
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nCasterLvl = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage = 0;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eHitVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
    effect eLOS = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Limit Caster level for the purposes of damage
    if (nCasterLvl > 25)
    {
        nCasterLvl = 25;
    }

    if(GetHasFeat(1300,OBJECT_SELF) == TRUE)
    {
        nCasterLvl = nCasterLvl/2;
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eLOS, GetSpellTargetLocation());
    int bDoNotDoDamage = FALSE;


    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBURST));
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the flame that erupts on the target not on the ground.
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHitVis, oTarget);

            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                if (GetIsUndead(oTarget) == TRUE)
                {
                    //Roll damage for each target
                    nDamage = MaximizeOrEmpower(6, nCasterLvl, nMetaMagic);
                }
                else
                {
                    nDamage = MaximizeOrEmpower(6, 6, nMetaMagic);
                }


                if (bDoNotDoDamage == FALSE)
                    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()), SAVING_THROW_TYPE_SPELL);

                // * Do damage
                if ((nDamage > 0) && (bDoNotDoDamage == FALSE))
                {
                    //Set the damage effect
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);

                    // Apply effects to the currently selected target.
                    DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

                     // * if reflex saving throw fails apply blindness
                    if (!ReflexSave(oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()), SAVING_THROW_TYPE_SPELL))
                    {
                        effect eBlindness = EffectBlindness();
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBlindness, oTarget);
                    }
                } // nDamage > 0
             }

             //-----------------------------------------------------------------
             // GZ: Bugfix, reenable damage for next object
             //-----------------------------------------------------------------
             bDoNotDoDamage = FALSE;
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}

