//::///////////////////////////////////////////////
//::  Daylight: Heartbeat
//:: te_sp_daylightc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Upon remaining within the daylight every round any stealth effects are removed.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////
//:: GZ: Removed SR, its not there by the book


#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    object oTarget = GetEnteringObject();
    if (GetActionMode(oTarget, ACTION_MODE_STEALTH)==TRUE)
    {
        SetActionMode(oTarget, ACTION_MODE_STEALTH, FALSE);
    }
}

