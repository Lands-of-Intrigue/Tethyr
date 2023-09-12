//::///////////////////////////////////////////////
//:: Daylight: On Enter
//:: te_sp_daylighta
//:://////////////////////////////////////////////
/*
    Upon entering the entering individual is instantly brought out of stealth
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////
//:: GZ: Removed SR, its not there by the book

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "te_functions"

void main()
{


    object oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if (GetActionMode(oTarget, ACTION_MODE_STEALTH)==TRUE)
        {
            SetActionMode(oTarget, ACTION_MODE_STEALTH, FALSE);
        }
        oTarget = GetNextInPersistentObject();
    }

    oTarget = GetEnteringObject();
    if (GetActionMode(oTarget, ACTION_MODE_STEALTH)==TRUE)
    {
        SetActionMode(oTarget, ACTION_MODE_STEALTH, FALSE);
    }
}


