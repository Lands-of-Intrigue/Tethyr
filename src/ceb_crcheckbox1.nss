int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBox = GetItemPossessedBy(oPC, "ceb_crcraftbox");
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oBox);
    while (GetIsObjectValid(oItem)==TRUE)
        {
        nCount=nCount+1;
        oItem= GetNextItemInInventory(oBox);
        }
    if (nCount!=1) return TRUE;
    return FALSE;
}
