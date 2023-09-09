#include "gs_inc_shop"

void main()
{
    object oShop = OBJECT_SELF;
    string sMerch;
    string sInsig;
    int nPrice = TE_SH_GetRentPrice(oShop);
    int nMerch = TE_SH_GetMerchant(oShop);
    if(nMerch == 1){sMerch = "TRUE";}
    else{sMerch = "FALSE";}

    int nInsig = TE_SH_GetInsignia(oShop);
    if(nInsig == 1){sInsig = "TRUE";}
    else{sInsig = "FALSE";}

    SetCustomToken(105,sMerch);
    SetCustomToken(106,sInsig);
    SetCustomToken(107,IntToString(nPrice));
}
