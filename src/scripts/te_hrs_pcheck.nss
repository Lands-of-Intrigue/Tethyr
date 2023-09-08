//::///////////////////////////////////////////////
//:: FileName te_hrs_pcheck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/5/2017 9:12:46 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    object oItem = GetItemPossessedBy(GetPCSpeaker(), "PC_Data_Object");

    // Inspect local variables
    if(!(GetLocalString(oItem, "sHorse") == ""))
        return FALSE;

    return TRUE;
}
