//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_w_fail
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////

#include "sfpb_config"
int StartingConditional()
{
    // Vars
    object oPC = GetLastSpeaker();
    string sID = SF_GetPlayerID(oPC);
    int nGold = StringToInt(GetLocalString(OBJECT_SELF, "GOLD"));
    int nBanked = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + GetLocalString(OBJECT_SELF, "Town"));

    // Check if the player has enough to withdraw
    return(nBanked < nGold);
}
