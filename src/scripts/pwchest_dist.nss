
#include "pf_include"

// Usage of this script:
//      1. Add this script to the chest OnDisturbed event
//      2. Change the Tag to a unique name as this will be used to identify the chest 
//         and items it stores
//      3. Select Plot, Useable, and Has Inventory (remove anything from the Inventory 
//         as the items will be stored and retrieved from the database)
//      4. Set the 'Will Save' value to the number of items the chest should hold. If 
//         not set - the chest will default to 25 items

void main() {
    object oPlayer = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    object oChest = OBJECT_SELF;
    int nCurrItemCount = GetLocalInt(oChest, "Item_Count");
    int nMaxItemCount = GetLocalInt(oChest, "Max_Items");
    int nType = GetInventoryDisturbType();

    switch (nType) {
        case INVENTORY_DISTURB_TYPE_ADDED:
            // DO NOT ALLOW CONTAINER ITEMS!
            // Added a check to make sure item does not have inventory.
            // Always increment count as even when the item is given back the on-disturb event is called.
            nCurrItemCount++;

            if (GetHasInventory(oItem) == TRUE) {
                SendMessageToPC(oPlayer, "You can't store containers in this chest.");
                ActionGiveItem(oItem, oPlayer);
            }

            // DO NOT ADD AN ITEM IF CHEST IS FULL. If not full increment the item count
            // it will use the MAX_ITEMS stored on the chest to determine the maximum.
            if (nCurrItemCount > nMaxItemCount) {
                SendMessageToPC(oPlayer, "Chest is full with " + IntToString(nCurrItemCount) + " items.");
                ActionGiveItem(oItem, oPlayer);
            }
          break;
        case INVENTORY_DISTURB_TYPE_REMOVED:
          // Decrement the item count.
            if (nCurrItemCount > 0) {
                nCurrItemCount--;
            }
          break;
    }

    SetLocalInt(OBJECT_SELF, "Item_Count", nCurrItemCount);
    SendMessageToPC(GetLastUsedBy(), "Chest contains " + IntToString(nCurrItemCount) +
        " out of the maximum " + IntToString(nMaxItemCount) + " items.");

}
