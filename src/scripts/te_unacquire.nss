//:://////////////////////////////////////////////
//:: UnAcquireItem
//:: TE_UnAcquired
//:: Function(D20) 2016
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: March 22, 2016
//:: Functions written by Jonathan Lorensten
//:://////////////////////////////////////////////

//Function: Dropped Items become Placeables // Date: 22MAR16
//Creator: Jonathan Lorentsen // Email: jlorents93@hotmail.com
//Instructions: Ensure Item (TAG) & Placeable (Blueprint Resref) is same
//Add Variable "iDrop = 1" into the Item
//Note: Refrain using with Stackable Items, buggy/won't fire or consume all stacks.
#include "x2_inc_switches"
#include "loi_functions"
#include "bdm_include"
#include "nwnx_webhook"

void main()
{

    BDM_ModuleItemUnacquired();
    object oTarget;
    object oPC;
    location lTarget;
    effect eEffect;
    object oItem = GetModuleItemLost();
    // * Generic Item Script Execution Code
    // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
    // * it will execute a script that has the same name as the item's tag
    // * inside this script you can manage scripts for all events by checking against
    // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
    if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
    {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_UNACQUIRE);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }

    }

    //Function: Dropped Items become Placeables // Date: 22MAR16
    //Creator: Jonathan Lorentsen // Email: jlorents93@hotmail.com
    //Instructions: Ensure Item (TAG) & Placeable (Blueprint Resref) is same
    //Add Variable "iDrop = 1" into the Item
    //Note: Refrain using with Stackable Items, buggy/won't fire or consume all stacks.
    oPC = GetModuleItemLostBy();
    EventPlacePlaceable(oPC, oItem);

    if(GetIsPC(oPC) == TRUE)
    {
//        string sAquire = "**("+GetPCPlayerName(oPC)+"/"+GetPCPublicCDKey(oPC)+"/"+GetName(GetArea(oPC))+" unacquired item: "+GetName(oItem)+"/"+GetResRef(oItem)+"/"+GetTag(oItem)+")**";
//        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sAquire, GetName(oPC));
    }
}
