#include "nw_i0_tool"
#include "df_handler"
void main()
{
    object oTarget = GetEnteringObject();

    if(GetIsObjectValid(oTarget) != TRUE)
    {
        oTarget = GetExitingObject();
    }

    DF_ReplenishOxygen(oTarget);
}

