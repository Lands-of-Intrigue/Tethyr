#include "gs_inc_shop"
#include "te_settle_inc"

int StartingConditional()
{
    if (TE_SH_GetIsOwner(OBJECT_SELF, GetPCSpeaker()))
    {
        int nTimeout = GetLocalInt(OBJECT_SELF, "GS_TIMEOUT");
        string sOwner = GetLocalString(OBJECT_SELF,"sOwner");
        SetName(OBJECT_SELF,TE_SH_GetShopName(OBJECT_SELF));
        TE_SH_OwnerTouch(OBJECT_SELF);

        SetCustomToken(100, IntToString(TE_SH_GetSalePrice(OBJECT_SELF)));
        SetCustomToken(101, IntToString(nTimeout / 86400));
        SetCustomToken(103, GetSettlementName(sOwner));
        SetCustomToken(104, TE_SS_GetSettlementOwnerName(sOwner));

        return TRUE;
    }

    return FALSE;
}
