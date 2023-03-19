#include "x2_inc_switches"
void main()
{
    int nEvent =GetUserDefinedItemEventNumber();

    if (nEvent !=  X2_ITEM_EVENT_ACTIVATE)
        return;

    object oNote = GetItemActivated();
    object oPC = GetItemActivator();
    if  (GetItemActivatedTarget() == oNote)
    {
        FloatingTextStringOnCreature("You cannot combine this journal page with itself!", oPC, FALSE);
        return;
    }
    else
    {
       if (GetTag(GetItemActivatedTarget()) == "tn_dw_tornpage")
        {
            DestroyObject(oNote);
            DelayCommand(0.1, DestroyObject(GetItemPossessedBy(oPC, "tn_dw_tornpage")));
            CreateItemOnObject("tn_dw_journal", oPC);
        }
        else
            {SendMessageToPC(oPC, "Nothing interesting happens.");}
        }
}
