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

    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for the door

    //Integers
    int nLockDC          = GetCampaignInt("Housing",sUnique+"Lock");                    //The DC for trying to unlock this door using Open Lock skill.
    int nDoorDC          = GetCampaignInt("Housing",sUnique+"Door");                    //The DC for trying to bust down this door using STR.

    int nBroke           = GetCampaignInt("Housing",sUnique+"Brok");
    SetCampaignInt("Housing",sUnique+"Base",((nLockDC+nDoorDC)*5)+50);
    //Construct Key String
    string sKey          = (sUnique+IntToString(nKey));


    //For Doors with no unique tag, do nothing. Plot locked door
    if(sUnique == "")
    {
        return;
    }

    if(nBroke > 0 )
    {
        SendMessageToPC(oPC,"This door has been forced open!");
        SetLocked(oDoor,FALSE);
        ActionOpenDoor(oDoor); //Open the Door.
        return;
    }

    //Check for Gaseous Form or Vampiric Mist.
    if(GetHasFeatEffect(1422,oPC) == TRUE || GetPCAffliction(oPC) == 8) //Will need testing.
    {
        SendMessageToPC(oPC,"You manage to slide your gaseous form through the lock and open the door.");
        ActionOpenDoor(OBJECT_SELF); //Open the Door.
        DelayCommand(6.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 6 seconds before auto closing and locking the door.
        return;
    }

    ActionStartConversation(oPC,"te_door",TRUE); //Start conversation with options to rent/open lock/break down door.
}
