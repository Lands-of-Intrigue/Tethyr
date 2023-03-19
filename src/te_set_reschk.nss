int StartingConditional()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));
    string sResource = GetCampaignString("Settlement",(sSettlement+"_sResource"));

    if(sResource == "")
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }

}
