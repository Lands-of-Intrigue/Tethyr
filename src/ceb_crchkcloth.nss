int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBox = GetItemPossessedBy(oPC, "ceb_crcraftbox");
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oBox);
    if (GetTag(oItem)=="te_cebcraft02") return FALSE;

    return TRUE;
}
