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
    if(GetHasFeat(1182,oPC) ||
GetHasFeat(1183,oPC) ||
GetHasFeat(1184,oPC) ||
GetHasFeat(1179,oPC) ||
GetHasFeat(1452,oPC) ||
GetHasFeat(1447,oPC) ||
GetHasFeat(1187,oPC) ||
GetRacialType(oPC) == RACIAL_TYPE_HALFORC)
    {
        return TRUE;
    }

    return FALSE;
}
