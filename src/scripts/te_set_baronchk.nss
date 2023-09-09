int StartingConditional()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    if((sSettlement == "sLock")||(sSettlement == "sTejarn")||(sSettlement == "sSpire")||(sSettlement == "sSwamp")||(sSettlement == "sBrost"))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }

}
