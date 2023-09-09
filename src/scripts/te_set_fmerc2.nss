#include "te_settle_inc"
void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetCampaignString("Settlement",(sSettlement+"_sOwner"),"sMerc2");
    SetCampaignString("Settlement",(sSettlement+"_sBank"),"");
    SetCustomToken(8046,"Independent Control 2");
    UpdateOwnership(sSettlement,"sMerc2");
}
