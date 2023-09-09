#include "te_settle_inc"

void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetCampaignString("Settlement",(sSettlement+"_sOwner"),"sSwamp");
    SetCampaignString("Settlement",(sSettlement+"_sBank"),"SR001");
    SetCustomToken(8046,"Barony of Swamprise Keep");
    UpdateOwnership(sSettlement,"sSwamp");
}
