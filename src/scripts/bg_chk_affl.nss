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
        GetHasFeat(BACKGROUND_UPPER,oPC)&&
        GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC) < 1 &&
        (GetHasFeat(1445,oPC) ||
GetHasFeat(1447,oPC) ||
GetHasFeat(1451,oPC) ||
GetHasFeat(1381,oPC) ||
GetHasFeat(1382,oPC) ||
GetHasFeat(1383,oPC) ||
GetHasFeat(1384,oPC) ||
GetHasFeat(1385,oPC) ||
GetHasFeat(1387,oPC))
      )
    {
        return TRUE;
    }

    return FALSE;
}
