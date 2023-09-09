//::///////////////////////////////////////////////
//:: Turn Prisoner 45 degrees
//:: mil_turn045.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Sets the direction to move the prisoner.

    Calls the Move Prisoner script to do the actual work.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////
void main()
{
    object  oShackle        = GetLocalObject(GetPCSpeaker(), "mil_Shackles");          // The Shackle

    SetLocalFloat(oShackle, "mil_TurnDirection", 45.0f);

    ExecuteScript("mil_moveprisoner", OBJECT_SELF);
}
