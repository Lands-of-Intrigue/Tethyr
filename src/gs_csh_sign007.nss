#include "gs_inc_shop"

int StartingConditional()
{
    int nSalePrice = TE_SH_GetSalePrice(OBJECT_SELF);

    SetCustomToken(100, IntToString(nSalePrice));
    SetLocalInt(OBJECT_SELF, "GS_SH_SALE_PRICE", nSalePrice);
    return TRUE;
}
