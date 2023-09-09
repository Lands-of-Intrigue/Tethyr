#include "nwnx_chat"
#include "nwnx_webhook"

void main()
{
    object oPC = GetPCSpeaker();
    string sLocation = GetLocalString(OBJECT_SELF,"sLocation");
    object oPlayer = GetFirstPC();
    SendMessageToAllDMs("The Bell of "+sLocation+" rings out four times!");
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BELL, "The Bell of "+sLocation+" rings out four times!", sLocation);
    while(GetIsObjectValid(oPlayer))
    {
        if(GetIsAreaAboveGround(GetArea(oPlayer)) == TRUE)
        {
            NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_DM_SHOUT,"<c¡¥ >The Bell of "+sLocation+" rings out four times!</c>",OBJECT_SELF,oPlayer);
            AssignCommand(oPlayer,PlaySound("as_cv_bell2"));
        }
        oPlayer = GetNextPC();
    }


}
