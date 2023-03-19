void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    int nSoldier = GetCampaignInt("Settlement",(sSettlement+"_nSoldier"));

    nSoldier = nSoldier-5;
    SetCampaignInt("Settlement",(sSettlement+"_nSoldier"),nSoldier);

    SetCustomToken(8049,IntToString(nSoldier));
}
