//::///////////////////////////////////////////////
//:: Condition test Lock In Use
//:: mil_c_lockinuse.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Returns true if they lock is currently in use.
    Sets custom token 9000 to contain the name of the prisoner.
    Sets custom token 9005 to contain the name of the lock.
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

    SetCustomToken(9000, GetName(GetLocalObject(oShackle, "mil_Prisoner")));

    SetCustomToken(9005, GetName(oShackle));

    // See if the shackles are in use.
    return InUse;
}
