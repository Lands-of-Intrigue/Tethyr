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
        (GetHasFeat(BACKGROUND_MIDDLE,oPC) == TRUE || GetHasFeat(BACKGROUND_UPPER,oPC) == TRUE)&&
        (GetRacialType(oPC) == RACIAL_TYPE_HALFELF||
         GetRacialType(oPC) == RACIAL_TYPE_HUMAN)

      )
    {
        return TRUE;
    }

    return FALSE;
}
