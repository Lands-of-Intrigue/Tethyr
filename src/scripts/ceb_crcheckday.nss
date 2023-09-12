int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBox = GetItemPossessedBy(oPC, "ceb_crcraftbox");
    object oItem = GetFirstItemInInventory(oBox);
    if (GetCalendarDay()==GetLocalInt(oItem, "Date")) return TRUE;
    return FALSE;
}
