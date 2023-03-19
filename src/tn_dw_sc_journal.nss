#include "x0_i0_partywide"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetIsItemPossessedByParty(oPC, "tn_dw_journal") == TRUE)
    {
        return TRUE;
    }
    return FALSE;
}

