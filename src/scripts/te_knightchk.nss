//::///////////////////////////////////////////////
//:: FileName te_knightchk
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/11/2017 12:24:52 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "te_writknight"))
        return FALSE;

    return TRUE;
}
