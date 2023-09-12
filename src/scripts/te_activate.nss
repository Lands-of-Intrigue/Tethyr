//:://////////////////////////////////////////////
//:: OnActivateItem
//:: TE_ActivateItem
//:: Function(D20) 2016
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: March 22, 2016
//:://////////////////////////////////////////////

#include "x2_inc_switches"

void main()
{
     object oItem = GetItemActivated();

     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACTIVATE);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }

     }

}
