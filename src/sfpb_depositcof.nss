//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_withdraw
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////
#include "nwnx_webhook"
#include "sfpb_config"
void main()
{
    // Vars
    object oPC = GetPCSpeaker();
    string sID = SF_GetPlayerID(oPC);
    string sBank = GetLocalString(OBJECT_SELF,"Town");
    int nDeposit = StringToInt(GetLocalString(OBJECT_SELF, "GOLD"));
    int nBanked = GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Coffers");
    int nHolding = GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Holding");
    // Give the amount required to he player and store in the database
    if(GetGold(oPC) >= nDeposit)
    {

        int nTotal = nBanked + nDeposit;
        SetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Coffers", nTotal);
        SetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Holding",nHolding+nTotal);
        TakeGoldFromCreature(nDeposit, oPC, TRUE);

        string sReturn = "**"+GetName(oPC)+"** ("+GetPCPlayerName(oPC)+"/"+GetPCPublicCDKey(oPC)+") depositing "+IntToString(nDeposit)+" into settlement account. **Coffers:** "+IntToString(nTotal)+" **Total Gold in Holding:** "+IntToString(nHolding+nTotal);

        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL, sReturn, sBank);

    }
    else
        SetLocalInt(OBJECT_SELF, "ANTI_CHEAT", TRUE);

    // Set custom token
    SetCustomToken(1000, IntToString(nDeposit));
}
