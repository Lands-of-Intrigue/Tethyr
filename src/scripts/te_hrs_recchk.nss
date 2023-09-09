//::///////////////////////////////////////////////
//:: FileName te_hrs_recchk
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/11/2017 12:27:13 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "te_hrs_rec"))
        return FALSE;

    return TRUE;
}
