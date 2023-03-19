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
        !GetHasFeat(BACKGROUND_LOWER,oPC) &&
        !GetHasFeat(1182,oPC) &&
        !GetHasFeat(1183,oPC) &&
        !GetHasFeat(1184,oPC) &&
        !GetHasFeat(1458,oPC) &&
        !GetHasFeat(1177,oPC) &&
        !GetHasFeat(1178,oPC) &&
        !GetHasFeat(1179,oPC) &&
        !GetHasFeat(1452,oPC) &&
        !GetHasFeat(1453,oPC) &&
        !GetHasFeat(1454,oPC) &&
        !GetHasFeat(1455,oPC) &&
        !GetHasFeat(1456,oPC) &&
        !GetHasFeat(1457,oPC) &&
        !GetHasFeat(1445,oPC) &&
        !GetHasFeat(1446,oPC) &&
        !GetHasFeat(1448,oPC) &&
        !GetHasFeat(1450,oPC) &&
        GetRacialType(oPC) != RACIAL_TYPE_HALFORC &&
        GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC) < 1 &&
        GetAbilityScore(oPC,ABILITY_DEXTERITY,TRUE) >= 13
      )
    {
        return TRUE;
    }

    return FALSE;
}
