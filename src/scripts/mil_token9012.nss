//::///////////////////////////////////////////////
//:: Token 9012
//:: mil_token9012.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Selects which Creature to attach to the Lock.
    Sets custom token 9001 to thier name.
    Opens the confirmation conversation on the Prisoner if they are another player,
    else executes the Lock PC to lock the NPC automatically.

    Assumes the following Local Variables to be set:
    mil_Shackles - the object to lock the Creature to.  Set on the Caller object.
    mil_PC9012 - the creature to lock down.  Set on the Lock object.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////
void main()
{
    object  oPC             = GetPCSpeaker();                          // The user
    object  oShackle        = GetLocalObject(oPC, "mil_Shackles");     // The Shackle
    object  oPrisoner       = GetLocalObject(oPC, "mil_PC9012");       // New prisoner

    // If the Prisoner is valid.
    if(GetIsObjectValid(oPrisoner)) {
        ActionPauseConversation();

        SetLocalObject(oPrisoner, "mil_Shackles", oShackle);
        SetCustomToken(9001, GetName(oPC));
        ActionResumeConversation();


        if (GetIsPC(oPrisoner)) {
            // If the prisoner is a PC, send the conversation.
            AssignCommand(oPrisoner, ActionStartConversation(oPrisoner, "mil_shackleother", TRUE));
        }   else    {
            // Else just lock them down.
            ExecuteScript("mil_lockpc", oPrisoner);
        }
    }

    // Delete no longer needed Local variables.
    DeleteLocalObject(oPC, "mil_PC9010");
    DeleteLocalObject(oPC, "mil_PC9011");
    DeleteLocalObject(oPC, "mil_PC9012");
    DeleteLocalObject(oPC, "mil_PC9013");
    DeleteLocalObject(oPC, "mil_PC9014");
}
