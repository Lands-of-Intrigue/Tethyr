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
        (GetHasFeat(1456,oPC) ||
        GetHasFeat(1381,oPC) ||
        GetHasFeat(1382,oPC) ||
        GetHasFeat(1383,oPC) ||
        GetHasFeat(1384,oPC) ||
        GetHasFeat(1385,oPC) ||
        GetHasFeat(1387,oPC))&&
        GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC) < 1 &&
        GetRacialType(oPC) != RACIAL_TYPE_HALFELF
      )
    {
        return TRUE;
    }

    return FALSE;
}
