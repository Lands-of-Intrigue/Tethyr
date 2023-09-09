#include "te_settle_inc"

void main()
{
    object oSettlement = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oItem = CreateItemOnObject("te_insignia004",oPC,1,"te_insignia");
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetName(oItem,"Insignia of "+GetSettlementName(sOwner));
    SetLocalString(oItem,"Settlement",sOwner);
    SetDescription(oItem,"The Baron of "+GetSettlementName(sOwner)+" has entrusted this shining insignia to you, marking you as a servant of the Barony and as a sign of their trust in you.");
    SetIdentified(oItem,TRUE);
}
