#include "x2_inc_switches"
void main()
{
    int nEvent =GetUserDefinedItemEventNumber();

    if (nEvent !=  X2_ITEM_EVENT_ACTIVATE)
        return;

        //1416 Ex Barb
//1417 Ex Monk
//1420 Oathbreaker
//1421 Fallen Paladin

    object oTarget = GetItemActivatedTarget();
    object oItem = GetItemPossessedBy(oTarget,"PC_Data_Object");

    int iTransgres = GetLocalInt(oItem, "iTrans");

    if (iTransgres == 0)
    {
        SetLocalInt(oItem, "iTrans",1);
        SendMessageToPC(OBJECT_SELF,"Target transgressed!");
    }
    else
    {
        SetLocalInt(oItem,"iTrans",0);
        SendMessageToPC(OBJECT_SELF,"Target no longer transgressed!");
    }

}
