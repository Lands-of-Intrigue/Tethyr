#include "nwnx_webhook"

//oPC == Object you wish to give XP to. Only PCs have multiclassing penalty.
//nXPToGive == Amount of XP Reward. If negative, multiclassing penalty will never be calculated or looked at.
//nMulticlass == TRUE for assessing multiclassing penalty. Default = 0/False.
void GiveTrueXPToCreature(object oPC, int nXPToGive, int nMulticlass)
{
    if(nXPToGive < 0)
    {
        SetXP(oPC,GetXP(oPC)+(nXPToGive));
    }
    else
    {
        if(nMulticlass == TRUE)
        {
            object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
            if(GetLocalInt(oItem,"iMulticlass") == TRUE)
            {
                nXPToGive = (nXPToGive - FloatToInt(IntToFloat(nXPToGive)*0.20));
                SetXP(oPC,GetXP(oPC)+nXPToGive);
            }
            else
            {
                SetXP(oPC,GetXP(oPC)+(nXPToGive));
            }
        }
        else
        {
            SetXP(oPC,GetXP(oPC)+(nXPToGive));
        }
    }
}
//::///////////////////////////////////////////////
//:: FileName te_bounties
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/25/2018 3:26:35 AM
//:://////////////////////////////////////////////
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
        if(GetResRef(oItemToTake) == "te_bount001")
        {
            nGold += 16;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount002")
        {
            nGold += 75;
            DestroyObject(oItemToTake);
        }

        if(GetResRef(oItemToTake) == "te_bount003")
        {
            nGold += 25;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount004")
        {
            nGold += 32;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount005")
        {
            nGold += 100;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount006")
        {
            nGold += 50;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount007")
        {
            nGold += 100;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount008")
        {
            nGold += 250;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount009")
        {
            nGold += 20;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount010")
        {
            nGold += 30;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount011")
        {
            nGold += 60;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount012")
        {
            nGold += 300;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount014")
        {
            nGold += 50;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount015")
        {
            nGold += 80;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount016")
        {
            nGold += 60;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount017")
        {
            nGold += 150;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount018")
        {
            nGold += 300;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount019")
        {
            nGold += 50;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount020")
        {
            nGold += 30;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount021")
        {
            nGold += 40;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount022")
        {
            nGold += 180;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount023")
        {
            nGold += 40;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_item_01029"||GetResRef(oItemToTake) == "te_bount033")
        {
            nGold += 58;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "summonersmanual")
        {
            nGold += 100;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "it_msmlmisc008")
        {
            nGold += 60;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount024")
        {
            nGold += 25;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount025")
        {
            nGold += 75;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount026")
        {
            nGold += 100;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount027")
        {
            nGold += 60;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount028")
        {
            nGold += 26;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount029")
        {
            nGold += 20;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount030")
        {
            nGold += 80;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount031")
        {
            nGold += 75;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bount032")
        {
            nGold += 80;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bounty033")
        {
            nGold += 80;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bounty034")
        {
            nGold += 60;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bounty035")
        {
            nGold += 75;
            DestroyObject(oItemToTake);
        }
        if(GetResRef(oItemToTake) == "te_bounty036")
        {
            nGold += 75;
            DestroyObject(oItemToTake);
        }
        oItemToTake = GetNextItemInInventory(oPC);
    }

    nTax = nGold*GetCampaignInt(GetName(GetModule()), sTown + "Tax")/100;
    nTaxAmount = (nGold - (nGold / 2) + nTax);
    nRemain =(nGold - nTaxAmount);

    SetCampaignInt(GetName(oMod),sTownC,GetCampaignInt(GetName(GetModule()),sTownC)+nTaxAmount);
    SetCampaignInt(GetName(oMod),sTownH,GetCampaignInt(GetName(GetModule()),sTownH)+nTaxAmount);
    GiveGoldToCreature(oPC,nRemain);
    GiveTrueXPToCreature(oPC,nGold/10,0);

    string sReturn = "**"+GetName(oPC)+"** ("+GetPCPlayerName(oPC)+"/"+GetPCPublicCDKey(oPC)+") turned in bounties worth "+IntToString(nGold)+" gold, adding "+IntToString(nTax)+" in taxes to the holding. **Total Gold in Coffers:** "+IntToString(GetCampaignInt(GetName(GetModule()),sTownC))+" **Total Gold in Holding:** "+IntToString(GetCampaignInt(GetName(GetModule()),sTownH));
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL, sReturn, sTown);
}
