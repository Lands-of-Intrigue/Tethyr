//::///////////////////////////////////////////////
//:: Secure Persistent Chest System v2.0
//:: spcs_close
//:://////////////////////////////////////////////
/*
The OnClose handler for the SPCS
*/
//:://////////////////////////////////////////////
//:: Created By: Ophidios
//:: Created On: 8/8/2005
//:://////////////////////////////////////////////
#include "x0_i0_position"

void DestroySpawn(object oSpawn);
void main()
{

int iCheck = 0; // Integer used to check the number of objects in the chest
string SPCS_WAYPOINT = "StorageWaypoint";  // Tag of a waypoint created at a location in the module to determine the spawn point of the NULL_HUMAN
string SPCS_DB = "SPCS_Storage";    // Name of the DB to be used to store items

// Determines the player closing the Invisible Object's inventory, and then
// assigns it's unique PlayerID.  See "spcs_open" for details about this, and
// ensure that if changes are made that the PlayerID value here matches the one
// used in "spcs_open".
object oPC = GetLastClosedBy();
string PlayerID = GetLocalString(OBJECT_SELF,"sUnique");

// Spawns the NULL_HUMAN and cycles all items in the inventory of the Invisible
// Object into the NULL_HUMAN's.  Creates and amount of gold on the NULL_HUMAN
// relative to the "gold" Local set in the "spcs_disturb" script.
object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "spcs_storage", GetLocation(GetWaypointByTag(SPCS_WAYPOINT)), FALSE);
object oItem = GetFirstItemInInventory();
AssignCommand(oSpawn, ClearAllActions());
while (GetIsObjectValid(oItem))
    {
    if (GetTag(oItem) == "NW_IT_GOLD001")
        {
        iCheck++;
        int iCount = GetItemStackSize(oItem);
        int iCheck = GetLocalInt(OBJECT_SELF, "gold");
        iCount = iCount + iCheck;
        SetLocalInt(OBJECT_SELF, "gold", iCount);
        DestroyObject(oItem, 0.0);
        }
    else
        {
        iCheck++;
        CopyObject(oItem, GetLocation(oSpawn), oSpawn);
        DestroyObject(oItem, 0.0);
        }
    oItem = GetNextItemInInventory();
    }
CreateItemOnObject("NW_IT_GOLD001", oSpawn, GetLocalInt(OBJECT_SELF, "gold"));

// Stores the NULL_HUMAN along with all items in it's inventory to the DB.  The
// NULL_HUMAN is then destroyed.
StoreCampaignObject(SPCS_DB, PlayerID, oSpawn);
AssignCommand(GetArea(OBJECT_SELF), DestroySpawn(oSpawn));

// "Unlocks" the chest for otehrs to use.
object oChest = GetLocalObject(OBJECT_SELF, "chest_use");
SetLocalInt(oChest, "in_use", 0);

// Reports to the player the number of items stored appropriately.
string sCheck = IntToString(iCheck);
FloatingTextStringOnCreature("*" + sCheck + " items stored successfully!*", oPC);

// The Invisible Object is destroyed when it is no longer needed.
DestroyObject(OBJECT_SELF, 0.0);
}

void DestroySpawn(object oSpawn)
{
DelayCommand(1.0, DestroyObject(oSpawn, 0.0));
}
