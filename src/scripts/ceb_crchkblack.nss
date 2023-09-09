int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBox = GetItemPossessedBy(oPC, "ceb_crcraftbox");
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oBox);
    if (GetTag(oItem)=="te_cebcraft010") return FALSE;
    if (GetTag(oItem)=="te_cebcraft014") return FALSE;
    if (GetTag(oItem)=="te_cebcraft015") return FALSE;
    if (GetTag(oItem)=="te_cebcraft017") return FALSE;
    if (GetTag(oItem)=="te_cebcraft022") return FALSE;
    if (GetTag(oItem)=="te_cebcraft027") return FALSE;
    if (GetTag(oItem)=="te_cebcraft032") return FALSE;
    if (GetTag(oItem)=="te_cebcraft033") return FALSE;
    return TRUE;
}
