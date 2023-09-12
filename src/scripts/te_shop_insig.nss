#include "gs_inc_shop"

void main()
{
    object oShop = OBJECT_SELF;
    string sMerch;
    string sInsig;
     int nInsig = TE_SH_GetInsignia(oShop);

    if(nInsig == 0)
    {
        sInsig = "TRUE"; TE_SH_SetInsignia(oShop,1);
    }
    else
    {
        sInsig = "FALSE";
        TE_SH_SetInsignia(oShop,0);
    }

    SetCustomToken(106,sInsig);
}
