#include "te_settle_inc"
void main()
{
    object oSettlement = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oItem = CreateItemOnObject("te_item_8509",oPC,1);
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    SetName(oItem,"Writ of Barony for "+GetSettlementName(sSettlement));
    SetLocalString(oItem,"Settlement",sSettlement);
    SetDescription(oItem,"The Council of Noromath endorses the holder of this document to manage one or more holdings within the County of Brost. This title is granted to the Barony of "+GetSettlementName(sSettlement)+". For Crown and Country and the Glory of Tethyr.");
    SetIdentified(oItem,TRUE);

}
