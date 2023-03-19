#include "gs_inc_shop"

const int GS_VALUE = 5;

void main()
{
    int nSalePrice = GetLocalInt(OBJECT_SELF, "GS_SH_SALE_PRICE");
    TE_SH_SetSalePrice(OBJECT_SELF, nSalePrice + GS_VALUE);
}
