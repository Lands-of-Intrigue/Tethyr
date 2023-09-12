#include "te_settle_inc"
#include "te_functions"

void main()
{
    object oSettlement = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sResource = GetCampaignString("Settlement",(sSettlement+"_sResource"));
    int nNum = GetProductionValue(sSettlement);

    int nRCollect = GetCampaignInt("Settlement",(sSettlement+"_ResCollect"));
    int nTimeStamp = (GetCalendarYear()*10000)+(GetCalendarMonth()*100)+GetCalendarDay();
    float fTrade = GetTradeValue(sResource);

    if(GetHasFeat(BACKGROUND_MERCHANT,oPC) == TRUE)
    {
        fTrade = (fTrade - (fTrade*0.25f));
    }

    int nTrade = FloatToInt(fTrade);



    if(GetGold(oPC) > nTrade)
    {
                TakeGoldFromCreature(nTrade,oPC);
        CreateItemOnObject(sResource, oPC, nNum);
        SetCampaignInt("Settlement",(sSettlement+"_ResCollect"),nTimeStamp+GetResourceProductionDelay(sResource));
    }
}
