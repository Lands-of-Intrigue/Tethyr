//::///////////////////////////////////////////////
//:: Move Prisoner
//:: mil_moveprisoner.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Moves the prisoner attached to the lock.

    Assumes the following Local Variables to be set:
    mil_Shackles - the object to lock the Creature to.  Set on the Caller object.
    mil_LockAnimation - the animation to lock the Creature in.  Set on the Lock object.
    mil_Prisoner - the creature to lock down.  Set on the Lock object.
    mil_TurnDirection - the direction to turn the creature.  Set on the Lock object.
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
    string  sPrisonerGender;

    // If the lock is currently being used.
    if (InUse > 0) {
        ActionPauseConversation();

        // Free player
        AssignCommand(oPrisoner, ClearAllActions());
        SetCommandable(TRUE, oPrisoner);

        // Get variables.
        int LockAnimation = GetLocalInt(oShackle, "mil_LockAnimation");
        float TurnDirection = GetLocalFloat(oShackle, "mil_TurnDirection");

        if (TurnDirection > 0.0f)  {
            // Turn the Prisoner if called a direction was set.
            float NewDirection = GetFacing(oPrisoner) + TurnDirection;

            if (NewDirection > 360.0f) NewDirection -= 360.0f;

            AssignCommand(oPrisoner, SetFacing(NewDirection));
        }   else    {
            // Else they are just being moved into a new animation, Emote that change.
            string ToSpeak;

            // Build the Gender string.
            if (GetGender(oPrisoner) == GENDER_MALE) {
                sPrisonerGender = "his";
            } else if (GetGender(oPrisoner) == GENDER_FEMALE) {
                sPrisonerGender = "her";
            }

            // Build the Emote string based on the animation selected.
            switch (LockAnimation) {
                case ANIMATION_LOOPING_TALK_PLEADING:
                    ToSpeak = "**" +GetName(oPC) + " has forced " + GetName(oPrisoner) + " to " + sPrisonerGender + " feet.**";
                    break;
                case ANIMATION_LOOPING_MEDITATE:
                    ToSpeak = "**" +GetName(oPC) + " has forced " + GetName(oPrisoner) + " to " + sPrisonerGender + " knees.**";
                    break;
                case ANIMATION_LOOPING_DEAD_BACK:
                    ToSpeak = "**" +GetName(oPC) + " has forced " + GetName(oPrisoner) + " to " + sPrisonerGender + " back.**";
                    break;
                case ANIMATION_LOOPING_DEAD_FRONT:
                    ToSpeak = "**" +GetName(oPC) + " has forced " + GetName(oPrisoner) + " to the ground.**";
                    break;
                case ANIMATION_LOOPING_GET_LOW:
                    ToSpeak = "**" +GetName(oPC) + " has bent " + GetName(oPrisoner) + " over the " + GetName(oShackle) + ".**";
                    break;
            }
            // Speak the emote
            AssignCommand(oShackle, SpeakString(ToSpeak, TALKVOLUME_TALK));
        }

        // Apply the animation
        AssignCommand(oPrisoner, PlayAnimation(LockAnimation, 1.0, LockDuration));

        // Paralize player
        DelayCommand(1.0,SetCommandable(FALSE, oPrisoner));

        ActionResumeConversation();
    } else {
        string ToSpeak = "There is no prisoner attacked to that item.";
        AssignCommand(oShackle, SpeakString(ToSpeak, TALKVOLUME_TALK));
    }
 }
