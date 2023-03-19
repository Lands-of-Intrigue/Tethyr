int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBox = GetItemPossessedBy(oPC, "ceb_crcraftbox");
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oBox);
    if (GetTag(oItem)=="te_cebcraft07") return FALSE;
    if (GetTag(oItem)=="te_cebcraft09") return FALSE;
    if (GetTag(oItem)=="te_cebcraft011") return FALSE;
    if (GetTag(oItem)=="te_cebcraft016") return FALSE;
    if (GetTag(oItem)=="te_cebcraft034") return FALSE;
    return TRUE;
}
