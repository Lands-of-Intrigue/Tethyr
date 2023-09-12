//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_deposit
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
    object oPC = GetPCSpeaker(), oBanker = OBJECT_SELF;
    string sID = SF_GetPlayerID(oPC);
    string sBank = GetLocalString(OBJECT_SELF,"Town");
    string sAmount = GetLocalString(oBanker, "GOLD");
    int nAmount = StringToInt(sAmount);
    int nTotal;
    int nTax;
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nPiety = GetLocalInt(oItem,"nPiety");

    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1 && GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) < 1)
    {
        nTax = nAmount*(10+GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Tax"))/100;
    }
    else
    {
        nTax = nAmount*GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Tax")/100;
    }

    int nTowntax;
    int nHolding = GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Holding");
    // Anti-Cheat Check For Duping Gold
    if (GetGold(oPC) >= nAmount)
    {
         if(nAmount <= 10)
         {
            SetLocalInt(oBanker,"ANTI_CHEAT",TRUE);
         }
         else
         {
             if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1 && GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) < 1)
             {
                if(nPiety != 0 && nPiety <= 55 && nAmount >= 1000)
                {
                    SendMessageToPC(oPC,"Your actions have increased your piety to "+IntToString(nPiety+5)+ " out of 100.");
                    SetLocalInt(oItem,"nPiety",nPiety+5);
                    if(GetLocalInt(oItem,"nPiety") < 0)     {SetLocalInt(oItem,"nPiety",0);}
                    if(GetLocalInt(oItem,"nPiety") > 100)   {SetLocalInt(oItem,"nPiety",100);}
                }
             }
            // Take the deposited amount from the player and store
            // in the database
            TakeGoldFromCreature(nAmount, oPC, TRUE);
            int nBanked = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + GetLocalString(OBJECT_SELF, "Town"));
            nTotal = nAmount + nBanked - nTax;
            SetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + GetLocalString(OBJECT_SELF, "Town"), nTotal);
            SetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Coffers", GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Coffers") + nTax);
            SetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Holding", nHolding+nAmount);

            string sReturn = "**"+GetName(oPC)+"** ("+GetPCPlayerName(oPC)+"/"+GetPCPublicCDKey(oPC)+") depositing "+sAmount+" into bank account. **Account Balance:** "+IntToString(nTotal)+" **Total Gold in Holding:** "+IntToString(nHolding+nAmount-nTax)+" **Tax Collected:** "+IntToString(nTax);

            NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL, sReturn, sBank);
        }
    }
    else // Set Anti-Cheat Variable
        SetLocalInt(oBanker, "ANTI_CHEAT", TRUE);

    // Set custom token
    SetCustomToken(1000, IntToString(nTotal));
}
