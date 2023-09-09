#include "nw_i0_tool"
#include "df_handler"
void main()
{
    object oTarget = GetExitingObject();

    FloatingTextStringOnCreature("Exiting Oxygen Deprived Area", oTarget, FALSE);
    DF_ReplenishOxygen(oTarget);
}

