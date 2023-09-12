void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    int nPeasant = GetCampaignInt("Settlement",(sSettlement+"_nPeasant"));

    nPeasant = nPeasant-5;
    SetCampaignInt("Settlement",(sSettlement+"_nPeasant"),nPeasant);

    SetCustomToken(8048,IntToString(nPeasant));
}
