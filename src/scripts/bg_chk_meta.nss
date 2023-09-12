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
        (GetRacialType(oPC) == RACIAL_TYPE_HALFELF||
         GetRacialType(oPC) == RACIAL_TYPE_HALFLING||
         GetRacialType(oPC) == RACIAL_TYPE_GNOME||
         GetRacialType(oPC) == RACIAL_TYPE_HUMAN)&&
        (GetAbilityScore(oPC,ABILITY_CONSTITUTION,TRUE) >= 13)

      )
    {
        return TRUE;
    }

    return FALSE;
}
