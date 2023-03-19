//::///////////////////////////////////////////////
//:: Strip Prisoner
//:: mil_strippc.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Strips the prisoner attached to the lock.  (Removes thier chest slot armor)

    Assumes the following Local Variables to be set:
    mil_Shackles - the object to lock the Creature to.  Set on the Caller object.
    mil_LockAnimation - the animation to lock the Creature in.  Set on the Lock object.
    mil_Prisoner - the creature to lock down.  Set on the Lock object.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////
void main()
{
    // Set vars
    object  oPC             = GetPCSpeaker();                               // The user
    object  oShackle        = GetLocalObject(oPC, "mil_Shackles");          // The Shackle
    object  oPrisoner       = GetLocalObject(oShackle, "mil_Prisoner");     // The person locked.
    float   LockDuration    = 120.0f * 60.0f;                               // Duration of animations, 2 hours.
    int     InUse           = GetLocalInt(oShackle, "mil_InUse");           // Shackles in use already.

    // If the lock is being used.
    if (InUse > 0) {
        ActionPauseConversation();

        // Free player
        AssignCommand(oPrisoner, ClearAllActions());
        SetCommandable(TRUE, oPrisoner);

        // Strip the chest slot.
        DelayCommand(0.5f, AssignCommand(oPrisoner,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST, oPrisoner))));

        // Emote
        string ToSpeak = "**" +GetName(oPC) + " has stripped the clothing from  " + GetName(oPrisoner) + ".**";
        AssignCommand(oShackle, SpeakString(ToSpeak, TALKVOLUME_TALK));

        // Re-Apply the animation
        int LockAnimation = GetLocalInt(oShackle, "mil_LockAnimation");
        DelayCommand(1.0f, AssignCommand(oPrisoner, PlayAnimation(LockAnimation, 1.0, LockDuration)));

        // Paralize player
        DelayCommand(2.0, SetCommandable(FALSE, oPrisoner));

        ActionResumeConversation();
    } else {
        string ToSpeak = "There is no prisoner attacked to that item.";
        AssignCommand(oShackle, SpeakString(ToSpeak, TALKVOLUME_TALK));
    }
 }
