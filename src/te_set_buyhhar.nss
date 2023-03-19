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

    if( (GetLocalInt(oPC,TRADE_SKINHARD) >= 10 ) || ( GetItemPossessedBy(oPC,TRADE_SKINHARD) != OBJECT_INVALID) )
    {
        object oItem = GetFirstItemInInventory(oPC);
        int nCount = 0;
        while (oItem != OBJECT_INVALID)
        {
            if((GetTag(oItem) == TRADE_SKINHARD) && nCount < 10)
            {
                DestroyObject(oItem);
                nCount += 1;
            }
            oItem = GetNextItemInInventory(oPC);
        }

        nGold = FloatToInt(VALUE_SKINHARD*fMerchant);
        TurnInTradeGoods(oPC,sSettlement,nGold);
        SendMessageToPC(oPC,"Trade Goods Received.");
        ResetTradeVariables(oPC);
    }
    else
    {
        SendMessageToPC(oPC,"Trade Goods Not Received.");
    }

}
