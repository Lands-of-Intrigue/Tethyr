#include "te_settle_inc"
#include "te_functions"
int StartingConditional()
{
    object oSettlement = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    int nRCollect = GetCampaignInt("Settlement",(sSettlement+"_ResCollect"));
    int nTimeStamp = (GetCalendarYear()*10000)+(GetCalendarMonth()*100)+GetCalendarDay();
    string sResource = GetCampaignString("Settlement",(sSettlement+"_sResource"));
    if(sResource == "")
    {
        return FALSE;
    }

    float fTrade = GetTradeValue(sResource);

    if(GetHasFeat(BACKGROUND_MERCHANT,oPC) == TRUE)
    {
        fTrade = (fTrade - (fTrade*0.25f));
    }

    int nTrade = FloatToInt(fTrade);
    SetCustomToken(6600,IntToString(nTrade));

    if((nTimeStamp < nRCollect)|| (GetGold(oPC) < nTrade))
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }

}
