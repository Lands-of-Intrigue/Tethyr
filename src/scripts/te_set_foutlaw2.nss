#include "te_settle_inc"
void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetCampaignString("Settlement",(sSettlement+"_sOwner"),"sOutlaw2");
    SetCampaignString("Settlement",(sSettlement+"_sBank"),"OL001");
    SetCustomToken(8046,"Brost Bandits");
    UpdateOwnership(sSettlement,"sOut2");
}
