//:://////////////////////////////////////////////
//:: OnAcquireItem
//:: TE_AcquireItem
//:: Function(D20) 2016
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: March 22, 2016
//:://////////////////////////////////////////////

#include "x2_inc_switches"

void main()
{
    //Item script execution code, written by NWN
    //Enables Tag-based scripting.
    object oItem  = GetModuleItemAcquired();
    if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
    {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACQUIRE);
        int nRet =  ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem), OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
            return;
        }
    }

    //OUR STUFF
}

