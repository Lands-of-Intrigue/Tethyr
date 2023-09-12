//::///////////////////////////////////////////////
//:: Use Shackles
//:: mil_useshackle.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Sets local variable "mil_Shackles" on the PC using the Lock, containing a link back to the Lock.
    Opens a conversation with the PC.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On:
//:://////////////////////////////////////////////

void main()
{
    object oPC=GetLastUsedBy();
    SetLocalObject(oPC, "mil_Shackles", OBJECT_SELF);
    AssignCommand(oPC, ActionStartConversation(oPC, "mil_shackle", TRUE));
}
