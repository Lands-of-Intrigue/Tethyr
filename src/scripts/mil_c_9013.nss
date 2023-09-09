//::///////////////////////////////////////////////
//:: Condition Test 9013
//:: mil_c_9013.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
     Display this conversation branch if the the associated Creature is valid.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////
int StartingConditional()
{
    object  oPC             = GetPCSpeaker();                           // The user
    object  oShackle        = GetLocalObject(oPC, "mil_Shackles");      // The Shackle
    object  oPrisoner       = GetLocalObject(oPC, "mil_PC9013");        // New prisoner

    return GetIsObjectValid(oPrisoner);
}
