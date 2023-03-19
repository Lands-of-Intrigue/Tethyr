#include "te_settle_inc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");

    int nTradeCount = GetLocalInt(oPC,TRADE_SUPPLIES);

    if(nTradeCount >= 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }


}
