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
        GetRacialType(oPC) == RACIAL_TYPE_HUMAN || GetRacialType(oPC) == RACIAL_TYPE_HALFELF || GetRacialType(oPC) == RACIAL_TYPE_HALFORC
      )
    {
        return TRUE;
    }

    return FALSE;
}
