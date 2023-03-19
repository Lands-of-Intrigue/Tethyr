////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_aimstart:
// Begins the aiming process of any seige weapon other than a ram.
////////////////////////////
// Slightly changed code in 1.1

#include "siege_include"

void main()
{
object oPC = GetPCSpeaker();
SetLocalObject(OBJECT_SELF, "aiming_PC", oPC);
SendMessageToPC(oPC, "Aiming...");

if(AIM_TIME >= 4.0)
    DelayCommand(AIM_TIME - 2.0, SendMessageToPC(oPC, "2 seconds..."));

DelayCommand(AIM_TIME, ExecuteScript("siege_aimdone", OBJECT_SELF));
}
