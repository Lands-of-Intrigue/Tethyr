#include "te_settle_inc"

void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    SetupSettlementToken(sSettlement);
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));
    SetupOwnerToken(sOwner);
    int nPeasant = GetCampaignInt("Settlement",(sSettlement+"_nPeasant"));
    SetCustomToken(8048,IntToString(nPeasant));
    int nSoldier = GetCampaignInt("Settlement",(sSettlement+"_nSoldier"));
    SetCustomToken(8049,IntToString(nSoldier));
    int nKnight = GetCampaignInt("Settlement",(sSettlement+"_nKnight"));
    SetCustomToken(8050,IntToString(nKnight));
    string sResource = GetCampaignString("Settlement",(sSettlement+"_sResource"));
    SetupResourceToken(sResource);
    string sBank = GetCampaignString("Settlement",(sSettlement+"_sBank"));
    SetCustomToken(8047,sBank);

    int iLandlord = GetCampaignInt("Settlement",(sSettlement+"_sLandlord"));

    if(iLandlord == 1)
    {
        SetCustomToken(8033,"Receiving Landlord Bonus");

    }
    else
    {
        SetCustomToken(8033,"No Landlord Bonus");
    }

    int iLeadership = GetCampaignInt("Settlement",(sSettlement+"_sLeadership"));

    if(iLeadership == 1)
    {
        SetCustomToken(8032,"Receiving Leadership Bonus");

    }
    else
    {
        SetCustomToken(8032,"No Leadership Bonus");
    }


    int nCost = ((nPeasant*5)+(nSoldier*-5)+(nKnight*-50));
    SetCustomToken(8051,IntToString(nCost));
}

