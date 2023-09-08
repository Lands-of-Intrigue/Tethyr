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
        ((GetHitDice(oPC) <= 3) && (GetHasFeat(PROFICIENCY_WOOD_GATHERING,oPC) == FALSE)&&(GetHasFeat(BACKGROUND_LOWER,oPC) == TRUE )&&(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Prof") > 0))||
        ((GetHitDice(oPC) >= 7) && (GetHasFeat(PROFICIENCY_WOOD_GATHERING,oPC) == FALSE)&&(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Prof") > 0))
      )
    {
        return TRUE;
    }

    return FALSE;
}
