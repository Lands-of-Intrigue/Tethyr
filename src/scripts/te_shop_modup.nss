#include "gs_inc_shop"

void main()
{
    object oShop = OBJECT_SELF;
    string sInsig;
    int nPrice = TE_SH_GetRentPrice(oShop);

    int nInsig = TE_SH_GetInsignia(oShop);
    if(nInsig == 1){sInsig = "TRUE";}
    else{sInsig = "FALSE";}

    SetCustomToken(105,"TRUE");
    SetCustomToken(106,sInsig);
    SetCustomToken(107,IntToString(nPrice));
}
