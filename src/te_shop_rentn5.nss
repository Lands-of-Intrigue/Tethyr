#include "gs_inc_shop"
void main()
{
    object oShop = OBJECT_SELF;
    int nPrice = TE_SH_GetRentPrice(oShop);
    int nIncrease = 5;
    if(nPrice - nIncrease < 0){nPrice = 0; nIncrease = 0;}
    TE_SH_SetRentPrice(oShop,nPrice-nIncrease);
    SetCustomToken(107,IntToString(nPrice-nIncrease));
}
