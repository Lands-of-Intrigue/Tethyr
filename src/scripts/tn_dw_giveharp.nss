#include "x0_i0_partywide"
#include "loi_xp"

void main()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(GetItemPossessedBy(oPC, "PC_Data_Object"), "QuestDWHarp") == 0)
    {
        CreateItemOnObject("tn_dw_eliharp", oPC);
        CreateItemOnObject("tn_dw_elisong", oPC);
        DestroyObject(GetItemPossessedByParty(oPC, "tn_dw_necklace"));
        AwardXP(oPC, 250);
        SetLocalInt(GetItemPossessedBy(oPC, "PC_Data_Object"), "QuestDWHarp", 1);
    }
}
