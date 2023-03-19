//::///////////////////////////////////////////////
//:: FileName BG 1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: 10/20/17
//:://////////////////////////////////////////////
#include "NWNX_Creature"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Make sure the player has the required feats
    if(
        GetRacialType(oPC) == RACIAL_TYPE_HUMAN&&
        GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC) < 1 &&
        !GetHasFeat(1186,oPC) &&
        !GetHasFeat(1187,oPC) &&
        !GetHasFeat(1445,oPC) &&
        !GetHasFeat(1446,oPC) &&
        !GetHasFeat(1450,oPC) &&
        !GetHasFeat(1451,oPC) &&
        !GetHasFeat(1448,oPC) &&
        !GetHasFeat(1175,oPC)
    )
    {
        return TRUE;
    }

    return FALSE;
}
