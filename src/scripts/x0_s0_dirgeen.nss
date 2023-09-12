//::///////////////////////////////////////////////
//:: Acid Fog: On Enter
//:: NW_S0_AcidFogA.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All creatures within the AoE take 2d6 acid damage
    per round and upon entering if they fail a Fort Save
    their movement is halved.

    **EDITED Nov 18/02 - Keith Warner**
    Only enemies should take the dirge damage
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 17, 2001
//:://////////////////////////////////////////////

#include "x0_i0_spells"

#include "x2_inc_spellhook"
#include "te_functions"
#include "te_afflic_func"

void main()
{


    object oTarget = GetEnteringObject();

    if(!GetIsUndead(oTarget))
    {    DoDirgeEffect(GetEnteringObject());}
}


