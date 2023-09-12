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
        !GetHasFeat(BACKGROUND_UPPER,oPC)&&
        !GetHasFeat(1458,oPC) &&
        !GetHasFeat(1177,oPC) &&
        !GetHasFeat(1178,oPC) &&
        !GetHasFeat(1179,oPC) &&
        !GetHasFeat(1180,oPC) &&
        !GetHasFeat(1181,oPC) &&
        !GetHasFeat(1452,oPC) &&
        !GetHasFeat(1453,oPC) &&
        !GetHasFeat(1454,oPC)&&
        GetAbilityScore(oPC,ABILITY_STRENGTH,TRUE) >= 13
      )
    {
        return TRUE;
    }

    return FALSE;
}
