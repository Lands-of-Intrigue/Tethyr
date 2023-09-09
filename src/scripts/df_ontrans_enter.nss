#include "nw_i0_tool"
#include "df_handler"
void main()
{
    object oPC = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);

    FloatingTextStringOnCreature("Entering Oxygen Deprived Area", oPC, FALSE);
    DF_ReplenishOxygen(oPC);
    AssignCommand(oPC, JumpToObject(oTarget));
}

