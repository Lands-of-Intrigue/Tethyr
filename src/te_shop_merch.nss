#include "gs_inc_shop"

void main()
{
    object oShop = OBJECT_SELF;
    string sMerch;
    string sInsig;
     int nMerch = TE_SH_GetMerchant(oShop);

    if(nMerch == 0)
    {
        sMerch = "TRUE";
        TE_SH_SetMerchant(oShop,1);
    }
    else
    {
        sMerch = "FALSE";
        TE_SH_SetMerchant(oShop,0);
    }

    SetCustomToken(105,sMerch);
}
