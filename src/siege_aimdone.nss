////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_aimdone:
// Finalizes the aiming process of any seige weapon other than a ram.
////////////////////////////
// v1.1: Changed the way that the PC escapes the turning radius.

#include "x0_i0_position"
#include "siege_include"

void main()
{
object oPC = GetLocalObject(OBJECT_SELF, "aiming_PC");

if(GetDistanceToObject(oPC) <= DIST_AIMFIRE) //Is the PC still close enough?
{
    float fFacing = GetFacing(oPC);

    SetFacing(fFacing); //Then turn, baby, turn. Removed delay in 1.1

//    AssignCommand(oPC, ActionMoveAwayFromObject(OBJECT_SELF, TRUE, 5.0)); //So we dont get stuck in geometry
//    DelayCommand(1.5, AssignCommand(oPC, ClearAllActions()));
//    DelayCommand(1.6, AssignCommand(oPC, ActionForceMoveToObject(OBJECT_SELF, TRUE, 2.0, 10.0)));
// Dropped previous three functions in 1.1 for this:
    DelayCommand(0.1, AssignCommand(oPC, JumpToObject(OBJECT_SELF)));
    SpeakString("Aimed!");
} else
{
    SendMessageToPC(oPC, "Aiming failed: You moved too far.");
}

DelayCommand(5.0, SetLocalInt(OBJECT_SELF, "in_use", FALSE));
}
