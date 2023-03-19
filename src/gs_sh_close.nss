#include "gs_inc_shop"

void main()
{
    if (TE_SH_GetIsAvailable(OBJECT_SELF)) return;

    object oPC = GetLastClosedBy();

    if (GetIsDM(oPC) ||
        TE_SH_GetIsOwner(OBJECT_SELF, oPC))
    {
        DelayCommand(0.5, TE_SH_SaveShop(OBJECT_SELF));
    }
}
