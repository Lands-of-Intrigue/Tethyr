//::///////////////////////////////////////////////
//:: Lock PC
//:: mil_lockpc.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Locks the calling Creature to the Lock in the given Animation.

    Assumes the following Local Variables to be set:
    mil_Shackles - the object to lock the Creature to.  Set on the Creature object.
    mil_LockAnimation - the animation to lock the Creature in.  Set on the Lock object.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////
void main()
{
    // Set vars
    object  oPC             = OBJECT_SELF;                              // The user
    object  oShackle        = GetLocalObject(oPC, "mil_Shackles");      // The Shackle
    float   LockDuration    = 120.0f * 60.0f;                           // Duration of animations, 2 hours.
    int     InUse           = GetLocalInt(oShackle, "mil_InUse");       // Shackles in use already.

    // If the lock is not already being used.
    if (InUse < 1) {
        // Set Local Vars
        SetLocalObject(oShackle, "mil_Prisoner", oPC);
        SetLocalInt(oShackle, "mil_InUse", 1);

        ActionPauseConversation();

        // Play the sound.
        PlaySound("as_na_branchsnp3");

        // Store current facing direction of shackles
        SetLocalFloat(oShackle, "mil_LockOringinalDirection", GetFacing(oShackle));

        // Turn actual shackles, but no other objects.
        if (GetName(oShackle) == "Floor-anchored shackles") {
            // Direction to turn the Shackle so it faces the PC
            float fTurnShackle = GetFacing(oPC);
            if (fTurnShackle < 360.0f) { fTurnShackle -= 360.0f; }

            // Turn the shackles
            AssignCommand(oShackle, SetFacing(fTurnShackle));
        }

        // Play the correct animation.
        DelayCommand(0.5, AssignCommand(oPC, PlayAnimation(GetLocalInt(oShackle, "mil_LockAnimation"), 1.0, LockDuration)));

        // Emote the locking.
        string ToSpeak = "**" + GetName(oPC) + " has been locked to the " + GetName(oShackle) + ".**";
        AssignCommand(oShackle, SpeakString(ToSpeak, TALKVOLUME_TALK));

        // Paralize player
        DelayCommand(1.5, SetCommandable(FALSE, oPC));

        ActionResumeConversation();
    } else {
        AssignCommand(oShackle, SpeakString("That " + GetName(oShackle) + " is already in use, select another."  , TALKVOLUME_TALK));
    }
}
