void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    int iLeadership = GetCampaignInt("Settlement",(sSettlement+"_sLeadership"));

    if(iLeadership == 1)
    {
        SetCampaignInt("Settlement",(sSettlement+"_sLeadership"),0);
        SetCustomToken(8032,"no Leadership Bonus");
    }
    else
    {
        SetCampaignInt("Settlement",(sSettlement+"_sLeadership"),1);
        SetCustomToken(8032,"a Leadership Bonus");
    }

}
