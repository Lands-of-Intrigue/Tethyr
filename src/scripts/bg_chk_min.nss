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
!GetHasFeat(1183,oPC) &&
!GetHasFeat(1179,oPC) &&
!GetHasFeat(1452,oPC) &&
!GetHasFeat(1453,oPC) &&
!GetHasFeat(1455,oPC) &&
GetRacialType(oPC) != RACIAL_TYPE_HALFORC &&
GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC) < 1 &&
        (GetAbilityScore(oPC,ABILITY_CHARISMA,TRUE) >= 13)
      )
    {
        return TRUE;
    }

    return FALSE;
}
