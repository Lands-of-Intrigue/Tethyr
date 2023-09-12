//::///////////////////////////////////////////////
//:: Move Prisoner Kneeling
//:: mil_mp_kneel.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Sets the new animation to move the prisoner into.

    Calls the Move Prisoner script to do the actual work.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////
void main()
{
    object  oShackle        = GetLocalObject(GetPCSpeaker(), "mil_Shackles");          // The Shackle

    SetLocalInt(oShackle, "mil_LockAnimation", ANIMATION_LOOPING_MEDITATE);
    SetLocalInt(oShackle, "mil_TurnDirection", 0);

    ExecuteScript("mil_moveprisoner", OBJECT_SELF);
}
