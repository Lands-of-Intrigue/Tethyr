#include "x0_i0_partywide"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetIsItemPossessedByParty(oPC, "tn_dw_necklace") == TRUE)
    {
        return TRUE;
    }
    return FALSE;
}

