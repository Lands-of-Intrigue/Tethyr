//:: OnAcquireItem
//:: TE_OnAcquireItem
//:: Function(D20) 2016
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: March 22, 2016
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "bdm_include"
#include "nwnx_webhook"
#include "gs_inc_shop"

void main()
{
    BDM_ModuleItemAcquired();
    //Item script execution code, written by NWN
    //Enables Tag-based scripting.
    object oItem  = GetModuleItemAcquired();
    object oPC = GetModuleItemAcquiredBy();
    object oAcquiredFrom = GetModuleItemAcquiredFrom();
    string sTag          = GetTag(oItem);
    string pcCDKey = GetPCPublicCDKey(oPC, TRUE);
    string pcName = GetName(oPC);
    string currentNameOnItem = GetLocalString(oItem, "OwningPCName");
    string currentKeyOnItem = GetLocalString(oItem, "OwningCDKey");

    //shop
    if (GetStringLeft(sTag, 6) == "GS_SH_")
    {
        oAcquiredFrom = GetLocalObject(oItem, "GS_SH_CONTAINER");

        if (GetIsDM(oPC) ||
            TE_SH_GetIsAvailable(oAcquiredFrom) ||
            TE_SH_GetIsOwner(oAcquiredFrom, oPC))
        {
            TE_SH_ExportItem(oItem, oPC);
        }
        else
        {
            object oCopy = CopyItem(oItem, oAcquiredFrom, TRUE);

            if (GetIsObjectValid(oCopy))
            {
                DestroyObject(oItem);
                SetLocalObject(oPC, "GS_SH_ITEM", oCopy);
                AssignCommand(oAcquiredFrom, ActionStartConversation(oPC, "", TRUE, FALSE));
            }
        }
    }

    if(GetLocalInt(oPC,"nDisguiseName") == 1)
    {
        pcName = GetLocalString(oPC,"sOriginalName");
    }

    if(GetIsPC(oPC) == TRUE)
    {
        if((currentKeyOnItem == pcCDKey) && (pcName != currentNameOnItem)) {
            //SpeakString("Muling attempt by" + GetName(oPC)+ " " + GetPCPlayerName(oPC) +  " " + GetPCPublicCDKey(oPC)+ " " + GetPCIPAddress(oPC)+ " Item:" + GetName(oItem), TALKVOLUME_SILENT_SHOUT);
            SendMessageToAllDMs("Muling attempt by" + GetName(oPC)+ " " + GetPCPlayerName(oPC) +  " "+ GetPCPublicCDKey(oPC)+ " " + GetPCIPAddress(oPC)+ " Item:" + GetName(oItem)+ "  Debug: "+ pcCDKey + "  /  "+pcName);
            WriteTimestampedLogEntry("Muling attempt by" + GetName(oPC)+ " " + GetPCPlayerName(oPC) +  " " + GetPCPublicCDKey(oPC)+ " " + GetPCIPAddress(oPC)+ " Item:" + GetName(oItem));
            SendMessageToPC(oPC,"Your muling attempt has been logged by the system and DMs have been informed. You may as well start apologizing now.");
        }
        else{
            SetLocalString(oItem, "OwningCDKey", pcCDKey);
            SetLocalString(oItem, "OwningPCName", pcName);
        }

        //string sAquire = "**("+GetPCPlayerName(oPC)+"/"+GetPCPublicCDKey(oPC)+"/"+GetName(GetArea(oPC))+" acquired item: "+GetName(oItem)+"/"+GetResRef(oItem)+"/"+GetTag(oItem)+")**";
        //NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sAquire, GetName(oPC));

    }

    DeleteLocalInt(oItem,"HOME_POST");
    DeleteLocalInt(oItem,"SPAWNED_BY_SCRIPT");
    DeleteLocalFloat(oItem,"HOME_POST_RANGE");
    DeleteLocalObject(oItem,"ParentSpawn");
    DeleteLocalFloat(oItem,"SpawnFacing");
    DeleteLocalObject(oItem,"HOME_AREA");
    DeleteLocalFloat(oItem,"HomeX");
    DeleteLocalFloat(oItem,"HomeY");
    DeleteLocalFloat(oItem,"HomeZ");
    DeleteLocalFloat(oItem,"EntranceExitX");
    DeleteLocalFloat(oItem,"EntranceExitY");
    DeleteLocalString(oItem,"CustomFlag");
    DeleteLocalString(oItem,"ParentChildSlot");

    if (GetIsPC(GetItemPossessor(oItem))) {
        DeleteLocalInt(oItem, "CT_DESTRUCT_TIME");
    }

    if((GetIdentified(oItem) == FALSE)&&(GetTag(oItem) == "te_garlici"))
    {
        SetIdentified(oItem,TRUE);
    }

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
