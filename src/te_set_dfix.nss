#include "nwnx_webhook"

void main()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;
    string sUnique       = GetLocalString(oDoor,"sUnique");    //Unique ID for Settlement
    string sOwner        = GetLocalString(oDoor,"sOwner");                              //Owner ID / Settlement that owns this location.
    string sBank         = GetCampaignString("Settlement",sOwner+"_sBank");             //Bank ID associated with settlement that owns this location.
    int nLockDC          = GetCampaignInt("Housing",sUnique+"Lock");                    //The DC for trying to unlock this door using Open Lock skill.
    int nDoorDC          = GetCampaignInt("Housing",sUnique+"Door");                    //The DC for trying to bust down this door using STR.

    int nBanked = GetCampaignInt(GetName(GetModule()), sBank + "Coffers");
    int nHolding = GetCampaignInt(GetName(GetModule()), sBank + "Holding");

    int nFixCost = 250+(10*(nLockDC+nDoorDC));

    int nTotal = nBanked - nFixCost;


    SetCampaignInt(GetName(GetModule()), sBank + "Coffers", nTotal);
    SetCampaignInt(GetName(GetModule()), sBank + "Holding", nHolding-nFixCost);

    string sReturn = "**"+GetName(oPC)+"** ("+GetPCPlayerName(oPC)+"/"+GetPCPublicCDKey(oPC)+") withdrawing "+IntToString(nFixCost)+" from settlement account to fix door "+sUnique+". **Coffers:** "+IntToString(nTotal)+" **Total Gold in Holding:** "+IntToString(nHolding-nFixCost);
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL, sReturn, sBank);

    SetCampaignInt("Housing",sUnique+"Brok",0);
    SetLocked(oDoor,TRUE);
}
