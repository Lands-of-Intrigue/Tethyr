//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_open
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////

#include "sfpb_config"
void main()
{
    // Vars
    object oPC = GetLastOpenedBy();
    object oChest = OBJECT_SELF;
    location lLoc = GetLocation(oPC);
    string sID = SF_GetPlayerID(oPC);
    string sUserID = GetLocalString(oChest, "USER_ID");
    string sModName = GetName(GetModule());

    // End script if any of these conditions are met
    if (!GetIsPC(oPC) ||
         GetIsDM(oPC) ||
         GetIsDMPossessed(oPC) ||
         GetIsPossessedFamiliar(oPC)) return;

    // Get the player's storer NPC from the database
    object oStorer = RetrieveCampaignObject(sModName, DATABASE_ITEM + GetLocalString(OBJECT_SELF, "Town"), lLoc);
    DeleteCampaignVariable(sModName, DATABASE_ITEM + GetLocalString(OBJECT_SELF, "Town"));

    // loop through the NPC storers inventory and copy the items
    // into the chest.
    object oItem = GetFirstItemInInventory(oStorer);
    while (GetIsObjectValid(oItem))
    {
        // Copy the item into the chest
        CopyItem(oItem, oChest, TRUE);

        // Destroy the original
        DestroyObject(oItem);

        // Next item
        oItem = GetNextItemInInventory(oStorer);
    }

    // Destroy the NPC storer
    DestroyObject(oStorer);
}
