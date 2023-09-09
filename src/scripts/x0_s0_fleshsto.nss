//::///////////////////////////////////////////////
//:: Flesh to Stone
//:: x0_s0_fleshsto
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
//:: The target freezes in place, standing helpless.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: October 16, 2002
//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "te_functions"
#include "te_afflic_func"

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
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());

    if (MyResistSpell(OBJECT_SELF,oTarget) <1)
    {
       if(!GetIsUndead(oTarget))
       {
            DoPetrification(nCasterLvl, OBJECT_SELF, oTarget, GetSpellId(), TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()));
       }
    }
}


