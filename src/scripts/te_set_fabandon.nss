#include "te_settle_inc"
void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetCampaignString("Settlement",(sSettlement+"_sOwner"),"sAbandon");
    SetCampaignString("Settlement",(sSettlement+"_sBank"),"");
    SetCustomToken(8046,"Abandoned");
    UpdateOwnership(sSettlement,"");
}
