void ActionAutoCloseAndLock(object theObject)
{
    if (GetIsOpen(OBJECT_SELF))
        { ActionCloseDoor(OBJECT_SELF); }
    ActionDoCommand (SetLocked (OBJECT_SELF, TRUE));
}

void main()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;
    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement
    int nLockDC          = GetCampaignInt("Housing",sUnique+"Lock");                    //The DC for trying to unlock this door using Open Lock skill.

    object oItem         = GetItemPossessedBy(oPC,"PC_Data_Object");
    int    nPiety        = GetLocalInt(oItem,"nPiety");

    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1)
    {
        SetLocalInt(oItem,"nPiety",nPiety-5);
        SendMessageToPC(oPC,"Your actions are not in accordance with your vows and your piety has fallen as a result.");
        SendMessageToPC(oPC,"Your piety has fallen to "+IntToString(nPiety-5)+" out of 100.");
    }

    if(GetIsSkillSuccessful(oPC,SKILL_OPEN_LOCK,nLockDC))
    {
        SendMessageToPC(oPC,"You are able to successfully jostle open the lock.");
        ActionOpenDoor(OBJECT_SELF); //Open the Door.
        DelayCommand(180.0, ActionAutoCloseAndLock(OBJECT_SELF)); //Delay 12 seconds before auto closing and locking the door.
    }
    else
    {
        SendMessageToPC(oPC,"You are able to successfully jostle open the lock.");
    }
}
