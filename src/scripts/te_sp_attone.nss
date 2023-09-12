//::///////////////////////////////////////////////
//:: Attonment
//:: te_sp_attone
//::
//:://////////////////////////////////////////////
/*
    sets the target aligment to that of the caster.
*/
//:://////////////////////////////////////////////
//:: Created By: Charlie Simonsson
//:: Created On: jun 10, 2019
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
    object oCaster = OBJECT_SELF;
    object oItem = GetItemPossessedBy(oTarget,"PC_Data_Object");

    SetLocalInt(oItem,"nPiety",100);

    int nCasterGEValue = GetGoodEvilValue(oCaster);
    int nCasterLCValue = GetLawChaosValue(oCaster);

    int nTargetGEValue = GetGoodEvilValue(oTarget);
    int nTargetLCValue = GetLawChaosValue(oTarget);
    int nChange;

    // setting the good evil axis of the target
    if (nTargetGEValue > nCasterGEValue){
        nChange = nTargetGEValue - nCasterGEValue;
        AdjustAlignment(oTarget, ALIGNMENT_EVIL, nChange, FALSE);
    }
    else if (nTargetGEValue < nCasterGEValue){
        nChange = nCasterGEValue - nTargetGEValue;
        AdjustAlignment(oTarget, ALIGNMENT_GOOD, nChange, FALSE);
    }

    // setting the Law Chaos axis of the target
    if (nTargetLCValue > nCasterLCValue){
        nChange = nTargetLCValue - nCasterLCValue;
        AdjustAlignment(oTarget, ALIGNMENT_CHAOTIC, nChange, FALSE);
    }
    else if (nTargetLCValue < nCasterLCValue){
        nChange = nCasterLCValue - nTargetLCValue;
        AdjustAlignment(oTarget, ALIGNMENT_LAWFUL, nChange, FALSE);
    }

    SetLocalInt(oItem, "iTrans",0);
    SetXP(oCaster, GetXP(oCaster) - 500);
}

