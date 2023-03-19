void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    int iState = GetLocalInt(oItem,"BG_Select");

    if(iState == 1)
    {
       SendMessageToPC(oPC,"Resuming from Class Standing Selection.");
        ActionStartConversation(oPC,"bg_class",TRUE);
    }
    else if(iState == 2)
    {

       SendMessageToPC(oPC,"Resuming from Background Selection.");
        ActionStartConversation(oPC,"bg_background",TRUE);
    }
    else if(iState == 3)
    {
        SendMessageToPC(oPC,"Resuming from Deity Selection.");
        ActionStartConversation(oPC,"bg_deity",TRUE);
    }
    else if(iState == 4)
    {
        SendMessageToPC(oPC,"Resuming from Language Selection.");
        ActionStartConversation(oPC,"bg_language",TRUE);
    }
    else if(iState == 5)
    {
        SendMessageToPC(oPC,"Resuming from Proficiency Selection.");
        ActionStartConversation(oPC,"bg_proficiency",TRUE);
    }
    else if(iState == 6)
    {
        SendMessageToPC(oPC,"Resuming from Age Modifier Selection.");
        ActionStartConversation(oPC,"bg_final",TRUE);
    }
    else if(iState == 7)
    {
        SendMessageToPC(oPC,"Resuming from Disfigurement Selection.");
        ActionStartConversation(oPC,"bg_disfig",TRUE);
    }
    else if(iState == 8)
    {
        SendMessageToPC(oPC,"You have completed the background selection process.");
    }
    else
    {
        SendMessageToPC(oPC,"You have not begun the selection process.");
        ActionStartConversation(oPC,"bg_subrace",TRUE);
    }
}
