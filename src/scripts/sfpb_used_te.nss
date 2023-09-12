//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_used
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////

#include "sfpb_config"
void main()
{
    // Vars
    object oPC = GetLastUsedBy();
    object oChest = OBJECT_SELF;
    string sID = SF_GetChestID(oChest);
    string sUserID = GetLocalString(oChest, "USER_ID");
    string sModName = GetName(GetModule());

    // End script if any of these conditions are met
    if (!GetIsPC(oPC) ||
         GetIsDM(oPC) ||
         GetIsDMPossessed(oPC) ||
         GetIsPossessedFamiliar(oPC)) return;

}
