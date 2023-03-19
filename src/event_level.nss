#include "nwnx_events"
#include "nwnx_time"
#include "nwnx_util"
#include "nwnx_webhook_rch"
#include "nwnx_object"

void main()
{
    object oPC = OBJECT_SELF;
    string sCurrentEvent = NWNX_Events_GetCurrentEvent();
    if (sCurrentEvent == "NWNX_ON_LEVEL_UP_AFTER")
    {
        struct NWNX_WebHook_Message stMessage;
        stMessage.sUsername = "Player Event";
        stMessage.sTitle = "New Level!";
        stMessage.sAuthorName = GetName(oPC);
        stMessage.sDescription = "**" + GetName(oPC) + "** has reached level **"+IntToString(GetHitDice(oPC))+"**!";
        stMessage.sFooterText = "Knights of Noromath Player Event";
        stMessage.sField1Name = "Playername";
        stMessage.sField1Value = GetPCPlayerName(oPC);
        stMessage.iField1Inline = TRUE;
        stMessage.sField2Name = "IP";
        stMessage.sField2Value = GetPCIPAddress(oPC);
        stMessage.iField2Inline = TRUE;
        stMessage.sField3Name = "CDKey";
        stMessage.sField3Value = GetPCPublicCDKey(oPC);
        stMessage.iField3Inline = TRUE;
        stMessage.iTimestamp = NWNX_Time_GetTimeStamp();
        string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discordapp.com", WEBHOOK_EVENT_CHANNEL, stMessage);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com",WEBHOOK_EVENT_CHANNEL, sConstructedMsg);
    }
}
