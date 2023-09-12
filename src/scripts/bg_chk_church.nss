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
    if(GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC) < 1 || GetRacialType(oPC) == RACIAL_TYPE_HALFORC)
    {
        return FALSE;
    }
        return TRUE;
}
