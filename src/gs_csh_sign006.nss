#include "gs_inc_shop"

int StartingConditional()
{
    object oSpeaker = GetPCSpeaker();
    int nCost       = TE_SH_GetRentPrice(OBJECT_SELF);

    if (nCost > 0) TakeGoldFromCreature(nCost, oSpeaker, TRUE);

    TE_SH_SetShopOwner(OBJECT_SELF, oSpeaker);
    TE_SH_SetSalePrice(OBJECT_SELF, FALSE);

    return TRUE;
}
