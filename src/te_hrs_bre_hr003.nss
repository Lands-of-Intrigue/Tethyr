//Buying Horse
//Copyright Function(D20)
//By David Novotny
// 7/17/2016

#include "x3_inc_horse"
void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    if (oItem == OBJECT_INVALID)
    {
        CreateItemOnObject("te_hrs_rec",oPC,1,"te_hrs_rec");
        oItem = GetItemPossessedBy(oPC, "te_hrs_rec");
    }

    SetLocalString(oItem, "sHorse","te_br_hr003");

    TakeGoldFromCreature(350, oPC, TRUE);
    //Brost Pony (Leather Barded)
    HorseCreateHorse("te_br_hr003", GetLocation(oPC), oPC);
}
