#include "gs_inc_shop"

void main()
{
    if (TE_SH_GetIsAvailable(OBJECT_SELF)) return;

    object oDisturbed = GetLastDisturbed();
    object oItem      = GetInventoryDisturbItem();
    object oCopy      = OBJECT_INVALID;
    string sTag       = GetTag(oItem);
    int nSalePrice    = TE_SH_GetSalePrice(OBJECT_SELF);
    int nRetailPrice  = TE_SH_GetItemValue(oItem);
    int nValue        = nRetailPrice + (nRetailPrice * nSalePrice / 100);

    switch (GetInventoryDisturbType())
    {
    case INVENTORY_DISTURB_TYPE_ADDED:
        if(GetIsObjectValid(oItem) == TRUE)
        {
            if (GetIsDM(oDisturbed) ||
                TE_SH_GetIsOwner(OBJECT_SELF, oDisturbed))
            {
                TE_SH_ImportItem(oItem, OBJECT_SELF);
                SendMessageToPC(oDisturbed,GetName(oItem)+" added to shop and on sale for "+IntToString(nValue)+" Aenar (Base Retail Value: "+IntToString(nRetailPrice)+")");
            }
            else
            {
                oCopy = CopyItem(oItem, oDisturbed);

                if (GetIsObjectValid(oCopy))
                {
                    DestroyObject(oItem);
                    SendMessageToPC(oDisturbed, "The shop purchases no wares.");
                }
            }
        }
        break;

    case INVENTORY_DISTURB_TYPE_REMOVED:
    case INVENTORY_DISTURB_TYPE_STOLEN:
        //bug workaround: moved to gs_m_acquired because event is not raised
        //if items are dragged from a shop into an inventory subcontainer
        break;
    }
}
