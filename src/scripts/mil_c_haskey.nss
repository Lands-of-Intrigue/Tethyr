//::///////////////////////////////////////////////
//:: Condition test Has Key
//:: mil_c_haskey.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Returns true if the PC has a shackle key in thier inventory.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////

#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ShackleKey"))
        return FALSE;

    return TRUE;
}
