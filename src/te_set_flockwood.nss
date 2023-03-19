#include "te_settle_inc"
void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetCampaignString("Settlement",(sSettlement+"_sOwner"),"sLock");
    SetCampaignString("Settlement",(sSettlement+"_sBank"),"LW001");
    SetCustomToken(8046,"Barony of Lockwood Falls");
    UpdateOwnership(sSettlement,"sLock");
}
