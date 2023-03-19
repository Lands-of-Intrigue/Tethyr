#include "gs_inc_shop"

void main()
{
    object oSpeaker  = GetPCSpeaker();
    object oItem     = GetLocalObject(oSpeaker, "GS_SH_ITEM");
    object oSelf     = OBJECT_SELF;
    string sOwner    = GetLocalString(oSelf,"sOwner");
    string sBank     = GetCampaignString("Settlement",sOwner+"_sBank");
    int nSalePrice   = TE_SH_GetSalePrice(OBJECT_SELF);
    int nRetailPrice = TE_SH_GetItemValue(oItem);
    int nValue       = nRetailPrice + (nRetailPrice * nSalePrice / 100);
    if (nValue < 1) nValue = 1;

    if (GetGold(oSpeaker) < nValue)
    {
        SendMessageToPC(oSpeaker, "You do not have enough gold.");
    }
    else
    {
        string sID  = TE_SH_GetOwnerID(OBJECT_SELF);

        TE_GoldTransfer(oSpeaker, sID, nValue, sBank);
        TE_SH_ExportItem(oItem, oSpeaker);
        ActionDoCommand(DelayCommand(0.5, TE_SH_SaveShop(OBJECT_SELF)));
    }

    AssignCommand(oSpeaker, ActionInteractObject(oSelf));
}


