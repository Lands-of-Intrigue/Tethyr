#include "te_settle_inc"
void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetCampaignString("Settlement",(sSettlement+"_sOwner"),"sOutlaw1");
    SetCampaignString("Settlement",(sSettlement+"_sBank"),"OL001");
    SetCustomToken(8046,"Lockwood Knives");
    UpdateOwnership(sSettlement,"sOutlaw1");
}
