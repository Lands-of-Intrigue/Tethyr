#include "nw_i0_tool"
#include "df_handler"
void main()
{
    object oTarget = GetEnteringObject();

    FloatingTextStringOnCreature("Entering Oxygen Deprived Area", oTarget, FALSE);
    DF_ReplenishOxygen(oTarget);
}

