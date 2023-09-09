void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    int iLandlord = GetCampaignInt("Settlement",(sSettlement+"_sLandlord"));

    if(iLandlord == 1)
    {
        SetCampaignInt("Settlement",(sSettlement+"_sLandlord"),0);
        SetCustomToken(8033,"no Landlord Bonus");
    }
    else
    {
        SetCampaignInt("Settlement",(sSettlement+"_sLandlord"),1);
        SetCustomToken(8033,"a Landlord Bonus");
    }

}
