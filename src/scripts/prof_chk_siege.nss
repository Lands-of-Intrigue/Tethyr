//::///////////////////////////////////////////////
//:: FileName BG 1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: 10/20/17
//:://////////////////////////////////////////////
#include "te_functions"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Make sure the player has the required feats
    if(
        (GetHasFeat(PROFICIENCY_SIEGE,oPC) == FALSE)&&(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Prof") > 0)
      )
    {
        return TRUE;
    }

    return FALSE;
}
