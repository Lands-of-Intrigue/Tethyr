//::///////////////////////////////////////////////
//:: FileName te_bounties
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/25/2018 3:26:35 AM
//:://////////////////////////////////////////////
#include "nwnx_webhook"
void main()
{
    // Remove items from the player's inventory
    object oPC = GetPCSpeaker();
    object oMod = GetModule();
    object oItemToTake = GetFirstItemInInventory(oPC);
    int nGold = 0;
    int nTax = 0;
    int nTaxAmount =0;
    int nRemain = 0;

    string sTown = GetLocalString(OBJECT_SELF,"Town");
    string sTownC = sTown+"Coffers";
    string sTownH = sTown+"Holding";

    while (oItemToTake != OBJECT_INVALID)
    {
            if(GetResRef(oItemToTake) == "te_item_0018")
            {
                nGold += 50;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8211")
            {
                nGold += 100;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8212")
            {
                nGold += 125;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8213")
            {
                nGold += 150;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8214")
            {
                nGold += 50;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8215")
            {
                nGold += 75;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8216")
            {
                nGold += 100;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_0013")
            {
                nGold += 75;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_0014")
            {
                nGold += 25;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_0005")
            {
                nGold += 50;
                DestroyObject(oItemToTake);
            }
            //////
            if(GetResRef(oItemToTake) == "te_item_8727")
            {
                nGold += 2500;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8728")
            {
                nGold += 350;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8729")
            {
                nGold += 525;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8730")
            {
                nGold += 700;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8731")
            {
                nGold += 275;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8732")
            {
                nGold += 1250;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8733")
            {
                nGold += 350;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8734")
            {
                nGold += 350;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8735")
            {
                nGold += 525;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8736")
            {
                nGold += 275;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8737")
            {
                nGold += 350;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8738")
            {
                nGold += 275;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8739")
            {
                nGold += 700;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8740")
            {
                nGold += 525;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8741")
            {
                nGold += 700;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8742")
            {
                nGold += 1250;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8743")
            {
                nGold += 875;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8744")
            {
                nGold += 700;
                DestroyObject(oItemToTake);
            }
            if(GetResRef(oItemToTake) == "te_item_8745")
            {
                nGold += 3500;
                DestroyObject(oItemToTake);
            }

        oItemToTake = GetNextItemInInventory(oPC);
    }

    nTax = nGold*GetCampaignInt(GetName(GetModule()), sTown + "Tax")/100;
    nRemain =(nGold - nTax);

    SetCampaignInt(GetName(oMod),sTownC,GetCampaignInt(GetName(GetModule()),sTownC)+nTax);
    SetCampaignInt(GetName(oMod),sTownH,GetCampaignInt(GetName(GetModule()),sTownH)+nTax);
    GiveGoldToCreature(oPC,nRemain);

    string sReturn = "**"+GetName(oPC)+"** ("+GetPCPlayerName(oPC)+"/"+GetPCPublicCDKey(oPC)+") scavanged "+IntToString(nGold)+" gold, adding "+IntToString(nTax)+" in taxes to the holding. **Total Gold in Coffers:** "+IntToString(GetCampaignInt(GetName(GetModule()),sTownC))+" **Total Gold in Holding:** "+IntToString(GetCampaignInt(GetName(GetModule()),sTownH));
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL, sReturn, sTown);
}
