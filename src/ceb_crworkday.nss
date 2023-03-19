void main()
{
    object oPC = GetPCSpeaker();
    object oBox = GetItemPossessedBy(oPC, "ceb_crcraftbox");
    object oItem = GetFirstItemInInventory(oBox);
    if (GetCalendarDay() != GetLocalInt(oItem, "Date"))
        {
        SetLocalInt(oItem, "Days", GetLocalInt(oItem, "Days")-1);
        SendMessageToPC(oPC, "You have " + IntToString(GetLocalInt(oItem, "Days")) + " days remaining on this item.");
        SetLocalInt(oItem, "Date", GetCalendarDay());
        }
}
