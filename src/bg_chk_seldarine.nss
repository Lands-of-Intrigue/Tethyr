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
        (GetHasFeat(1177,oPC) ||
        GetHasFeat(1178,oPC) ||
        GetHasFeat(1180,oPC) ||
        GetHasFeat(1181,oPC)) &&
        GetLevelByClass(CLASS_TYPE_CLERIC,oPC) > 1
      )
    {
        return TRUE;
    }

    return FALSE;
}
