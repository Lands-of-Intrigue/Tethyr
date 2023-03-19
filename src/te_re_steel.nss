#include "x2_inc_switches"
void main()
{
    int nEvent =GetUserDefinedItemEventNumber();

    if (nEvent !=  X2_ITEM_EVENT_ACTIVATE)
        return;

    SetLocalInt(GetItemActivatedTarget(), "Material", 2);
}
