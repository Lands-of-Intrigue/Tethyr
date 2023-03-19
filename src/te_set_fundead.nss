#include "te_settle_inc"
void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetCampaignString("Settlement",(sSettlement+"_sOwner"),"sUndead");
    SetCampaignString("Settlement",(sSettlement+"_sBank"),"UD001");
    SetCustomToken(8046,"Bank of Shoon");
    UpdateOwnership(sSettlement,"sUndead");
}
