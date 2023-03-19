
#include "pf_include"

// Usage of this script:
//      1. Add this script to the chest OnClose event
//      2. Change the Tag to a unique name as this will be used to identify the chest
//         and items it stores
//      3. Select Plot, Useable, and Has Inventory (remove anything from the Inventory
//         as the items will be stored and retrieved from the database)
//      4. Set the 'Will Save' value to the number of items the chest should hold. If
//         not set - the chest will default to 25 items

void main()
{

    object oChest = OBJECT_SELF;
    object oPC = GetLastClosedBy();
    object oItem = GetFirstItemInInventory(oChest);
    int iItem = 0;
    int nMaxItemCount = GetWillSavingThrow(OBJECT_SELF);
    string sItemVar;
    string sChestTag = GetLocalString (oChest,"sUnique");
    string sChestKey = GetLockKeyTag(oChest);
    string sChestName = sChestTag;

    if (GetStringLength(sChestKey) > 0) {
        sChestName = sChestName + "_" + sChestKey;
    }

    if (nMaxItemCount == 0) {
        // If Willpower not set give a default 25 items
        nMaxItemCount = 25;
    }

    if (GetLockLockable(oChest)) {
        SetLocked (oChest, TRUE);
    }

    // Remove all items from the database before re-inserting each item to prevent item duplication and allow
    // re-ordering of the items so that each item is stored in sequence and the items can be retrieved in a loop.
    //string sSQL = "DELETE FROM " + PF_CAMPAIGN_OBJ + " WHERE player='~' AND tag='" + sChestTag + "' AND name LIKE '" + sChestName + "%'";
    //SQLExecDirect(sSQL);

    // Save the chest items sequentially
    while (GetIsObjectValid(oItem)) {
        sItemVar = sChestName + "_" + IntToString(iItem);
        if (iItem >= nMaxItemCount ) {
            // If the chest has stored too many items give excess items to the opener
            ActionGiveItem(oItem, oPC);
            SendMessageToPC(oPC, "Chest is overloaded... item is in your inventory.");
        } else {
            StorePFCampaignObject(PF_CAMPAIGN_OBJ, sItemVar, oItem, oChest);
        }
        oItem = GetNextItemInInventory(oChest);
        iItem++;
    }

    SetPFCampaignInt(PF_CAMPAIGN, sChestName, TRUE, GetModule());
}

