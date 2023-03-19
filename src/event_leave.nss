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
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    string sJoinMsg = GetPCPlayerName(oPC)+" ("+GetName(oPC)+"/"+GetPCPublicCDKey(oPC) + ") has left the server.";
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sJoinMsg, GetName(oPC));
}
