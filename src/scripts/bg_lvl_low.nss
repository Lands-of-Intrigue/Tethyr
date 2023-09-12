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
        GetRacialType(oPC) == RACIAL_TYPE_DWARF||
        GetRacialType(oPC) == RACIAL_TYPE_ELF||
        GetRacialType(oPC) == RACIAL_TYPE_HALFELF||
        GetRacialType(oPC) == RACIAL_TYPE_HALFLING||
        GetRacialType(oPC) == RACIAL_TYPE_GNOME||
        GetRacialType(oPC) == RACIAL_TYPE_HALFORC||
        GetRacialType(oPC) == RACIAL_TYPE_HUMAN
      )
    {
        return TRUE;
    }

    return FALSE;
}
