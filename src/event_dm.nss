#include "nwnx_events"
#include "nwnx_time"
#include "nwnx_util"
#include "nwnx_webhook_rch"
#include "nwnx_object"

void main()
{
    object oPC = OBJECT_SELF;
    string sCurrentEvent = NWNX_Events_GetCurrentEvent();

    object oTarget = NWNX_Object_StringToObject(NWNX_Events_GetEventData("OBJECT"));
    int iAmount = StringToInt(NWNX_Events_GetEventData("AMOUNT"));

    struct NWNX_WebHook_Message stMessage;
    stMessage.sUsername = "DM Modification Event";

    if (sCurrentEvent == "NWNX_ON_DM_GIVE_GOLD_AFTER")
    {
        stMessage.sTitle = "Giving Gold!";
        stMessage.sColor = "#0000FF";
        stMessage.sAuthorName = GetName(oPC);
        stMessage.sDescription = "**" + GetName(oTarget) + "** has been awarded **"+IntToString(iAmount)+"** gold!";
        stMessage.sFooterText = "Knights of Noromath Player Event";
        stMessage.iTimestamp = NWNX_Time_GetTimeStamp();
        string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discordapp.com", WEBHOOK_EVENT_CHANNEL, stMessage);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com",WEBHOOK_EVENT_CHANNEL, sConstructedMsg);
    }
    else if (sCurrentEvent == "NWNX_ON_DM_GIVE_XP_AFTER")
    {
        stMessage.sTitle = "Giving XP!";
        stMessage.sColor = "#0000FF";
        stMessage.sAuthorName = GetName(oPC);
        stMessage.sDescription = "**" + GetName(oTarget) + "** has been awarded **"+IntToString(iAmount)+"** XP!";
        stMessage.sFooterText = "Knights of Noromath Player Event";
        stMessage.iTimestamp = NWNX_Time_GetTimeStamp();
        string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discordapp.com", WEBHOOK_EVENT_CHANNEL, stMessage);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com",WEBHOOK_EVENT_CHANNEL, sConstructedMsg);
    }
    else if (sCurrentEvent == "NWNX_ON_DM_GIVE_LEVEL_AFTER")
    {
        stMessage.sTitle = "Giving Levels!";
        stMessage.sColor = "#0000FF";
        stMessage.sAuthorName = GetName(oPC);
        stMessage.sDescription = "**" + GetName(oTarget) + "** has been awarded **"+IntToString(iAmount)+"** levels!";
        stMessage.sFooterText = "Knights of Noromath Player Event";
        stMessage.iTimestamp = NWNX_Time_GetTimeStamp();
        string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discordapp.com", WEBHOOK_EVENT_CHANNEL, stMessage);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com",WEBHOOK_EVENT_CHANNEL, sConstructedMsg);
    }
    else if (sCurrentEvent == "NWNX_ON_DM_GIVE_ALIGNMENT_AFTER")
    {
        string nAlignment = NWNX_Events_GetEventData("ALIGNMENT_TYPE");

        stMessage.sTitle = "Giving Alignment Change!";
        stMessage.sColor = "#0000FF";
        stMessage.sAuthorName = GetName(oPC);
        stMessage.sDescription = "**" + GetName(oTarget) + "** has had their alignment modified by **"+IntToString(iAmount)+"** towards **"+nAlignment+"**!";
        stMessage.sFooterText = "Knights of Noromath Player Event";
        stMessage.iTimestamp = NWNX_Time_GetTimeStamp();
        string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discordapp.com", WEBHOOK_EVENT_CHANNEL, stMessage);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com",WEBHOOK_EVENT_CHANNEL, sConstructedMsg);
    }

}
