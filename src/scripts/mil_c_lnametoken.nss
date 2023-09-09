//::///////////////////////////////////////////////
//:: Condition test Lock Name Token
//:: mil_c_lnametoken.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Sets custom token 9005 to contain the name of the lock, always returns true.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////
int StartingConditional()
{
    object  oPC             = GetPCSpeaker();                           // The user
    object  oShackle        = GetLocalObject(oPC, "mil_Shackles");      // The Shackle

    SetCustomToken(9005, GetName(oShackle));

    return TRUE;
}
