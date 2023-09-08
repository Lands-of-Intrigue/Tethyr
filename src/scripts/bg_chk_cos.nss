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
        (GetHasFeat(BACKGROUND_MIDDLE,oPC) == TRUE)&&
!GetHasFeat(1182,oPC) &&
!GetHasFeat(1183,oPC) &&
!GetHasFeat(1184,oPC) &&
!GetHasFeat(1458,oPC) &&
!GetHasFeat(1179,oPC) &&
!GetHasFeat(1452,oPC) &&
!GetHasFeat(1453,oPC) &&
!GetHasFeat(1445,oPC) &&
!GetHasFeat(1446,oPC) &&
!GetHasFeat(1186,oPC) &&
!GetHasFeat(1187,oPC) &&
!GetHasFeat(1175,oPC) &&
        GetAbilityScore(oPC,ABILITY_CHARISMA,TRUE) >= 13 &&
        GetRacialType(oPC) != RACIAL_TYPE_HALFORC &&
        GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC) < 1
      )
    {
        return TRUE;
    }

    return FALSE;
}
