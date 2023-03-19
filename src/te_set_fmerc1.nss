#include "te_settle_inc"
void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetCampaignString("Settlement",(sSettlement+"_sOwner"),"sMerc1");
    SetCampaignString("Settlement",(sSettlement+"_sBank"),"GL001");
    SetCustomToken(8046,"Golden Lion Company");
    UpdateOwnership(sSettlement,"sMerc1");
}
