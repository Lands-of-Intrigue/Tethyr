//::///////////////////////////////////////////////
//:: Example Item Event Script
//:: x2_it_example
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is an example of how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works if
    the following scripts are set in your
    module events

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:: Modified By: Grimlar
//:: Modified On: March 2004
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "nwnx_webhook"
#include "nwnx_webhook_rch"
#include "nwnx_time"
#include "x3_inc_string"
#include "gs_inc_shop"

void EventLogMessage(object oPC,object oItem,object oTarget);

void main()
{
    int    nEvent = GetUserDefinedItemEventNumber(); // Which event triggered this
    object oPC;                                      // The player character using the item
    object oItem;                                    // The item being used
    object oTarget;
    string sTitle;
    string sDescription;
    string sConstructedMsg;
    string sEventMsg;
    struct NWNX_WebHook_Message stMessage;
    string sWebhook;
    // Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    {
        case X2_ITEM_EVENT_ACTIVATE:
            // * This code runs when the Unique Power property of the item is used or the item
            // * is activated. Note that this event fires for PCs only

            oPC    = GetItemActivator();             // The player who activated the item
            oItem   = GetItemActivated();             // The item that was activated
            oTarget = GetItemActivatedTarget();

            if(GetIsObjectValid(oPC) == FALSE || GetIsObjectValid(oItem) == FALSE)
            {
                break;
            }

            if(oTarget == oPC)
            {
                SetLocalObject(oPC,"oPaper",oItem);
            }
            else if(GetTag(oTarget) == "te_broadsheet")
            {
                SetCampaignString("Brost_Broadsheet","sName",GetName(oItem));
                SetCampaignString("Brost_Broadsheet","sDesc",GetDescription(oItem));

            }
            else if(GetTag(oTarget) == "TE_SHOP")
            {
                if(TE_SH_GetIsOwner(oTarget,oPC) == TRUE)
                {
                    SetName(oTarget,GetName(oItem));
                    TE_SH_SetShopName(oTarget,GetName(oItem));
                    DestroyObject(oItem,0.1f);
                }
            }
            else if(GetTag(oTarget) == "te_messageboard")
            {
                EventLogMessage( oPC, oItem, oTarget);

                if(GetLocalString(oTarget,"Location") == "Brost")
                {
                    sWebhook = WEBHOOK_BROST;
                    stMessage.sUsername = "Brost Noticeboard";
                    stMessage.sTitle = GetName(oItem);

                    stMessage.sAuthorName = "No Official Seal";

                    if(GetLocalInt(oItem,"Sealed") == 1)
                    {
                        stMessage.sAuthorName = "Official Seal of "+GetLocalString(oItem,"SealName");
                    }

                    stMessage.sDescription = StringReplace(StringReplace(GetDescription(oItem),"\"","'"),"\n","\\n");
                    stMessage.sFooterText = "Spellplague - Brost Noticeboard";
                    stMessage.iTimestamp = NWNX_Time_GetTimeStamp();
                    sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discordapp.com", sWebhook, stMessage);
                    NWNX_WebHook_SendWebHookHTTPS("discordapp.com",sWebhook, sConstructedMsg);
                    DestroyObject(oItem,0.1f);
                }
                else if(GetLocalString(oTarget,"Location") == "Lockwood")
                {
                    sWebhook = WEBHOOK_LOCKWOOD;
                    stMessage.sUsername = "Lockwood Noticeboard";
                    stMessage.sTitle = GetName(oItem);

                    stMessage.sAuthorName = "No Official Seal";

                    if(GetLocalInt(oItem,"Sealed") == 1)
                    {
                        stMessage.sAuthorName = "Official Seal of "+GetLocalString(oItem,"SealName");
                    }

                    stMessage.sDescription = StringReplace(StringReplace(GetDescription(oItem),"\"","'"),"\n","\\n");
                    stMessage.sFooterText = "Knights of Noromath - Lockwood Noticeboard";
                    stMessage.iTimestamp = NWNX_Time_GetTimeStamp();
                    sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discordapp.com", sWebhook, stMessage);
                    NWNX_WebHook_SendWebHookHTTPS("discordapp.com",sWebhook, sConstructedMsg);
                    DestroyObject(oItem,0.1f);
                }
            }
            else if(GetTag(oTarget) == "te_paper")
            {
                SendMessageToPC(oPC,"Paper copied!");
                CopyItem(oTarget,oPC,TRUE);
                DestroyObject(oItem,0.1f);
            }
            else
            {
                AssignCommand(oPC,ActionSpeakString(GetName(oItem)+" "+GetDescription(oItem,FALSE,TRUE),TALKVOLUME_TALK));
            }

            // Your code goes here
            break;

        case X2_ITEM_EVENT_EQUIP:
            // * This code runs when the item is equipped
            // * Note that this event fires for PCs only

            oPC   = GetPCItemLastEquippedBy();      // The player who equipped the item
            oItem = GetPCItemLastEquipped();        // The item that was equipped

            // Your code goes here
            break;

        case X2_ITEM_EVENT_UNEQUIP:
            // * This code runs when the item is unequipped
            // * Note that this event fires for PCs only

            oPC    = GetPCItemLastUnequippedBy();   // The player who unequipped the item
            oItem  = GetPCItemLastUnequipped();     // The item that was unequipped

            // Your code goes here
            break;

        case X2_ITEM_EVENT_ACQUIRE:
            // * This code runs when the item is acquired
            // * Note that this event fires for PCs only

            oPC    = GetModuleItemAcquiredBy();     // The player who acquired the item
            oItem  = GetModuleItemAcquired();       // The item that was acquired

            // Your code goes here
            break;

        case X2_ITEM_EVENT_UNACQUIRE:
            // * This code runs when the item is unacquired
            // * Note that this event fires for PCs only

            oPC    = GetModuleItemLostBy();         // The player who dropped the item
            oItem  = GetModuleItemLost();           // The item that was dropped

            // Your code goes here
            break;

    }

    // Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}

void EventLogMessage(object oPC,object oItem,object oTarget)
{
    struct NWNX_WebHook_Message stMessage;

    if(GetLocalString(oTarget,"Location") == "Brost")
    {
        stMessage.sUsername = "Brost Noticeboard";
    }
    else if(GetLocalString(oTarget,"Location") == "Lockwood")
    {
        stMessage.sUsername = "Lockwood Noticeboard";
    }
    stMessage.sTitle = GetName(oItem);

    if(GetLocalInt(oItem,"Sealed") == 1)
    {
        stMessage.sAuthorName = "Official Seal of "+GetLocalString(oItem,"SealName");
    }
    else
    {
        stMessage.sAuthorName = "No Official Seal";
    }

    stMessage.sDescription = StringReplace(StringReplace(GetDescription(oItem),"\"","'"),"\n","\\n");
    stMessage.sField1Name = "Name";
    stMessage.sField1Value = GetPCPlayerName(oPC);
    stMessage.iField1Inline = TRUE;
    stMessage.sField2Name = "IP";
    stMessage.sField2Value = GetPCIPAddress(oPC);
    stMessage.iField2Inline = TRUE;
    stMessage.sField3Name = "CDKey";
    stMessage.sField3Value = GetPCPublicCDKey(oPC);
    stMessage.iField3Inline = TRUE;
    stMessage.sFooterText = "Spellplague - Brost Noticeboard";
    stMessage.iTimestamp = NWNX_Time_GetTimeStamp();
    string sEventMsg = NWNX_WebHook_BuildMessageForWebHook("discordapp.com", WEBHOOK_EVENT_CHANNEL, stMessage);
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com",WEBHOOK_EVENT_CHANNEL, sEventMsg);
}
