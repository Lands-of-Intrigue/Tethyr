#include "te_settle_inc"
void main()
{
    object oPC = GetPCSpeaker();
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");

    int nGold = 0;

    float fMerchant = 1.0f;
    if(GetHasFeat(1111,oPC) == TRUE)
    {
        fMerchant = 1.75f;
    }

    if( (GetLocalInt(oPC,TRADE_MUSHROOM) >= 1 ) || ( GetItemPossessedBy(oPC,TRADE_MUSHROOM) != OBJECT_INVALID) )
    {
        object oItem = GetItemPossessedBy(oPC,TRADE_MUSHROOM);
        DestroyObject(oItem);
        nGold = FloatToInt(VALUE_MUSHROOM*fMerchant);
        TurnInTradeGoods(oPC,sSettlement,nGold);
        SendMessageToPC(oPC,"Trade Goods Received.");
        ResetTradeVariables(oPC);
    }
    else
    {
        SendMessageToPC(oPC,"Trade Goods Not Received.");
    }

}
