#include "gs_inc_shop"
#include "te_settle_inc"

int StartingConditional()
{
    SetName(OBJECT_SELF,TE_SH_GetShopName(OBJECT_SELF));
    if (! TE_SH_GetIsAvailable(OBJECT_SELF))
    {
        string sOwner = GetLocalString(OBJECT_SELF,"sOwner");
        SetCustomToken(100, TE_SH_GetOwnerName(OBJECT_SELF));
        SetCustomToken(101, IntToString(TE_SH_GetSalePrice(OBJECT_SELF)));
        SetCustomToken(103, GetSettlementName(sOwner));
        SetCustomToken(104, TE_SS_GetSettlementOwnerName(sOwner));
        return TRUE;
    }

    return FALSE;
}
