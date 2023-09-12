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
        GetHasFeat(1184,oPC) ||
        GetHasFeat(1180,oPC) ||
        GetHasFeat(1454,oPC) ||
        GetHasFeat(1455,oPC) ||
        GetHasFeat(1456,oPC) ||
        GetHasFeat(1457,oPC) ||
        GetHasFeat(1445,oPC) ||
        GetHasFeat(1447,oPC) ||
        GetHasFeat(1448,oPC) ||
        GetHasFeat(1450,oPC) ||
        GetHasFeat(1451,oPC) ||
        GetHasFeat(1381,oPC) ||
        GetHasFeat(1382,oPC) ||
        GetHasFeat(1383,oPC) ||
        GetHasFeat(1384,oPC) ||
        GetHasFeat(1385,oPC) ||
        GetHasFeat(1386,oPC) ||
        GetHasFeat(1387,oPC) ||
        GetHasFeat(1388,oPC) ||
        GetHasFeat(1186,oPC) ||
        GetRacialType(oPC) == RACIAL_TYPE_HALFORC)
    {
        return TRUE;
    }

    return FALSE;
}
