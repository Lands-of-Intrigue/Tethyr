#include "te_settle_inc"
int StartingConditional()
{
    object oSettlement = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));
    int nSCollect = GetCampaignInt("Settlement",(sSettlement+"_SupCollect"));
    int nRCollect = GetCampaignInt("Settlement",(sSettlement+"_ResCollect"));
    object oItem = GetItemPossessedBy(oPC,TRADE_SUPPLIES);
     int nTimeStamp = (GetCalendarYear()*10000)+(GetCalendarMonth()*100)+GetCalendarDay();

    if(GetLocalString(oItem,"sOwner") != sOwner)
    {
        SendMessageToPC(oPC,"These goods are marked as belonging to another barony...");
        return FALSE;
    }

    if(nTimeStamp < nSCollect)
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }

}
