#include "gs_inc_shop"
int StartingConditional()
{
    return GetGold(GetPCSpeaker()) < TE_SH_GetRentPrice(OBJECT_SELF);
}
