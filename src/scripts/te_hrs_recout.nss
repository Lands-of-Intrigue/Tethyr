//Buying Horse
//Copyright Function(D20)
//By David Novotny
// 7/17/2016

#include "x3_inc_horse"
void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "te_hrs_rec");
    string sHorse = GetLocalString(oItem, "sHorse");

    TakeGoldFromCreature(10, oPC, TRUE);
    HorseCreateHorse(sHorse, GetLocation(oPC), oPC);
}
