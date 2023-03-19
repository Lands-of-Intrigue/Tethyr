#include "te_settle_inc"
int StartingConditional()
{
    object oSettlement = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));
    int nSProduce = GetCampaignInt("Settlement",(sSettlement+"_SupProduce"));
    object oItem = GetItemPossessedBy(oPC,TRADE_SUPPLIES);
     int nTimeStamp = (GetCalendarYear()*10000)+(GetCalendarMonth()*100)+GetCalendarDay();

    if(nTimeStamp < nSProduce)
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }

}
