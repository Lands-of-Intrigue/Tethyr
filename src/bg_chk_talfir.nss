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
    (GetHasFeat(1387,oPC) ||
    GetHasFeat(1445,oPC))&&
    GetAbilityScore(oPC,ABILITY_CHARISMA,TRUE) >= 13)
    {
        return TRUE;
    }

    return FALSE;
}
