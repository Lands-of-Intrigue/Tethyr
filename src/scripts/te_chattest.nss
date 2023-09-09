#include "nwnx_chat"
#include "te_functions"
#include "nwnx_webhook"
#include "nwnx_webhook_rch"
#include "nwnx_time"
#include "nwnx_rename"
#include "te_lang"

void DiscordChatMessage(int nChannel,object oSender, object oTarget,string sMessage);


void main()
{
    int nChannel = NWNX_Chat_GetChannel();
    object oSender = NWNX_Chat_GetSender();
    string sCDKey = " ("+GetPCPlayerName(oSender)+"/"+GetPCPublicCDKey(oSender)+")";
    object oTarget = NWNX_Chat_GetTarget();
    string sMessage = NWNX_Chat_GetMessage();
    string sMsg = NWNX_Chat_GetMessage();
    sMsg = StringReplace(sMsg,"\"","'");
    object oPC;

    string sName = GetName(oSender);

    if (GetLocalInt(oSender,"iDisguise") == 1)
    {
        sName = GetLocalString(oSender,"sOriginalName");
        sName = sName +" (Disguised as "+NWNX_Rename_GetPCNameOverride(oSender)+")";
    }

    string sPreT = WHITE+sName+" ("+GetName(GetArea(oSender))+") SAYS:\n";
    string sPreS = YELLOW+sName+" ("+GetName(GetArea(oSender))+") SHOUTS:\n";
    string sPreW = LIGHTGREY+sName+" ("+GetName(GetArea(oSender))+") WHISPERS:\n";
    string sTELL = NEONGREEN+sName+sCDKey+" PM to "+GetName(oTarget)+":\n";

    string sWebTalk  = "**"+sCDKey+" ("+GetName(GetArea(oSender))+") SAYS:** "+sMsg;
    string sWebShout  = "**"+sCDKey+" ("+GetName(GetArea(oSender))+") SHOUTS:** "+sMsg;
    string sWebWhisp = "**"+sCDKey+" ("+GetName(GetArea(oSender))+") WHISPERS:** "+sMsg;
    string sWebTell  = GetName(oSender)+sCDKey+" PM to "+GetName(oTarget)+": "+sMsg;
    string sWebDM    = "**"+sCDKey+":** "+sMsg;

    //WriteTimestampedLogEntry("CHATTEST FIRED!");

    if(nChannel == NWNX_CHAT_CHANNEL_SERVER_MSG)
    {
        //WriteTimestampedLogEntry("SERVER MSG FIRED!");
        NWNX_Chat_SkipMessage();
    }
    else if(nChannel == NWNX_CHAT_CHANNEL_PLAYER_TALK)
    {
        //WriteTimestampedLogEntry("PLAYER TALK FIRED!");
        sMsg = sPreT + sMsg;

        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sWebTalk, GetName(oSender));
        //DiscordChatMessage(NWNX_CHAT_CHANNEL_PLAYER_TALK,oSender,oTarget,sMessage);
        oPC = GetFirstPC();
        while (GetIsObjectValid(oPC))
        {
            if (GetIsDM(oPC)||GetIsDMPossessed(oPC))
            {
                NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_SERVER_MSG,sMsg,oSender,oPC);
            }
            oPC = GetNextPC();
        }
    }
    else if(nChannel == NWNX_CHAT_CHANNEL_PLAYER_SHOUT)
    {
        //WriteTimestampedLogEntry("PLAYER TALK FIRED!");
        sMsg = sPreT + sMsg;

        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sWebShout, GetName(oSender));
        //DiscordChatMessage(NWNX_CHAT_CHANNEL_PLAYER_TALK,oSender,oTarget,sMessage);
        oPC = GetFirstPC();
        while (GetIsObjectValid(oPC))
        {
            if (GetIsDM(oPC)||GetIsDMPossessed(oPC))
            {
                NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_SERVER_MSG,sMsg,oSender,oPC);
            }
            oPC = GetNextPC();
        }

    }
    else if(nChannel == NWNX_CHAT_CHANNEL_PLAYER_WHISPER)
    {
        //WriteTimestampedLogEntry("PLAYER WHISPER FIRED!");
        sMsg = sPreW + sMsg;

        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sWebWhisp, GetName(oSender));
        //DiscordChatMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,oSender,oTarget,sMessage);
        oPC = GetFirstPC();
        while (GetIsObjectValid(oPC))
        {
            if (GetIsDM(oPC)||GetIsDMPossessed(oPC))
            {
                NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_SERVER_MSG,sMsg,oSender,oPC);
            }
            oPC = GetNextPC();
        }
    }
    else if(nChannel == NWNX_CHAT_CHANNEL_PLAYER_TELL)
    {
        //WriteTimestampedLogEntry("PLAYER TELL FIRED!");
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_TELL_CHANNEL, sWebTell, GetName(oSender));
        //DiscordChatMessage(NWNX_CHAT_CHANNEL_PLAYER_TELL,oSender,oTarget,sMessage);
        sMsg = sTELL + sMsg;
        oPC = GetFirstPC();
        while (GetIsObjectValid(oPC))
        {
            if ( (GetIsDM(oPC) || GetIsDMPossessed(oPC) )&&( GetPCPublicCDKey(oPC) == "QR4HT9C7" || GetPCPublicCDKey(oPC) == "UPQQH4EC" || GetPCPublicCDKey(oPC) == "UPFC3F3Q" || GetPCPublicCDKey(oPC) == "UPWUXUCP" || GetPCPublicCDKey(oPC) == "UPFJUTJ"))
            {
                NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_SERVER_MSG,sMsg,oSender,oPC);
            }
            oPC = GetNextPC();
        }

    }
    else if(nChannel == NWNX_CHAT_CHANNEL_PLAYER_DM)
    {
        //WriteTimestampedLogEntry("PLAYER DM FIRED!");
        //NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_DM,sMsg,oTarget,oSender);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_DM_CHANNEL, sWebDM, GetName(oSender));
        //DiscordChatMessage(NWNX_CHAT_CHANNEL_PLAYER_DM,oSender,oTarget,sMessage);
    }
    else if(nChannel == 13)
    {
        //WriteTimestampedLogEntry("CHANNEL 13 FIRED!");
    }

}


void DiscordChatMessage(int nChannel,object oSender, object oTarget,string sMessage)
{
    object oArea = GetArea(oSender);
    string sName = GetName(oSender);
    if (GetLocalInt(oSender,"iDisguise") == 1)
    {
        sName = sName +"Disguised: ("+GetLocalString(oSender,"sOriginalName")+")";
    }

    struct NWNX_WebHook_Message stMessage;

    if(nChannel == NWNX_CHAT_CHANNEL_PLAYER_DM)
    {
        stMessage.sUsername = "Username Test: DM Message";
        stMessage.sText = "Text Title Test";
        stMessage.sTitle = "Test Title";
        stMessage.sAuthorName = sName;
        stMessage.sDescription = sMessage;
        stMessage.sFooterText = "Footer Text Test";
        stMessage.sField1Name = "Area";
        stMessage.sField1Value = GetName(oArea);
        stMessage.iField1Inline = TRUE;
        stMessage.sField2Name = "CDKey";
        stMessage.sField2Value = GetPCPublicCDKey(oSender);
        stMessage.iField2Inline = TRUE;
        stMessage.sField3Name = "IP";
        stMessage.sField3Value = GetPCIPAddress(oSender);
        stMessage.iField3Inline = TRUE;
        stMessage.iTimestamp = NWNX_Time_GetTimeStamp();

        string sDMMessage = NWNX_WebHook_BuildMessageForWebHook("discordapp.com",WEBHOOK_DM_CHANNEL, stMessage);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_DM_CHANNEL, sDMMessage);
    }
    else if( nChannel == NWNX_CHAT_CHANNEL_PLAYER_TALK )
    {
        stMessage.sUsername = "Username Test: Talk Message";
        stMessage.sText = "Text Title Test";
        stMessage.sTitle = "Test Title";
        stMessage.sAuthorName = sName;
        stMessage.sDescription = sMessage;
        stMessage.sFooterText = "Footer Text Test";
        stMessage.sField1Name = "Area";
        stMessage.sField1Value = GetName(oArea);
        stMessage.iField1Inline = TRUE;
        stMessage.sField2Name = "CDKey";
        stMessage.sField2Value = GetPCPublicCDKey(oSender);
        stMessage.iField2Inline = TRUE;
        stMessage.sField3Name = "IP";
        stMessage.sField3Value = GetPCIPAddress(oSender);
        stMessage.iField3Inline = TRUE;
        stMessage.iTimestamp = NWNX_Time_GetTimeStamp();

        string sPCMessage = NWNX_WebHook_BuildMessageForWebHook("discordapp.com",WEBHOOK_DM_CHANNEL, stMessage);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sPCMessage);
    }
    else if(nChannel == NWNX_CHAT_CHANNEL_PLAYER_WHISPER)
    {
        stMessage.sUsername = "Username Test: Whisper Message";
        stMessage.sText = "Text Title Test";
        stMessage.sTitle = "Test Title";
        stMessage.sAuthorName = sName;
        stMessage.sDescription = sMessage;
        stMessage.sFooterText = "Footer Text Test";
        stMessage.sField1Name = "Area";
        stMessage.sField1Value = GetName(oArea);
        stMessage.iField1Inline = TRUE;
        stMessage.sField2Name = "CDKey";
        stMessage.sField2Value = GetPCPublicCDKey(oSender);
        stMessage.iField2Inline = TRUE;
        stMessage.sField3Name = "IP";
        stMessage.sField3Value = GetPCIPAddress(oSender);
        stMessage.iField3Inline = TRUE;
        stMessage.iTimestamp = NWNX_Time_GetTimeStamp();

        string sPCWhisMessage = NWNX_WebHook_BuildMessageForWebHook("discordapp.com",WEBHOOK_DM_CHANNEL, stMessage);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sPCWhisMessage);
    }
    else if(nChannel == NWNX_CHAT_CHANNEL_PLAYER_TELL)
    {
        string sTarName = GetName(oTarget);
        if (GetLocalInt(oTarget,"iDisguise") == 1)
        {
            sTarName = sTarName +"Disguised: ("+GetLocalString(oTarget,"sOriginalName")+")";
        }

        stMessage.sUsername = "Username Test: Tell Message";
        stMessage.sText = "Text Title Test";
        stMessage.sTitle = "Test Title";
        stMessage.sAuthorName = sName;
        stMessage.sDescription = sMessage;
        stMessage.sFooterText = "Footer Text Test";
        stMessage.sField1Name = "Area";
        stMessage.sField1Value = GetName(oArea);
        stMessage.iField1Inline = TRUE;
        stMessage.sField2Name = "CDKey";
        stMessage.sField2Value = GetPCPublicCDKey(oSender);
        stMessage.iField2Inline = TRUE;
        stMessage.sField3Name = "IP";
        stMessage.sField3Value = GetPCIPAddress(oSender);
        stMessage.iField3Inline = TRUE;
        stMessage.sField3Name = "Recipient";
        stMessage.sField3Value = sTarName;
        stMessage.iField3Inline = TRUE;
        stMessage.iTimestamp = NWNX_Time_GetTimeStamp();

        string sPCTellMessage = NWNX_WebHook_BuildMessageForWebHook("discordapp.com",WEBHOOK_DM_CHANNEL, stMessage);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_TELL_CHANNEL, sPCTellMessage);
    }
}
