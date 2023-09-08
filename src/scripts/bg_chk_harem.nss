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
        (GetHasFeat(BACKGROUND_LOWER,oPC) == TRUE || GetHasFeat(BACKGROUND_MIDDLE,oPC) == TRUE)&&
        !GetHasFeat(1182,oPC) &&
        !GetHasFeat(1183,oPC) &&
        !GetHasFeat(1184,oPC) &&
        !GetHasFeat(1452,oPC) &&
        !GetHasFeat(1453,oPC) &&
        !GetHasFeat(1454,oPC) &&
        !GetHasFeat(1455,oPC) &&
        !GetHasFeat(1456,oPC) &&
        !GetHasFeat(1457,oPC) &&
        GetRacialType(oPC) != RACIAL_TYPE_HALFORC &&
        (GetAbilityScore(oPC,ABILITY_CHARISMA,TRUE) >= 13)

      )
    {
        return TRUE;
    }

    return FALSE;
}
