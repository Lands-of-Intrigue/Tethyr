#include "te_settle_inc"

void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    int nSCollect = GetCampaignInt("Settlement",(sSettlement+"_SupProduce"));
    object oPC = GetPCSpeaker();
    int nTimeStamp = (GetCalendarYear()*10000)+(GetCalendarMonth()*100)+GetCalendarDay();
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    object oSup = CreateItemOnObject(TRADE_SUPPLIES, oPC, 1);
    SetLocalString(oSup,"sOwner",sOwner);
    SetCampaignInt("Settlement",(sSettlement+"_SupProduce"),nTimeStamp+1);
}
