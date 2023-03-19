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
    if(GetHasFeat(1455,oPC) ||
GetHasFeat(1456,oPC) ||
GetHasFeat(1457,oPC))
    {
        return TRUE;
    }

    return FALSE;
}
