#include "gs_inc_shop"

void main()
{
    if (TE_SH_GetIsAvailable(OBJECT_SELF)) return;

    object oPC = GetLastOpenedBy();
    SetName(OBJECT_SELF,TE_SH_GetShopName(OBJECT_SELF));
    if (TE_SH_GetIsOwner(OBJECT_SELF, oPC))
    {
        TE_SH_OwnerTouch(OBJECT_SELF);
    }

    if (! GetLocalInt(OBJECT_SELF, "GS_ENABLED"))
    {
        TE_SH_LoadShop(OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "GS_ENABLED", TRUE);
    }
}
