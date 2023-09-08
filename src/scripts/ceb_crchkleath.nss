int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBox = GetItemPossessedBy(oPC, "ceb_crcraftbox");
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oBox);
    if (GetTag(oItem)=="te_cebcraft012") return FALSE;
    if (GetTag(oItem)=="te_cebcraft018") return FALSE;
    if (GetTag(oItem)=="te_cebcraft024") return FALSE;
    return TRUE;
}
