#include "loi_functions"
#include "te_settle_inc"

void main()
{
    //Objects
    object oPC           = GetClickingObject();                                         //The PC clicking the door.
    object oDoor         = OBJECT_SELF;                                                 //The Door.
    object oDestination  = GetTransitionTarget(OBJECT_SELF);                            //If this door connects to something, get that object.
    object oBailiff      = GetItemPossessedBy(oPC,"te_item_8508");                           //Bailiff's Writ.
    object oBaron        = GetItemPossessedBy(oPC,"te_item_8509");                           //Baron's Writ.
    object oInsig        = GetItemPossessedBy(oPC,"te_insignia");                           //Insignia

    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement
    string sID           = GetSubString(GetPCPublicCDKey(oPC)+"_"+GetName(oPC), 0, 15);  //Unique ID for player interacting to be compared to sRenter.
    string sOwner        = GetLocalString(oDoor,"sOwner");                              //Owner ID / Settlement that owns this location.
    string sGuild        = GetLocalString(oDoor,"sGuild");
    string sBank         = GetCampaignString("Settlement",sOwner+"_sBank");             //Bank ID associated with settlement that owns this location.
    string sSetOwner     = GetCampaignString("Settlement",sOwner+"_sOwner");            //Barony that owns this Settlement and therefore this location.
    string sRenter       = GetCampaignString("Housing",sUnique+"Rent");                 //Unique ID for the player that is renting this location.
    string sSubOwner     = GetCampaignString("Housing",sGuild+"Owner");                //Unique ID for the player that is the sub-owner or guild leader for this location.

    int nGuildPrice      = GetCampaignInt("Housing",sGuild+"Pric");
   // int nGuildUpkeep     = CalculateGuildUpkeep(sGuild);

    //Construct Key String
    string sGold;

    //For Doors with no unique tag or importance.
    if(sUnique == "")
    {
        return;
    }

    if(sOwner == "")
    {
        sOwner = "Blank";
    }

    if(sSetOwner == "")
    {
        sSetOwner = "Blank";
    }

    if(sSubOwner == "")
    {
        sSubOwner = "Blank";
    }
/*    if( GetLocalString(oBailiff,"Settlement") == sOwner  || //I am the Bailiff for this location.
            GetLocalString(oBaron,"Settlement") == sSetOwner || //I am the Baron for this location.
            GetItemPossessedBy(oPC,sKey) != OBJECT_INVALID)  //I have a key object in my inventory for this location.
    {
        ActionStartConversation(oPC,"te_door",TRUE); //Start conversation with options to rent/open lock/break down door.
    }
*/



}
