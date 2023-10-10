#include "x2_inc_itemprop"
#include "x2_inc_switches"

void main()
{
    // Make sure this is the OnAtivateItem event
    if (GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE)
    {
        return;
    }

    object oTarget = GetItemActivatedTarget();
    object oPC = GetItemActivator();

    if(GetIsObjectValid(oPC) == FALSE || GetIsObjectValid(oTarget) == FALSE)
    {
        return;
    }

    SetLocalObject(oPC,"ObjectEdit",oTarget);
    SendMessageToPC(oPC, "Target selected for description/name editing.");
}