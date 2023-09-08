#include "gs_inc_shop"
void main()
{
    object oShop = OBJECT_SELF;
    int nPrice = TE_SH_GetRentPrice(oShop);
    int nIncrease = 50;

    TE_SH_SetRentPrice(oShop,nPrice+nIncrease);
    SetCustomToken(107,IntToString(nPrice+nIncrease));
}
