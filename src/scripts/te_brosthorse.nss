//::///////////////////////////////////////////////
//:: FileName te_brosthorse
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/12/2016 7:53:31 PM
//:://////////////////////////////////////////////
#include "x3_inc_horse"
void main()
{

    // Remove some gold from the player
    TakeGoldFromCreature(10, GetPCSpeaker(), TRUE);
    HorseCreateHorse("te_br_hr001", GetLocation(GetPCSpeaker()),GetPCSpeaker());
}
