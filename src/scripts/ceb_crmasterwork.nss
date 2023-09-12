#include "x2_inc_switches"
void main()
{
    if (GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;
    SetLocalInt(GetItemActivatedTarget(), "Masterwork", 1);
}
