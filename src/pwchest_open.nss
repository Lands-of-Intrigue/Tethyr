#include "pf_include"

// Usage of this script:
//      1. Add this script to the chest OnOpen event
//      2. Change the Tag to a unique name as this will be used to identify the chest
//         and items it stores
//      3. Select Plot, Useable, and Has Inventory (remove anything from the Inventory
//         as the items will be stored and retrieved from the database)
//      4. Set the 'Will Save' value to the number of items the chest should hold. If
//         not set - the chest will default to 25 items

void main()
{
    int nLoaded = GetLocalInt(OBJECT_SELF,"Chest_Loaded");
    int nMaxItems = GetWillSavingThrow(OBJECT_SELF);
    object oPC = GetLastOpenedBy();
    if (nMaxItems == 0) {
        // If Willpower not set give a default 25 items
        nMaxItems = 25;
    }

    if(nLoaded) {
        // If this chest has already been loaded from the database don't bother
        //   re-reading as items may have changed.
        return;
    } else {
        int iItem=0;
        object oChest = OBJECT_SELF;
        string sChestTag = GetLocalString (oChest,"sUnique");
        string sChestKey = GetLockKeyTag(oChest);

        string sChestName = sChestTag;

        if (GetStringLength(sChestKey) > 0) {
            sChestName = sChestName + "_" + sChestKey;
        }

        // This section reads data from the database to fill the chest with items
        object oCreated;
        string sItemVar;
        int bContinue = TRUE;
        location lLocation = GetLocation(oChest);

        SendMessageToPC( oPC, "Loading..." );
        while (bContinue) {
            sItemVar = sChestName + "_" + IntToString(iItem);
            // the object oCreated is retrieved from table sCampaignObj into the oChest by selecting the sItemvar
            oCreated = RetrievePFCampaignObject(PF_CAMPAIGN_OBJ, sItemVar, lLocation, oChest);

            if (!GetIsObjectValid(oCreated)) {
                // The last item has been loaded. Exit the loop
                bContinue = FALSE;
            } else {
                if (iItem >= nMaxItems ) {
                    // If the chest has stored too many items give excess items to the opener
                    ActionGiveItem(oCreated, oPC);
                    SendMessageToPC(oPC, "Chest is overloaded... item is in your inventory.");
                    DeletePFCampaignVariable(sItemVar,PF_CAMPAIGN_OBJ, oChest);
                } else {
                    // increment the item count for the chest
                    iItem++;
                }
            }
        }
        SendMessageToPC( oPC, "Done Loading" );

        SetLocalInt(OBJECT_SELF,"Chest_Loaded",TRUE);
        SetLocalInt(OBJECT_SELF,"Item_Count",iItem);
        SetLocalInt(OBJECT_SELF,"Max_Items",nMaxItems);
        SetLocalInt(OBJECT_SELF,"Chest_NWNX",GetPFCampaignInt(PF_CAMPAIGN, sChestName, GetModule()));

    }

}
