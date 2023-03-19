//::///////////////////////////////////////////////
//:: Unlock PC
//:: mil_unlockpc.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Unlocks the Prisoner from the Lock.  Resetting all variables.

    Assumes the following Local Variables to be set:
    mil_Shackles - the object to lock the Creature to.  Set on the Caller object.
    mil_LockAnimation - the animation to lock the Creature in.  Set on the Lock object.
    mil_LockOringinalDirection - the oringial direction of the Lock.  Set on the Lock object.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////
void main()
{
    // Set vars.
    object  oPC         = GetPCSpeaker();                               // The user
    object  oShackle    = GetLocalObject(oPC, "mil_Shackles");          // The Shackle
    object  oPrisoner   = GetLocalObject(oShackle, "mil_Prisoner");     // The person locked.
    int     InUse       = GetLocalInt(oShackle, "mil_InUse");           // Shackles in use already.

    ActionPauseConversation();

    // If the shackle is being used.
    if (InUse > 0)    {
        // Play the sound.
        PlaySound("as_na_branchsnp3");

        // Free Player.
        AssignCommand(oPrisoner, ClearAllActions());
        SetCommandable(TRUE, oPrisoner);

        // Turn the shackles back
        AssignCommand(oShackle, SetFacing(GetLocalFloat(oShackle, "mil_LockOringinalDirection")));

        // Reset Local vars.
        SetLocalInt(oShackle, "mil_InUse", 0);
        DeleteLocalObject(oShackle, "mil_Prisoner");
        DeleteLocalInt(oPC, "mil_LockAnimation");
        DeleteLocalObject(oShackle, "mil_LockOringinalDirection");

        // Play animation.
        DelayCommand(0.5, AssignCommand(oPrisoner, PlayAnimation(ANIMATION_LOOPING_PAUSE, 1.0, 2.0)));

        // Emote
        string ToSpeak = "**" +GetName(oPC) + " has unlocked " + GetName(oPrisoner) + ".**";
        AssignCommand(oShackle, SpeakString(ToSpeak, TALKVOLUME_TALK));
    }

    ActionResumeConversation();
}
