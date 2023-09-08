void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    int nKnight = GetCampaignInt("Settlement",(sSettlement+"_nKnight"));

    nKnight = nKnight+5;
    SetCampaignInt("Settlement",(sSettlement+"_nKnight"),nKnight);

    SetCustomToken(8049,IntToString(nKnight));
}
