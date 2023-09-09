#include "te_settle_inc"
void main()
{
    object oSettlement = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oItem = CreateItemOnObject("te_item_8508",oPC,1);
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetName(oItem,"Writ of Bailiff for "+GetSettlementName(sSettlement));
    SetLocalString(oItem,"Settlement",sSettlement);
    SetDescription(oItem,"The Baron of "+GetSettlementName(sOwner)+" has entrusted "+GetSettlementName(sSettlement)+" to your care and management. This document ensures your recognition as being capable in management of this locale. For Queen and Country.");
    SetIdentified(oItem,TRUE);
}
