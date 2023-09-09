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
    int nWithdraw = StringToInt(GetLocalString(OBJECT_SELF, "GOLD"));
    string sBank = GetLocalString(OBJECT_SELF,"Town");
    int nBanked = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + GetLocalString(OBJECT_SELF, "Town"));
    int nHolding = GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Holding");

    // Give the amount required to he player and store in the database
    GiveGoldToCreature(oPC, nWithdraw);
    int nTotal = nBanked - nWithdraw;
    SetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + GetLocalString(OBJECT_SELF, "Town"), nTotal);
    SetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Holding", nHolding-nWithdraw);

    string sReturn = "**"+GetName(oPC)+"** ("+GetPCPlayerName(oPC)+"/"+GetPCPublicCDKey(oPC)+") withdrawing "+IntToString(nWithdraw)+" from bank account. **Account Balance:** "+IntToString(nTotal)+" **Total Gold in Holding:** "+IntToString(nHolding-nWithdraw);

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL, sReturn, sBank);

    // Set custom token
    SetCustomToken(1000, IntToString(nTotal));
}
