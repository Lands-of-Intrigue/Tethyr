//::///////////////////////////////////////////////
//:: Lock Bending
//:: mil_lock_bending.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Set the animation type to lock the prisoner in.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////
void main()
{
    object  oShackle        = GetLocalObject(GetPCSpeaker(), "mil_Shackles");      // The Shackle

    SetLocalInt(oShackle, "mil_LockAnimation", ANIMATION_LOOPING_GET_LOW);
}
