
#include "gs_inc_shop"

int StartingConditional()
{
    object oSpeaker  = GetPCSpeaker();
    object oItem     = GetLocalObject(oSpeaker, "GS_SH_ITEM");
    int nSalePrice   = TE_SH_GetSalePrice(OBJECT_SELF);
    int nRetailPrice = TE_SH_GetItemValue(oItem);
    int nValue       = nRetailPrice + (nRetailPrice * nSalePrice / 100);
    if (nValue < 1)  nValue = 1;

    SetCustomToken(100, GetName(oItem));
    SetCustomToken(101, IntToString(nValue));

    return TRUE;
}
