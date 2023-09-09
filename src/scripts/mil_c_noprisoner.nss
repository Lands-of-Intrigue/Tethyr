//::///////////////////////////////////////////////
//:: Condition test No Prisoner
//:: mil_c_noprisoner.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Returns true if the lock is not currently in use.
    Also contains garbage collection to reset the lock if it thinks that it is in use,
    but the prisoner is no longer valid.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////
int StartingConditional()
{
    object  oPC             = GetPCSpeaker();                           // The user
    object  oShackle        = GetLocalObject(oPC, "mil_Shackles");      // The Shackle
    int     InUse           = GetLocalInt(oShackle, "mil_InUse");

    // If the lock is currently being used...
    if (InUse > 0 ) {
        // If the prisoner is no longer valid...
        if ( !GetIsObjectValid(GetLocalObject(oShackle, "mil_Prisoner")) ) {
            // Reset everything.
            DeleteLocalObject(oShackle, "mil_Prisoner");
            SetLocalInt(oShackle, "mil_InUse", 0);
            InUse = 0;
        }
    }

    // Set custom token to contain the name of the Lock.
    SetCustomToken(9005, GetName(oShackle));

    // See if the shackles are in use.
    return !InUse;
}
