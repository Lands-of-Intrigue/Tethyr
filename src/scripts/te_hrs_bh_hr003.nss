//Buying Horse
//Copyright Function(D20)
//By David Novotny
// 7/17/2016

#include "x3_inc_horse"
void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    TakeGoldFromCreature(300, oPC, TRUE);
    //Brost Pony (Saddled Barded)
    HorseCreateHorse("te_br_hr003", GetLocation(oPC), oPC);
}
