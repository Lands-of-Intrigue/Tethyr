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
        (GetRacialType(oPC) != RACIAL_TYPE_HALFORC)
         &&(GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC) < 1)
      )
    {
        return TRUE;
    }

    return FALSE;
}
