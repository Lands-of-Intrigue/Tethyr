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
        GetHasFeat(BACKGROUND_LOWER,oPC)&&
        !GetHasFeat(1182,oPC) &&
        !GetHasFeat(1183,oPC) &&
        !GetHasFeat(1184,oPC) &&
        !GetHasFeat(1458,oPC) &&
        !GetHasFeat(1179,oPC) &&
        !GetHasFeat(1452,oPC) &&
        (GetAbilityScore(oPC,ABILITY_CONSTITUTION,TRUE) >= 11)

      )
    {
        return TRUE;
    }

    return FALSE;
}
