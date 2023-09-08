#include "te_settle_inc"
void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetCampaignString("Settlement",(sSettlement+"_sOwner"),"sTejarn");
    SetCampaignString("Settlement",(sSettlement+"_sBank"),"TG001");
    SetCustomToken(8046,"Barony of Tejarn Gate");
    UpdateOwnership(sSettlement,"sTejarn");
}
