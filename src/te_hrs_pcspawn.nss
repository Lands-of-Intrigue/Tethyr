//::///////////////////////////////////////////////
//:: FileName te_hrs_pcspawn
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/5/2017 9:12:46 PM
//:://////////////////////////////////////////////
#include "x3_inc_horse"

void main()
{

    object oItem = GetItemPossessedBy(GetPCSpeaker(), "te_hrs_rec");
    string sTag = GetLocalString(oItem,"sHorse");

    TakeGoldFromCreature(10, GetPCSpeaker(), TRUE);
    HorseCreateHorse(sTag, GetLocation(GetPCSpeaker()), GetPCSpeaker());
}

