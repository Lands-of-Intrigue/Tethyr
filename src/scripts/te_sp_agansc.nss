//::///////////////////////////////////////////////
//:: Aganazzer_Flamewave
//:: te_sp_agansc
//:: Copyright (c) 2019 Knights of Noromath
//:://////////////////////////////////////////////
/*
// A thin sheet of searing flame shoots from your
// outspread hands.
// Any creature in the area of the flames suffers
// 1d8 points of fire damage per your caster level
// (maximum 5d8).
*/


#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

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
    float fDist;
    int nCasterLevel = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    object oTarget;
    effect eFire;
    //Declare and assign personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    //Limit Maximum caster level to keep damage to spell specifications.
    nCasterLevel =  FloatToInt(IntToFloat(nCasterLevel)/2);
    float fRange = IntToFloat(30);
    int nDamageDice = nCasterLevel;
    if (nDamageDice > 5)
    {
        nDamageDice = 5;
    }
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, fRange, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        //Signal spell cast at event to fire.
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BURNING_HANDS));
        //Calculate the delay time on the application of effects based on the distance
        //between the caster and the target
        fDist = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
        //Make SR check, and appropriate saving throw.
        if((!MyResistSpell(OBJECT_SELF, oTarget, fDist) || GetTag(oTarget) == "te_gol_iron") && oTarget != OBJECT_SELF )
        {
            nDamage = d8(nDamageDice);
            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage = 8 * nDamageDice;//Damage is at max
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
            }
            //Run the damage through the various reflex save and evasion feats
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()), SAVING_THROW_TYPE_FIRE);
            eFire = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, fRange, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
