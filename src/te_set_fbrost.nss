#include "te_settle_inc"
void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetCampaignString("Settlement",(sSettlement+"_sOwner"),"sBrost");
    SetCampaignString("Settlement",(sSettlement+"_sBank"),"BR001");
    SetCustomToken(8046,"Mayorship of Brost");
    UpdateOwnership(sSettlement,"sBrost");
}
