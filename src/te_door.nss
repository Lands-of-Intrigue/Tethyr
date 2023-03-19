#include "loi_functions"
#include "te_settle_inc"
void ActionAutoCloseAndLock(object theObject)
{
    if (GetIsOpen(OBJECT_SELF))
        { ActionCloseDoor(OBJECT_SELF); }
    ActionDoCommand (SetLocked (OBJECT_SELF, TRUE));
}

void main()
{
    //Objects
    object oPC           = GetClickingObject();                                         //The PC clicking the door
    object oDoor         = OBJECT_SELF;                                                 //The Door.

    if(GetDistanceBetween(OBJECT_SELF,oPC) > 5.0) {return;}

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
    string sSubOwner     = GetCampaignString("Housing",sUnique+"Owner");                //Unique ID for the player that is the sub-owner or guild leader for this location.
    string sName         = GetCampaignString("Housing",sUnique+"Name");                 //The Name of this location that will get printed to a key when generated.
    string sRentName     = GetCampaignString("Housing",sUnique+"RentName");

    //Integers
    int nPrice           = GetCampaignInt("Housing",sUnique+"Pric");                    //The Price set by the owner automatically deducted from the renter's bank at barony.
    int nKey             = GetCampaignInt("Housing",sUnique+"Keys");                    //The Number of times this lock has been changed. String is the same, just modified by 1.
    int nLockDC          = GetCampaignInt("Housing",sUnique+"Lock");                    //The DC for trying to unlock this door using Open Lock skill.
    int nDoorDC          = GetCampaignInt("Housing",sUnique+"Door");                    //The DC for trying to bust down this door using STR.
    int nUpkeep          = GetCampaignInt("Housing",sUnique+"Base");                    //The default upkeep/price for maintaining this door/location behind the door.
    int nState           = GetCampaignInt("Housing",sUnique+"Stat");                    //The state of this location. Is it just a door?

                        // 0 - Closed unless you have a key or are the owner.
                        // 1 - Rentable. This location can be rented and entered if you have the key or are the owner.
                        // 2 - Open to the public. This location is automatically unlocked all hours.
                        // 3 - Open to the public (12 Hours). This location is automatically unlocked between 6 and 18 hours.
                        // 4 - Open to Insignia Carrying Individuals.
    int nBroke           = GetCampaignInt("Housing",sUnique+"Brok");
    SetCampaignInt("Housing",sUnique+"Base",((nLockDC+nDoorDC)*5)+50);
    //Construct Key String
    string sKey          = (sUnique+IntToString(nKey));
    string sGold;


    //Debug
    if(GetIsDM(oPC))
    {
        string sAccount = IntToString(GetCampaignInt(GetName(GetModule()),"TE_GD_"+sRenter+sBank));
        SendMessageToPC(oPC,"sUnique: "+sUnique+" sID: "+sID+" sOwner: "+sOwner+" sBank: "+sBank+" sSetOwner: "+sSetOwner+" sRenter: "+sRenter+ " sName: "+sName+" nPrice: "+IntToString(nPrice)+" nKey: "+IntToString(nKey)+" nLockDC: "+IntToString(nLockDC)+" nDoorDC: "+IntToString(nDoorDC)+" nUpkeep: "+IntToString(nUpkeep)+" nState: "+IntToString(nState)+" Bailiff: "+GetLocalString(oBailiff,"Settlement")+" Baron: "+GetLocalString(oBaron,"Settlement"));
        SendMessageToPC(oPC,"Renter Name: "+sRentName);
        SendMessageToPC(oPC,"Renter Account: "+sAccount);
    }

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

    if(nBroke > 0 )
    {
        SendMessageToPC(oPC,"This door has been forced open!");
        SetLocked(oDoor,FALSE);
        ActionOpenDoor(oDoor); //Open the Door.
    }

    //Check for Gaseous Form or Vampiric Mist.
    if(GetHasFeatEffect(1422,oPC) == TRUE || GetPCAffliction(oPC) == 8) //Will need testing.
    {
        SendMessageToPC(oPC,"You manage to slide your gaseous form through the lock and open the door.");
        ActionOpenDoor(OBJECT_SELF); //Open the Door.
        DelayCommand(6.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 6 seconds before auto closing and locking the door.
        return;
    }

    //Closed to the public, not for rent.
    if(nState == 0)
    {
        if( GetLocalString(oBailiff,"Settlement") == sOwner  || //I am the Bailiff for this location.
            GetLocalString(oBaron,"Settlement") == sSetOwner || //I am the Baron for this location.
            sID == sSubOwner                                 || //I am the Sub-Owner for this location.
            GetItemPossessedBy(oPC,sKey) != OBJECT_INVALID)  //I have a key object in my inventory for this location.
        {
            SendMessageToPC(oPC,"You use a key to unlock the door.");
            SendMessageToPC(oPC,"Debug: Closed to Public, not for Rent.");
            ActionOpenDoor(OBJECT_SELF); //Open the Door.
            DelayCommand(12.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 12 seconds before auto closing and locking the door.
        }
        else
        {
            ActionStartConversation(oPC,"te_door",TRUE); //Start conversation with options to rent/open lock/break down door.
        }
    }
    //Rentable location.
    else if(nState == 1)
    {
        //I am the renter. Let me in.
        if(sID == sRenter)
        {
            SendMessageToPC(oPC,IntToString(nPrice)+" is being deducted from your bank account for the barony that owns this location every ten day. If your account balance reaches zero, you will be evicted.");
            ActionOpenDoor(OBJECT_SELF); //Open the Door.
            DelayCommand(12.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 12 seconds before auto closing and locking the door.
        }
        else if( GetLocalString(oBailiff,"Settlement") == sOwner  || //I am the Bailiff for this location.
                 GetLocalString(oBaron,"Settlement") == sSetOwner || //I am the Baron for this location.
                 sID == sSubOwner                                 || //I am the Sub-Owner for this location.
                 GetItemPossessedBy(oPC,sKey) != OBJECT_INVALID)  //I have a key object in my inventory for this location.
        {
            SendMessageToPC(oPC,"Debug: Closed to Public, open for Rent.");
            SendMessageToPC(oPC,"You use a key to unlock the door.");
            ActionOpenDoor(OBJECT_SELF); //Open the Door.
            DelayCommand(12.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 12 seconds before auto closing and locking the door.
        }
        else //I am not the renter/there is no renter. And I am also not a Bailiff or the Baron for this location.
        {
            ActionStartConversation(oPC,"te_door",TRUE); //Start conversation with options to rent/open lock/break down door.
        }

    }
    //Open to the public.
    else if(nState == 2)
    {
        if( GetLocalString(oBailiff,"Settlement") == sOwner  || //I am the Bailiff for this location.
            GetLocalString(oBaron,"Settlement") == sSetOwner || //I am the Baron for this location.
            sID == sSubOwner                                 || //I am the Sub-Owner for this location.
            GetItemPossessedBy(oPC,sKey) != OBJECT_INVALID)  //I have a key object in my inventory for this location.
        {
            SendMessageToPC(oPC,"Debug: Open to Public, not for Rent.");
            SendMessageToPC(oPC,"You use a key to unlock the door.");
            ActionOpenDoor(OBJECT_SELF); //Open the Door.
            DelayCommand(12.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 12 seconds before auto closing and locking the door.
        }
        else
        {
            SendMessageToPC(oPC,"You use a key to unlock the door.");
            ActionOpenDoor(OBJECT_SELF); //Open the Door.
            DelayCommand(12.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 12 seconds before auto closing and locking the door.
        }
    }
    //Open to the public, only during daytime hours.
    else if(nState == 3)
    {
        if(GetIsDay() == TRUE)//If between the hours of 6 and 18.
        {
            SendMessageToPC(oPC,"Debug: Open to Public between hours of 6 and 12, not for Rent.");
            SendMessageToPC(oPC,"You use a key to unlock the door.");
            ActionOpenDoor(OBJECT_SELF); //Open the Door.
            DelayCommand(12.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 12 seconds before auto closing and locking the door.
        }
        else if( GetLocalString(oBailiff,"Settlement") == sOwner  || //I am the Bailiff for this location.
            GetLocalString(oBaron,"Settlement") == sSetOwner || //I am the Baron for this location.
            sID == sSubOwner                                 || //I am the Sub-Owner for this location.
            GetItemPossessedBy(oPC,sKey) != OBJECT_INVALID)  //I have a key object in my inventory for this location.
        {
            SendMessageToPC(oPC,"You use a key to unlock the door.");
            ActionOpenDoor(OBJECT_SELF); //Open the Door.
            DelayCommand(12.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 12 seconds before auto closing and locking the door.
        }
        else
        {
            ActionStartConversation(oPC,"te_door",TRUE); //Start conversation with options to rent/open lock/break down door.
        }
    }
    //Public Access for Barony members, only.
    else if(nState == 4)
    {
        if( GetLocalString(oBailiff,"Settlement") == sOwner  || //I am the Bailiff for this location.
            GetLocalString(oBaron,"Settlement") == sSetOwner || //I am the Baron for this location
            sID == sSubOwner                                 || //I am the Sub-Owner for this location.
            GetLocalString(oInsig,"Settlement") == sSetOwner ||
            GetItemPossessedBy(oPC,sKey) != OBJECT_INVALID)  //I have a key object in my inventory for this location.
        {
            SendMessageToPC(oPC,"You use a key to unlock the door.");
            ActionOpenDoor(OBJECT_SELF); //Open the Door.
            DelayCommand(12.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 12 seconds before auto closing and locking the door.
        }
        else
        {
            ActionStartConversation(oPC,"te_door",TRUE); //Start conversation with options to rent/open lock/break down door.
        }
    }
}
