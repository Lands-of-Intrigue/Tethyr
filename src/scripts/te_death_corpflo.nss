#include "loi_xp"

void main()
{
    object oPC = GetLastKiller();
    object oPlace = OBJECT_SELF;

    if(GetHitDice(oPC) <= 8)
    {
        AwardXP(oPC,25);
    }
    else
    {
        SendMessageToPC(oPC,"You gain no meaningful experience from this encounter.");
    }
}
